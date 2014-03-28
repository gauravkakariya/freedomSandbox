/*
	
	Revision History:
	
    Version     Version Author     Date        Comments
    1.0         --           	   --	  		Initial Draft
    2.0			Manasi			   06/07/2011	Issue Id :F0072:
    											In getReferralDetails function it was throwing an exception while checking null conditions.
    					  						So replaced && by ||in if condition
  	2.0			Manasi			   06/07/2011	Issue Id :FS0121:
												Function : getReferralDetails :
												Commented previous code. And removed condition after ||
*/

public class PlannerEvaluation {

    public Boolean flag { get; set; }
        private String startDate;
        private String endDate;  
        private Map<Id, String> idList = new Map<Id, String>();
        
        private List<String> sources= new List<String>{'BNI','Client/Lead Referral','Referral','Corp Comm','Employee Referral','NDC','Seminar (MKT)','Seminar (WS)','Web'};
        private Map<String,Lead[]> leadsMonthMap2 = new Map<String,Lead[]>();
   
        private List<userMonthlyLeadsWrapper> userMonthlyLeadsWrapperList = new List<userMonthlyLeadsWrapper>();
        private List<Lead> allLeads = new List<Lead>();
        private User loggedInUser;      
        private List<String> workstation ;
        private List<String> roles = new List<String>{'Mgr.-Financial Planning[AMETHYST MUMBAI]','Sr.Mgr.FP-AMETHYST','Sr.Mgr.FP - GALAXY'};
        private List<String> allMonths;
        private List<Account> allEntities = new List<Account>();
        private List<Id> favourableEntites = new List<Id>(); 
        private Map<Id,Account> accountsMap = new Map<Id,Account>();
        public String TotalReferrals{get;set;}
        public String ConvertedReferrals{get;set;} 
        public String percentageOfReferralConversion{get;set;}
        public String numberOfTestimonialsReceived{get;set;}
        public String idealReferrals{get;set;}
        public String percentageOfReferrals{get;set;}
        public Double referralsObtained {get;set;}
        
        public PlannerEvaluation(){
                getLoggedInUser();
                getUserList();
                flag = false;
        }
        
      /*  public void reset(){
        	userMonthlyLeadsWrapperList=null;
        	allEntities=null;
        	ConvertedReferrals= null;
        	percentageOfReferralConversion=null;
        	numberOfTestimonialsReceived=null;
        	idealReferrals=null;
        	percentageOfReferrals=null;
        	referralsObtained=null;
        	leadsMonthMap2=null;
        	allLeads=null;
        	allMonths=null;
        	accountsMap=null;
        }
        */
        public String getStartDate(){
        return this.startDate;
        }
        public void setStartDate(String startDate){
                this.startDate = startDate;
        } 
        public String getEndDate(){
                return this.endDate;
        }
        
        public void setEndDate(String endDate){
                this.endDate = endDate;
                
        }
        
        public Id plannerName{get;set;}
        
      
                
        public User getLoggedInUser()
        {
        	this.loggedInUser = [select Id, Name, UserRoleId, Workstations__c from User where Id = :Userinfo.getUserId()];
            return this.loggedInUser;
        }
        
        public Map<Id, Id> getPlannerRoles()
        {
	        Map<Id,Id> roleList = new Map<Id,Id>();
	        for(UserRole ur: [select Id, Name from UserRole where Name IN :roles])
	        {
	        	roleList.put(ur.Id, ur.Id);
	        }
	        return roleList;
        }
        
        public void getUserList()
        {
        	if(idList == null || idList.isEmpty())
            {
            	//System.debug('Workstation'+loggedInUser.Workstations__c);
                if(this.loggedInUser.Workstations__c.equals(Label.Workstation_All) || getPlannerRoles().containsKey(this.loggedInUser.UserRoleId ))
                {
                	if(this.loggedInUser.Workstations__c.equals(Label.Workstation_All))
                	{            
                    	System.debug('workstation all');
                        workstation = new List<String>{Label.Workstation_1,Label.Workstation_2,Label.Workstation_3};
                        // System.debug('workstation '+workstation);
                    }
                    else
                    {
                    	workstation = new List<String>{this.loggedInUser.Workstations__c};
                    }
                    for(User u: [select Id, Name, Workstations__c from User where Workstations__c IN :workstation and isActive=true])
                    {
                    	idList.put(u.Id, u.Name);
                    }
                }
                else
                {
                	idList.put(this.loggedInUser.Id,this.loggedInUser.Name);
                }
            }
                
        }///getUserListEnds
        
        
        
        public List<SelectOption> getItems(){
                List<SelectOption> options = new List<SelectOption>();
                for(Id id: idList.keyset()){
                        options.add(new SelectOption(id,idList.get(id)));
                }
                return options;
        }
         
        public Date formateDate(String dateString){
                      String[] stringDate = dateString.split('/');
                      Integer m =  Integer.valueOf(stringDate[0]);
                      Integer d = Integer.valueOf(stringDate[1]);
                      Integer y = Integer.valueOf(stringDate[2]);
                      return date.newInstance(y,m,d);
        }  
        public List<Lead> getLead(){
                
                System.debug('flag'+flag);
                System.debug('startDate'+this.startDate);
                System.debug('endDate'+this.endDate);
                System.debug('plannerId'+plannerName);
                if(this.startDate!=null && this.endDate!=null){
                allLeads= [select Id,OwnerId,Appointment_Time__c,LeadSource,Status,CreatedDate  from Lead where OwnerId = :plannerName
                                 AND CreatedDate >= :formateDate(this.startDate)
                                 AND CreatedDate <= :formateDate(this.endDate)
                                 AND LeadSource IN: sources];
                system.debug('****allLeads*******'+allLeads);
                                 return allLeads;
                }
                else{
                        return null;
                }
        }
        
         public List<userMonthlyLeadsWrapper> getuserMonthlyLeadsWrapperList(){
                return userMonthlyLeadsWrapperList;
         }
         
        public PageReference getReport(){
                //System.debug('endDate in getReport'+this.endDate);
               // System.debug('plannerId in getReport'+plannerName);
               // reset();
                Pagereference pr=null;
                flag = true;
               
                //System.debug('flag in wrapper:'+flag);
                for(Lead ld:getLead()){///////////iterate through all leads to group by month
                        if(!leadsMonthMap2.isEmpty() && leadsMonthMap2.containsKey(ld.CreatedDate.month().format())){
                            leadsMonthMap2.get(ld.CreatedDate.month().format()).add(ld);
                        }
                        else{
                                List<Lead> ldList = new List<Lead>();
                                ldList.add(ld);
                                leadsMonthMap2.put(ld.CreatedDate.month().format(),ldList);      
                        }
                }
                Map<String,Lead[]> leadsMonthMap = new Map<String,Lead[]>(); 
                for(String month:leadsMonthMap2.keySet()){
                                   if(!leadsMonthMap2.isEmpty()){
                                        if(leadsMonthMap2.containsKey('1')){
                                                leadsMonthMap.put('January',leadsMonthMap2.get('1'));
                                        }
                                        if(leadsMonthMap2.containsKey('2')){
                                                leadsMonthMap.put('February',leadsMonthMap2.get('2'));
                                        }
                                        if(leadsMonthMap2.containsKey('3')){
                                                leadsMonthMap.put('March',leadsMonthMap2.get('3'));
                                        }
                                        if(leadsMonthMap2.containsKey('4')){
                                                leadsMonthMap.put('April',leadsMonthMap2.get('4'));
                                        }
                                        if(leadsMonthMap2.containsKey('5')){
                                                leadsMonthMap.put('May',leadsMonthMap2.get('5'));
                                        }
                                        if(leadsMonthMap2.containsKey('6')){
                                                leadsMonthMap.put('June',leadsMonthMap2.get('6'));
                                        }
                                        if(leadsMonthMap2.containsKey('7')){
                                                leadsMonthMap.put('July',leadsMonthMap2.get('7'));
                                        }
                                        if(leadsMonthMap2.containsKey('8')){
                                                leadsMonthMap.put('August',leadsMonthMap2.get('8'));
                                        }
                                        if(leadsMonthMap2.containsKey('9')){
                                                leadsMonthMap.put('September',leadsMonthMap2.get('9'));
                                        }
                                        if(leadsMonthMap2.containsKey('10')){
                                                leadsMonthMap.put('October',leadsMonthMap2.get('10'));
                                        }
                                        if(leadsMonthMap2.containsKey('11')){
                                                leadsMonthMap.put('November',leadsMonthMap2.get('11'));
                                        }
                                        if(leadsMonthMap2.containsKey('12')){
                                                leadsMonthMap.put('December',leadsMonthMap2.get('12'));
                                        }
                               }
                }
                
                for(String month:leadsMonthMap.keySet()){///////////////iterate through all the months
                     List<plannerMonthlyLeadsWrapper> plannerMonthlyLeadsWrapperList = new List<plannerMonthlyLeadsWrapper>();
                        Map<String,Lead[]> leadSourceMap = new Map<String,Lead[]>();
                        for(Lead lead: leadsMonthMap.get(month)){/////iterate through the leads of every month to group by leadsource
                                if(!leadSourceMap.isEmpty()&& leadSourceMap.containsKey(lead.LeadSource)){
                                        leadSourceMap.get(lead.LeadSource).add(lead);
                                }       
                                else{
                                        List<Lead> leadsList = new List<Lead>();
                                        leadsList.add(lead);
                                        leadSourceMap.put(lead.LeadSource,leadsList);
                                }
                        }
                        
                        for(String ldSource:leadSourceMap.keySet()){//////iterate through the leadsources 
                                List<Lead> meetingDoneLeads = new List<Lead>();
                                List<Lead> convertedLeads = new List<Lead>();
                                for(Lead ld:leadSourceMap.get(ldSource)){
                                        if(ld.Status=='Meeting Done'){
                                                meetingDoneLeads.add(ld);
                                        }
                                        else if(ld.Status=='Converted'){
                                                convertedLeads.add(ld);
                                                if(ld.Appointment_Time__c!=null){
                                                    meetingDoneLeads.add(ld);
                                                }
                                        }
                                        else if(ld.Status=='Not Interested' && ld.Appointment_Time__c!=null){
                                            meetingDoneLeads.add(ld);
                                        }
                                }
                                
                                plannerMonthlyLeadsWrapper wrapper = new plannerMonthlyLeadsWrapper(ldSource,leadSourceMap.get(ldSource).size().format(),meetingDoneLeads.size().format(),convertedLeads.size().format());
                                plannerMonthlyLeadsWrapperList.add(wrapper);
                                
                        }
                        
                        userMonthlyLeadsWrapper umlw = new userMonthlyLeadsWrapper(plannerName,month,plannerMonthlyLeadsWrapperList);
                        userMonthlyLeadsWrapperList.add(umlw);
                }/////-------for every month "for loop" ends here
              flag = true;
             // System.debug('flag'+flag);
              getExecutionDetails(); 
              getPlanApprovalDetails();
              getReferralDetails();
              getTestimonialDetails();
             
              return pr;
        }
        
        public class userMonthlyLeadsWrapper{
                public string plannerName {get;set;}
                public string month {get;set;}
                public List<plannerMonthlyLeadsWrapper> plannerMonthlyLeadsWrapperList {get; set;}
                
                public userMonthlyLeadsWrapper(string plannerName,string month,List<plannerMonthlyLeadsWrapper> plannerMonthlyLeadsWrapperList){
                        this.plannerName=plannerName;
                        this.month = month;
                        this.plannerMonthlyLeadsWrapperList=plannerMonthlyLeadsWrapperList;
                }
        }
        
        public class plannerMonthlyLeadsWrapper{
                
                public String leadSource {get;set;}
                public String totalLeads {get;set;}
                public String totalMeetingsDone {get;set;}
                public String totalConversions {get;set;}
                
                public plannerMonthlyLeadsWrapper(String leadSource,String totalLeads,String totalMeetingsDone,String totalConversions){
                        
                        this.leadSource=leadSource;
                        this.totalLeads=totalLeads;
                        this.totalMeetingsDone=totalMeetingsDone;
                        this.totalConversions=totalConversions;
                }
        }
               
             
        public void getExecutionDetails(){
             
            List<Execution_Tracker__c> favourableTrackers = new List<Execution_Tracker__c>();
            Map<Id,Execution_Tracker__c[]> accountTrackersMap = new Map<Id,Execution_Tracker__c[]>(); 
             
            allEntities = [select Id,Name,PA_PP__c,CreatedDate,Testimonial_received__c from Account where OwnerId = :plannerName AND Entity_Status__c='Active' And RecordType.Name='Client'];
            for(Account acc:allEntities){
                accountsMap.put(acc.Id,acc);
            }
            System.debug('accountsMap'+accountsMap);
            List<Execution_Tracker__c> allExecutionTrackers = [select Id,CreatedDate,Entity_Name__c from Execution_Tracker__c where Entity_Name__c IN: accountsMap.keyset()];
            System.debug('allExecutionTrackers'+allExecutionTrackers);
            for(Execution_Tracker__c tracker: allExecutionTrackers){
                System.debug('trackerCreatedDate'+tracker.CreatedDate);
                DateTime entityCreationDate =  accountsMap.get(tracker.Entity_Name__c).CreatedDate;
                System.debug('entityCreationDate'+entityCreationDate);
                Datetime plusSixMonths =  entityCreationDate.addMonths(6);
                System.debug('plusSixMonths'+plusSixMonths);
                if(tracker.CreatedDate < plusSixMonths ){
                    if(!accountTrackersMap.isEmpty() && accountTrackersMap.containsKey(tracker.Entity_Name__c)){
                        accountTrackersMap.get(tracker.Entity_Name__c).add(tracker);
                    }       
                    else{
                        List<Execution_Tracker__c> trackerList = new List<Execution_Tracker__c>();
                        accountTrackersMap.put(tracker.Entity_Name__c,trackerList);
                    }
                }
            }
            System.debug('accountTrackersMap'+accountTrackersMap);
            for(Id entityId:accountTrackersMap.keySet()){////check here for atleast 2 executions
                List<Execution_Tracker__c> trackersList = accountTrackersMap.get(entityId);
                System.debug('trackersList'+trackersList);
                if(trackersList.size()>=1){
                    favourableEntites.add(entityId);
                }
            }
        }
        
        public String getTotalEntities(){
            return allEntities.size().format();
        }
        
        public String getFavourableEntities(){
            return favourableEntites.size().format();
        }
        
        public String getPercentageOfFavourableEntities()
        {
        	Double percent = 0.0;
        	if(favourableEntites != null && favourableEntites.size() > 0)
        	{
            	Double favSize = Double.valueOf(favourableEntites.size());
            	Double allEntitiesSize = Double.valueOf(allEntities.size());
            	if(favSize != 0 && allEntitiesSize != 0)
            		percent =  favSize/allEntitiesSize*100;
        	}
            return percent.format();
        }
        
        List<Id> favourablePlanApprovalEntites = new List<Id>();
       public void getPlanApprovalDetails()
       {
	        for(Account entity:allEntities)
	        {        
	            if(entity.PA_PP__c <= 45)
	              favourablePlanApprovalEntites.add(entity.Id);
	        }
       }
       
       public String getFavourablePlanApprovals(){
             return favourablePlanApprovalEntites.size().format();
       }
       
       public String getPercentageOfPlanApproval(){
            Double favPlanApprovals = Double.valueOf(favourablePlanApprovalEntites.size());
            Double allEntitiesSize = Double.valueOf(allEntities.size());
            Double percent = 0.0;
            if(allEntitiesSize != 0)
              percent = favPlanApprovals/allEntitiesSize*100;
            
            return percent.format();
       }
       
       
       public void getReferralDetails()
       {
            List<Account> anYearOldEntites = new List<Account>();
			/** Eternus Solutions   **/
			/** Author  : Manasi Ranade **/
			/** Issue Id: F0072      	**/
			/** Date    : 06/07/2011 	**/
			/** Purpose : It was throwing an exception while checking null conditions.
    					  So replaced && by ||in if condition.
			/****************************************************/
			/** Eternus Solutions   **/
			/** Author  : Manasi Ranade **/
			/** Issue Id: FS0121      	**/
			/** Date    : 8/20/2011 	**/
			/** Purpose : Commented previous code. And removed condition after || 
			/****************************************************/			    											
            //Previous if condition
            //if(plannerName != null || plannerName != '')
            if(plannerName != null)
            {
	            List<Account> accountReferrals = [Select a.Referred_by_Entity__c,a.Referred_by_Lead__c,a.Name From Account a where a.PersonLeadSource ='Client/Lead Referral' AND OwnerId = :plannerName];
	            ConvertedReferrals = accountReferrals.size().format();
	            List<Lead> leadReferrals = [Select a.Referred_by_Entity__c,a.Referred_by_Lead__c,a.Name From Lead a where a.LeadSource ='Client/Lead Referral' AND Status!='Converted' AND OwnerId = :plannerName];
	            referralsObtained = accountReferrals.size() + leadReferrals.size();
	            TotalReferrals = (accountReferrals.size() + leadReferrals.size()).format();
            }
            if(allEntities != null && allEntities.size() > 0)
            {
	            for(Account acc:allEntities)
	            {
	                if(System.today() >=   acc.CreatedDate.addDays(365)){
	                        anYearOldEntites.add(acc);
	                }
	                 Integer i = (anYearOldEntites.size()*6);
	                 idealReferrals=i.format();
	                Double ir = Double.valueOf(anYearOldEntites.size()*6);
	       			Double ro = Double.valueOf(referralsObtained);
	       			Double d;
	       			if(ir!=0){
	       				d  = (ro/ir*100);
	       			}
	                else{
	                        d=0;
	                }
	                percentageOfReferrals = d.format();
	            }
            }
       }
       
       public void getTestimonialDetails()
       {
            Integer i=0;
            for(Account acc:allEntities){
	            if(acc.Testimonial_received__c=='Yes'){
	                    i++;
	            }
            }   
           numberOfTestimonialsReceived = i.format();              
       }
}