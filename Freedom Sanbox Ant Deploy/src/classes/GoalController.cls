/*
  Revision History:
  Version     Version Author     Date        Comments
    1.0         --                --       Initial Draft
    2.0      Niket Chandane  15/06/2011    Added the property to show the goal target amount on the Goap calculation outputpage.
    2.0      Manasi Ranade  2/08/2011      1)Issue Id:FS0040 : Change in Constructor
                                             Changed the condition in the if statement from 'goalMappingBean.goalDetailBeanList[0] != 
                                             null' to goalMappingBean.goalDetailBeanList.size() > 0
                                           2)Issue Id:FS0031 : Change in output methode
                                             Commented code.
                                           If FutureTotalAmount is zero then we should not redirect to the next page
    2.0      Manasi Ranade  13/10/2011     1)Issue Id:FS0194 : Change in Function :output
                                             Passed the Sip data to the Goal output page
    2.0      Manasi Ranade  14/12/2011      Issue Id:FS0349 : Code Removed from Save function 
    2.0      Manasi Ranade  9/1/2012        Issue Id:FS0420 : Checked the size of Default year list before
                                            using it for the calculation
    2.0      Manasi Ranade  10/04/2012      Issue Id:00001584 : Commented Original code in output method.
                                            When we pass '%' symbol from query string it throws exception.
                                            So removed remark from querystring and fetched it on output coponent.

*/
public class GoalController 
{
    //FS0349 : Commented as not required now.Used existing selected object
    //public Goal__c objSelectedGoal {get;set;} 
    public List<SelectOption> lstSipStartYear {get;set;}
    
    public NewGoalService service {get;set;} 
    public GoalMappingBean goalMappingBean { get;set;}
    public String entityId {get;set;}
    public String goalId {get;set;}
    public Boolean displayPopUp { get;set;}
    
    // Added the property to show the goal target amount on the Goap calculation outputpage.  
    public Double FutureTotalAmount{get;set;} 
    public String sipYear{get;set;}
    //Added on : 31/1/2013 : Aditi Satpute : Hide Save button for Business Partner Financial Plan //Sanat
    public Boolean isDisplaySaveButton{get;set;}
    
    //Prajakta-Aditi - 9-5-13 
    public DatabaseSOQL databaseSOQLObj {get; set;}
    public DatabaseDML databaseDMLObj {get; set;}
    public Integer planGenerationDate {get; set;}
    public Boolean isDisplayCustomRiskProfile {get;set;}
    
    
    public GoalController() 
    {
    	databaseSOQLObj = new DatabaseSOQL();
    	databaseDMLObj = new DatabaseDML();
    	
        //Code Added on : 31/1/2013 : Aditi Satpute : Hide Save button for Business Partner Financial Plan : by default true //Sanat
        isDisplaySaveButton = true;
        isDisplayCustomRiskProfile = false;
        
        entityId = ApexPages.currentPage().getParameters().get('entityId');
        goalId = ApexPages.currentPage().getParameters().get('goalId');
        
        List<Account> accountList = databaseSOQLObj.getFamilyDetails(entityId); //Prajakta - 4-6-2013
        for(Account objAcc : accountList)
        {
        	system.debug('--objAcc-'+objAcc);
        	if(objAcc.Parent_Entity__c == null)
        	{
        		if(objAcc.Finametrica_Score__c != null && objAcc.Finametrica_Score__c > 0)
        		{
        			isDisplayCustomRiskProfile = true;
        		}
        		system.debug('--objAcc.Plan_Generation_Date__c--'+objAcc.Plan_Generation_Date__c);
        		planGenerationDate = objAcc.Plan_Generation_Date__c != null ? objAcc.Plan_Generation_Date__c.year() : system.today().year();
        		
        	}
        }
        
        //Added Code on : 31/1/2013 : Aditi Satpute : Hide Save button for Business Partner Financial Plan //Sanat
        User objUser = [Select Profile.Name, ProfileId, UserType, Name, Id From User where Id =: UserInfo.getUserId()];
        
        if(objUser.UserType.equalsIgnoreCase('PowerPartner'))
            isDisplaySaveButton = false;
        
        //FS0309 //FS0349 : Commented as not required now.Used existing selected object
        try{
            service = new NewGoalService();
           // service.getFamilyMembers(accountList);		//Prajakta - 4-6-2013
            
            List<String> goalList = new List<String>();
            if(goalId != null && goalId != '' && entityId != null && entityId != '')
            {
                goalList.add(goalId);
                //error.debugLog('---goalList-'+goalList);
                goalMappingBean = service.getGoalDetails(goalList , entityId).get(goalId);
            }
            
            sipYear = goalMappingBean.goalObj.SIP_Start_Year__c;
            //error.debugLog('-----SIP Start Year-------'+goalMappingBean.goalObj.SIP_Start_Year__c);
            /** Eternus Solutions - Manasi Ranade - FS0040 - 02/08/2011 **/
            /** Purpose : Changed the condition in the if statement from 'goalMappingBean.goalDetailBeanList[0] != 
                      null' to goalMappingBean.goalDetailBeanList.size() > 0
            /****************************************************/ 
            if(goalMappingBean != null && goalMappingBean.goalDetailBeanList != null && goalMappingBean.goalDetailBeanList.size() > 0)
            {
                //Previous Code - FutureTotalAmount = goalMappingBean.goalDetailBeanList[0].targetAmount;
                FutureTotalAmount = service.FutureTotalAmount;
            }
            System.debug('-------------------------goalMappingBean.goalDetailBeanList-----------------'+goalMappingBean.goalDetailBeanList);
        }
        catch(Exception ex) 
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ex.getMessage()));
        }
    }
    
    /*
      Action methods fires when we click on the Calculate button
    */
    public pageReference save()
    {        
        //try 
        {
            sipYear = goalMappingBean.goalObj.SIP_Start_Year__c;
            Boolean blnIsValidYear = service.saveGoal(goalMappingBean);
            /**  Manasi Ranade : FS0040 : 02/08/2011 : Chcked the size of Default year list before using it for the calculation*/ 
            List<String> goalList = new List<String>();
            goalList.add(goalId);
            goalMappingBean = service.getGoalDetails(goalList, entityId).get(goalId);
            //Error.debugLog(' goalMappingBean -->' + goalMappingBean);
            if(blnIsValidYear)
            {
            //	error.DebugLog('-----if-------');
                service.populateSIPCalculation(entityId,goalMappingBean);
            }
            /* Prajakta-Aditi - 9-5-13 - 
            	If Goal Start YEar is same as PGD year and if Goal SIP Amount data is 
            	already present in database then delete that data for particular goal*/ 
            else
            {
            	//error.DebugLog('--blnIsValidYear---else rec Deleted-------');
            	databaseDMLObj.deleteRecords(databaseSOQLObj.getSIPAmountList(goalId));
            	goalMappingBean.goalObj.OriginalGoalPV__c = 0;
             	databaseDMLObj.upsertObject(goalMappingBean.goalObj);
            }
            
            //Over write the newly calculated Retirement value to update.
            //Goal OutPut :Addition of all PV of retirement year
            /*if objSelectedGoal.Retirement_Amount__c is displayed on Retirement Goal related output page.So overwrite its value if it is 0. i.e. For the 1st time only.
              Because its value should remain same after allacating assets to it.
              */
            /** Manasi Ranade : FS0349 : 14/12/2011 : Code Removed from here and placed in NewGoalService:populateSIPCalculation()**/
            /*if(objSelectedGoal.Retirement_Amount__c <= 0 )
              objSelectedGoal.Retirement_Amount__c = goalMappingBean.goalObj.retirement_amount__c;*/
            displayPopUp = false;
            
            /* Prajakta - FP changes - 22-03-2013 */
            String allocationMsg = '';
            if(service.MapOrderToAllocatiotion.size() > 0)
            { 
                for(String str : service.MapOrderToAllocatiotion.values())
                {
                    allocationMsg += str + '~~';
                }
                goalMappingBean.goalObj.Allocation_Message__c = allocationMsg;
            }
            else
            {
                goalMappingBean.goalObj.Allocation_Message__c = '';
            }
            //goalMappingBean.goalObj.Include_SIP__c = true;		/*Prajakta - 12-06-2013*/
            update goalMappingBean.goalObj;
            
            
            if(goalMappingBean.goalObj.Allocation_Message__c != null)
            {
                goalMappingBean.lstAllocatedString = goalMappingBean.goalObj.Allocation_Message__c.split('~~');
                System.debug('-----------------goalMappingBean.lstAllocatedString------'+goalMappingBean.lstAllocatedString.size());
            }
            if(goalMappingBean.goalObj.SIP_Start_Year__c != null) 
            {
                goalMappingBean.SipYear = goalMappingBean.goalObj.SIP_Start_Year__c;
            }
        }
        //catch(Exception ex) 
        {
          //  ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,ex.getMessage()));
        }
        return null;
    }
    
    public List<SelectOption> savingTypeList 
    {
   		get {
      		return service.getSavingTypeList();
    	}                                
    }                         
    
    public pageReference customized() 
    {
        displayPopUp = true;
        return null;
    }
        
    public PageReference cancel() 
    {
        displayPopUp = false;
        return null;
    }
   
   	public boolean singleYearGoal
   	{
       	get
       	{
       		//system.debug('********goalMappingBean.goalStartYear*****'+goalMappingBean.goalStartYear);
       		//system.debug('********goalMappingBean.goalEndYear*****'+goalMappingBean.goalEndYear);
       		if(goalMappingBean != null)
	           	if((goalMappingBean.goalStartYear-goalMappingBean.goalEndYear)==1)
	               	return true;
	           	else
	            	return false;
	        return false;
       	}set;   
   	}
   
   	public goalMappingBean.GoalAssetMappingBean  currentGoalAsset {get;set;}
    
   	public pageReference output() 
   	{
      /** Manasi Ranade: FS0194 : 13/10/2011 : Passed the Sip data to the Goal output page**/
      	Double dblEquitySIP = 0,dblGoldSIP = 0,dblDebtSIP = 0,dblTotalSIP = 0;
      	PageReference pr =null;
      	if(FutureTotalAmount == null)
        	FutureTotalAmount = 0.0;
      		System.debug('------------1 : '+dblEquitySIP);
      	if(goalMappingBean.getSIPDetails != null && goalMappingBean.getSIPDetails.size() > 0)
      	{
        	System.debug('------------2 : '+dblEquitySIP);
        	GoalMappingBean.SIPBean objSIPBean = goalMappingBean.getSIPDetails.get(0);
        	if(objSIPBean.equityAmount != null)
          		dblEquitySIP = objSIPBean.equityAmount;
      		if(objSIPBean.gold != null)
          		dblGoldSIP = objSIPBean.gold;
        	if(objSIPBean.debt != null)
          		dblDebtSIP = objSIPBean.debt;
        	if(objSIPBean.totalValue != null)
          		dblTotalSIP = objSIPBean.totalValue;
         	System.debug('------------3 : '+dblEquitySIP);
      	}
      	System.debug('------------4 : '+dblEquitySIP);
      	//FS0309
       	System.debug('*******goalMappingBean.goalObj**in output********'+goalMappingBean.goalObj);
       
       	pr = new PageReference('/apex/GoalCalculationOutputPage?goalId='+goalId +'&entityId='+entityId +'&totalAmount='
            +FutureTotalAmount+'&dblEquitySIP='+dblEquitySIP+'&dblGoldSIP='+dblGoldSIP
            /**  Manasi Ranade : 00001584 : 10/04/2012 : Commented Original code.
                      When we pass '%' symbol from query string it throws exception.
                      So removed remark from querystring and fetched it on output coponent.***/ 
            //+'&dblDebtSIP='+dblDebtSIP+'&dblTotalSIP='+dblTotalSIP+'&tabname=Financial Planning'+'&Remark='+goalMappingBean.goalobj.Remark__c);
            +'&dblDebtSIP='+dblDebtSIP+'&dblTotalSIP='+dblTotalSIP+'&tabname=Financial Planning');
            /* Manasi Ranade : FS0031 : 02/08/2011 : Commented following code.- If  FutureTotalAmount is zero then we should not redirect to the next page **/ 
       	// pr.setRedirect(true);
        return pr;
    }
    
    /*Prajakta - FP changes - 15-04-2013 - Added Pick list for Investment Start YEar on Goal Calculation page */
    public List<selectOption> getSipStartYear()
    {
        List<selectOption> options = new List<selectOption>();
        List<Integer> lstYear = new List<Integer>();
        //options.add(new selectOption(String.valueOf(system.today().year()),String.valueOf(system.today().year())));
        //error.debugLog('------Goal Start Year------'+goalMappingBean.goalObj.Goal_Start_Year__c);
        //Integer goalStartYear = system.today().year();
         Integer goalStartYear = planGenerationDate;
        if(goalMappingBean.goalObj.Goal_Start_Year__c != null)	
        	goalStartYear = Integer.valueOf(goalMappingBean.goalObj.Goal_Start_Year__c);
        /* Prajakta - FP changes - 8-5-13 - Goal Start Year should not be same as Investment(SIP) start year.
        									Goal Start Year should not be same as Plan Generation Date year. */
        for(Integer currentYear = planGenerationDate - Integer.ValueOf(Label.SIP_Start_Year); currentYear <= goalStartYear; currentYear++)
        {
          // if(currentYear != system.today().year())
                options.add(new selectOption(String.valueOf(currentYear), String.valueOf(currentYear)));
        }
        return options;
    } 
    
    public void GoalProfilePicklist()
    {
       	List<Goal_Profile__c> goalProfileList = new  List<Goal_Profile__c>();
        String profileName;        
      	String strRiskProfile = '';
      	List<SelectOption> goalProfilePickList = new List<SelectOption>();
      	
  		if(goalMappingBean.goalObj.Risk_Profile__c != null)
  			strRiskProfile = goalMappingBean.goalObj.Risk_Profile__c;
  		goalProfileList.addAll(databaseSOQLObj.getStdGoalProfileList(strRiskProfile));
        goalProfileList.addAll(databaseSOQLObj.getCustomGoalProfileList(entityId));
        for(Goal_Profile__c goalProfile : goalProfileList) 
       	{
           	profileName = goalProfile.Name;
           	if('Customized'.equalsIgnoreCase(goalProfile.Goal_Profile_Type__c))
           	{
               	profileName = profileName + ' (Customized)';
           	}
           	goalProfilePickList.add(new SelectOption(goalProfile.id, profileName));             
       	}
       	goalMappingBean.goalProfileList = goalProfilePickList;
        
        
    } 
    
    public List<selectOption> getCustomRiskProfile()
    {
    	List<selectOption> options = new List<selectOption>();
        Schema.DescribeFieldResult field = Schema.sObjectType.Goal__c.fields.Risk_Profile__c;
        List<Schema.PicklistEntry> picklist = field.getPicklistValues();
        for(Schema.PicklistEntry p : picklist) 
        {
            options.add(new selectOption(p.getLabel(), p.getLabel()));
        }
        
        return options;
    }
}