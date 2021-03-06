/* Test Data for the test classes */

@isTest
public class TestData_Ffreedom 
{
	//public Account account{get;set;}
	Schema.DescribeSObjectResult DESCRIBE_RESULT = Account.SobjectType.getDescribe();
    Map<String, Schema.RecordTypeInfo> RECORD_TYPE_INFO_MAP = DESCRIBE_RESULT.getRecordTypeInfosByName();
    
	public List<User> initStandardUser()
	{
		List<User> standardUser = [select Id,ContactId from user where usertype = 'Standard' and Profile.Name like '%System Admin%' limit 1];
		return standardUser;
	}
	
    public User initializeUser()
    {
    	ID ProfileID = [ Select id from Profile where name = 'Financial Planner'].id;
      	User objUser = new User(email='test-user@fakeemail1.com', 
      							profileid = ProfileID, UserName='test-user@fakeemail1.com', 
      	 						alias='tuser11', CommunityNickName='tuser1',TimeZoneSidKey='America/New_York', 
      	 						LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US',
      	 						FirstName = 'Test_Parent_Fname1', LastName = 'Test_Parent_Lname1');
		return objUser;        
    }
    
    public Account initializeAccount(User objUser) 
    {
    	Account objAccount = new Account(LastName='Test Freedom', Adjustment_Factor__c='2', OwnerId = objUser.Id, Plan_Generation_Date__c=system.today(),
    									Entity_Status__c='Active',Email_Temp__c='abc@gmail.com',//IsSynched__c =false,
	                       PersonTitle='TestData',PersonBirthdate=system.today(),PersonHomePhone='54623676',PersonMobilePhone='9423230175',PAN_ID__pc='abcde4567M',
	                       Alternate_Mobile__c='356475',PersonEmail='sgdh@test.com', Alternate_E_Mail_Address__c='fdgr@test.com',PersonMailingStreet='aa',
	                       PersonMailingCity='bbb',Retirement_Year__c=2034,Residential_Status_del__c='own',Retirement_Age__c='58',Estimated_Life_Expectancy__c='67',
	                       Estimated_Life_EndYear__c=2041,Relationship_to_Entity__pc='husband', Related_To__c ='Ffreedom',
	                       RecordTypeId = RecTypes__c.getInstance('AccountClient').Record_Type_Value__c,Will__c = true);
    	return objAccount;
    }
    
	public Account initializeAccount() 
    {
    	Account objAccount = new Account(LastName='Test Freedom', Adjustment_Factor__c='2',
    									Entity_Status__c='Active', PersonTitle='TestData', Plan_Generation_Date__c=system.today(),
    									PersonBirthdate=system.today(),PersonHomePhone='54623676',PersonMobilePhone='9423230175',
				                       	Alternate_Mobile__c='356475',PersonEmail='sgdh@test.com', PAN_ID__pc='abcde4567M',
				                       	Alternate_E_Mail_Address__c='fdgr@test.com',PersonMailingStreet='aa',
				                       	PersonMailingCity='bbb',Retirement_Year__c=2034,Residential_Status_del__c='own',
				                       	Retirement_Age__c='58',Estimated_Life_Expectancy__c='67',
				                       	Estimated_Life_EndYear__c=2041,Relationship_to_Entity__pc='husband', 
				                       	Related_To__c ='Ffreedom',Email_Temp__c='abc@gmail.com',
				                       	Data_Collection_Date__c = date.today(), Finametrica_Score__c = null,
				                       	RecordTypeId = RecTypes__c.getInstance('AccountClient').Record_Type_Value__c,Will__c = true);
    	return objAccount;
    }
    
    public Account init_FamilyMember(Account parentAccount)
    {
    	Account child = new Account(FirstName='PQR',LastName='XYZ',
    								Parent_Entity__c=parentAccount.id,
	  								RecordTypeId=RecTypes__c.getInstance ('AccountFamily').Record_Type_Value__c);
		return child;	  								
    }
    
    public Account init_GeneralAccount() 
    {
    	RecordType objRT = [Select Id from RecordType where Name = 'General' and SobjectType = 'Account'];
  		Account objGeneralAccount = new Account(Name='Test',Expected_Return_on_Investment__c=10,Equity__c=10,Gold__c=10,Debt__c=10,
							         Income_Growth_Rate__c=10,Inflation_Rate__c=10,Default_Estimated_Life_Expectancy__c='58',Number_Of_Months__c=10,
							         Gold_Growth_Rate__c=10, Stock_Growth_Rate__c=10,Default_Retirement_Age__c='60', 
							         RecordTypeId = objRT.Id,Related_To__c ='Business Partner');
    	return objGeneralAccount;
    }
    
    public Contact init_BizContact(Account objGeneralAccount)
    {
    	Contact objBizContact = new Contact(FirstName='Partner Contact Test', 
    									LastName='Contact',
    									AccountId= objGeneralAccount.id);
    	return objBizContact;
    }
    
    public User initBusinessUser(Contact objBizContact)
    {
    	Profile prof = [select id  from profile where usertype = 'PowerPartner' limit 1];
        
        User partnerUser = new User(email='partner-user@fakeemail1.com', profileid = prof.Id, UserName='test-userPartner@fakeemail1.com', 
                                    alias='tuser12', CommunityNickName='tuser12',TimeZoneSidKey='America/New_York', ContactId = objBizContact.Id,
                                    LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US', FirstName = 'Test_Partner_Fname1',
                                    LastName = 'Test_Partner_Lname1' );
        //insert partnerUser;
      	system.debug('--------partnerUser--------'+partnerUser); 						
	    return partnerUser;
    }
    
    public Account initBusinessAccount(User partnerUser)
    {
    	Account objBusinessAccount = new Account(LastName='Test BP',Adjustment_Factor__c='2', OwnerId = partnerUser.Id,PAN_ID__pc='abcde4567M',
		                       PersonTitle='TestData',PersonBirthdate=system.today(),PersonHomePhone='54623676',PersonMobilePhone='9423230175',
		                       Alternate_Mobile__c='356475',PersonEmail='sgdh@test.com', Alternate_E_Mail_Address__c='fdgr@test.com',
		                       Email_Temp__c='abc@gmail.com', Plan_Generation_Date__c=system.today(),
		                       Retirement_Year__c=2034,Residential_Status_del__c='own',Retirement_Age__c='58',Estimated_Life_Expectancy__c='67',
		                       Estimated_Life_EndYear__c=2041,Relationship_to_Entity__pc='husband', Related_To__c ='Business Partner',
		                       RecordTypeId = RecTypes__c.getInstance('AccountClient').Record_Type_Value__c,Will__c = false);
		return objBusinessAccount;
    }
    
    public Account initVirtualAccount()
    {
    	RecordType objRT = [Select Id from RecordType where Name = 'General' and SobjectType = 'Account'];
		Account objVirtualAccount = new Account(Name='Test',Expected_Return_on_Investment__c=10,Equity__c=10,Gold__c=10,Debt__c=10,
									Income_Growth_Rate__c=10,Inflation_Rate__c=10,Default_Estimated_Life_Expectancy__c='58',Number_Of_Months__c=10,
									Gold_Growth_Rate__c=10,	Stock_Growth_Rate__c=10,Default_Retirement_Age__c='60', 
									RecordTypeId = objRT.Id,Related_To__c ='Virtual Partner');
	    return objVirtualAccount;
    }
    
    public Account initVirtualAccount(Account objAccount)
    {
    	Account initVirtualAccount = new Account(LastName='Test BP',Adjustment_Factor__c='2', Virtual_Partner__c = objAccount.Id,PAN_ID__pc='abcde4567M',
		                       PersonTitle='TestData',PersonBirthdate=system.today(),PersonHomePhone='54623676',PersonMobilePhone='5463754637',
		                       Alternate_Mobile__c='356475',PersonEmail='sgdh@test.com', Alternate_E_Mail_Address__c='fdgr@test.com',Email_Temp__c='abc@gmail.com',
		                       Retirement_Year__c=2034,Residential_Status_del__c='own',Retirement_Age__c='58',Estimated_Life_Expectancy__c='67',
		                       Estimated_Life_EndYear__c=2041,Relationship_to_Entity__pc='husband', Related_To__c ='Virtual Partner', Plan_Generation_Date__c=system.today(),
		                       RecordTypeId = RecTypes__c.getInstance('AccountClient').Record_Type_Value__c,Will__c = false);
		return initVirtualAccount;
    }
    
    public Lead init_Lead()
    {
    	Lead objLead = new Lead(FirstName='FirstName', LastName='LastName',
    							Occupation__c='Student',Location__c='Agra',
    							MobilePhone='9876543210', Street='S.V.Road',
    							City='Agra',PostalCode='400053',
    							State='MahaRashtra',Country='india',
    							Email='rupesh@gmail.com',
    							Company='TestCompany',Status='Open',LeadSource='Web');
		return objLead;    							
    }
    
    public Lead init_Lead(User objUser, String leadSource, String status)
    {
    	Lead objLead = new Lead(FirstName='Fname1', LastName='Lname',
    							OwnerId=objUser.Id,LeadSource=leadSource,Status=status,
    							Email='rupesh@gmail.com',
    							Probability__c='50%' ,Close_Date__c=System.today(),
    							Ffreedom_Score__c=40 ,Appointment_Time__c = System.today());
    	return objLead;
    }
    
    public Contact init_Contact(Account objAccount)
    {
    	Contact objContact = new Contact(FirstName='Parner Contact Test', 
    									LastName='Contact',
    									AccountId= objAccount.id);
    	return objContact;
    }
    
    public Goal__c initializeGoal(Account objAccount, String goalType)
    {
    	//Account objAccount = initializeAccount();
    	Goal__c objGoal = new Goal__c(Entity__c= objAccount.Id, 
    						Accumulated_Amount__c=0,Cost_of_Goal_Annual__c=55000,
    						Allocated_Equity__c=0,Allocated_Debt__c=0,
    						Allocated_Real_Estate__c=0,Allocated_Others__c=0,
    						Allocated_Gold__c=0,
    						Goal_Type__c=goalType);
    	return 	objGoal;				
    }
    
    public Goal__c initialize_Goal(Account objAccount, String goalType, Goal_Profile__c selectedGoalProfile)
    {
    	//Account objAccount = initializeAccount();
    	Goal__c objGoal = new Goal__c(Entity__c= objAccount.Id, 
    						Accumulated_Amount__c=0,Cost_of_Goal_Annual__c=55000,
    						Allocated_Equity__c=0,Allocated_Debt__c=0,
    						Allocated_Real_Estate__c=0,Allocated_Others__c=0,
    						Allocated_Gold__c=0,
    						Goal_Type__c=goalType,
    						Goal_End_Year__c = '2024',Goal_Start_Year__c='2021',
    						Inflation_Rate__c=6,
    						//SelectedGoalProfile__c=initialize_GoalProfile(objAccount,'Aggressive', 'Customized').Id,
    						SelectedGoalProfile__c=selectedGoalProfile.Id,
    						Saving_type__c='Constant annuity - Progressive Risk Profile',
	                        Priority__c='High',
	                        Description__c='Marriage', 
	                        aggressive_profile_years__c=3,Goal_Frequency__c=null,
	                        moderately_aggressive_profile_years__c=2, moderate_profile_years__c=2,
	                        Allocation_Message__c='Allocation_Message', SIP_Start_Year__c='2013',
	                        moderately_conservative_profile_years__c=2,
	                        conservative_profile_years__c=1);
    	return 	objGoal;				
    }
    
    public Portfolio_Report__c initialize_PortfolioReport(Account objAccount, String ScriptName, String portfolioType)
    {
    	Portfolio_Report__c objPortfolioReport = new Portfolio_Report__c( Entity__c=objAccount.Id,
    						Gain__c=10,Nav_p__c=10,Purchase_Amount__c=1000,
    						Folio_Number__c='23456348',Date__c=System.today(),
    						Absolute_Ret__c=0.81, Scheme_Scrip_Name__c=ScriptName,
    						Transaction_Type__c='SIP', Current_Value__c=2000,
    						Portfolio_Type__c=portfolioType, Units_Quanitity__c=100);
    	return objPortfolioReport;					
    }
    
    public GoalIAULIPAssociation__c init_GoalIAULIPAssociation(Goal__c goal, Portfolio_Report__c portfolio)
    {
    	GoalIAULIPAssociation__c objIAULIP = new GoalIAULIPAssociation__c(Goal__c = goal.Id, 
    											Portfolio_Report__c = portfolio.Id, 
    											Allocation__c = 0.0);
    	return objIAULIP;
    }
    
    public Entity_Global_Assumption__c initialize_GlobalAssumptions(Account objAccount)
    {
	    Entity_Global_Assumption__c objGlobal = new Entity_Global_Assumption__c 
	    										(Expected_Return_on_Investment__c = 8,
	    										Income_Growth_Rate__c=14,
	                                  			Inflation_Rate__c=10,
	                                  			Account__c=objAccount.Id,
	                                  			Number_Of_Months__c=50,
	                                  			Stock_Growth_Rate__c=14,
	                                  			Gold_Growth_Rate__c=10,
	                                  			Default_Estimated_Life_Expectancy__c='80',
	                                  			Default_Retirement_Age__c='60');    										
		 return objGlobal;  	 									
    }
    
    public Goal_Profile__c initialize_GoalProfile(Account objAccount, String profileName, String GoalProfileType)
    {
    	Goal_Profile__c objGoalProfile = new Goal_Profile__c(Name=profileName,
    										Goal_Profile_Type__c=GoalProfileType,
    										Debt_Allocation__c=23,Equity_Allocation__c=32,
    										Gold_allocation__c=33);
    	return objGoalProfile;									
    }
    
    public List<Goal_Profile__c> initialize_lstGoalProfile(Account objAccount)
    {
    	List<Goal_Profile__c> lstGoalProfile = new List<Goal_Profile__c>();
    	
    	Goal_Profile__c goalProfile1 = initialize_GoalProfile(objAccount, 'Aggressive', 'Standard');
	    lstGoalProfile.add(goalProfile1);
		Goal_Profile__c goalProfile3 = initialize_GoalProfile(objAccount, 'Moderately Aggressive', 'Standard');
	    lstGoalProfile.add(goalProfile3);
		Goal_Profile__c goalProfile4 = initialize_GoalProfile(objAccount, 'Moderate', 'Standard');
	    lstGoalProfile.add(goalProfile4);
	    Goal_Profile__c goalProfile5 = initialize_GoalProfile(objAccount, 'Moderately Conservative', 'Standard');
	    lstGoalProfile.add(goalProfile5);
		Goal_Profile__c goalProfile6 = initialize_GoalProfile(objAccount, 'Conservative', 'Standard');
		lstGoalProfile.add(goalProfile6);
		
		Goal_Profile__c goalProfile2 = initialize_GoalProfile(objAccount, 'Aggressive', 'Customized');
	    lstGoalProfile.add(goalProfile2);
	    Goal_Profile__c goalProfile7 = initialize_GoalProfile(objAccount, 'Moderately Aggressive', 'Customized');   
	    lstGoalProfile.add(goalProfile7);
	    Goal_Profile__c goalProfile8 = initialize_GoalProfile(objAccount, 'Moderate', 'Customized');   
	    lstGoalProfile.add(goalProfile8);
	    Goal_Profile__c goalProfile9 = initialize_GoalProfile(objAccount, 'Moderately Conservative', 'Customized');   
	    lstGoalProfile.add(goalProfile9);
	    Goal_Profile__c goalProfile10 = initialize_GoalProfile(objAccount, 'Conservative', 'Customized');   
	    lstGoalProfile.add(goalProfile10);
	    
	    return lstGoalProfile;
    }
    
    public Asset__c initialize_Asset(Account objAccount, String accountType, Id recId, String action)
    {
    	Asset__c asset = new Asset__c(Account_Type__c=accountType ,Accumulated_Value__c=200000,
    								Annual_Contribution__c=10000,Expected_Growth_Rate__c=5,
    								End_Year__c='2018',Start_Year__c='2011',
	                              	Entity__c=objAccount.id, Asset_Types__c = 'Asset',
	                              	action__c=action,
	                              	RecordTypeId=recId);
		return asset;                             		
    }
    
    public List<Asset__c> initialize_lstAsset(Account objAccount)
    {
    	List<Asset__c> lstAsset = new List<Asset__c>(); 
	    
	    Asset__c asset = initialize_Asset(objAccount,'EPF',AssetRecTypes__c.getInstance ('Retirement Accounts').RecordTypeId__c,'To be grown till maturity and continue saving');  
	    lstAsset.add(asset);
	    Asset__c asset1 = initialize_Asset(objAccount,'PPF',AssetRecTypes__c.getInstance ('Govt. Saving Schemes').RecordTypeId__c,'To be grown till maturity and continue saving');
	    lstAsset.add(asset1);
	    Asset__c asset2 = initialize_Asset(objAccount,'PPF',AssetRecTypes__c.getInstance ('Govt. Saving Schemes').RecordTypeId__c,'To be grown till maturity but stop saving more');
	    lstAsset.add(asset2);
	    Asset__c asset3 = initialize_Asset(objAccount,'PPF',AssetRecTypes__c.getInstance ('Govt. Saving Schemes').RecordTypeId__c,'Liquidate (Sell)');    
	    lstAsset.add(asset3);
	    Asset__c asset4 = initialize_Asset(objAccount,'PPF',AssetRecTypes__c.getInstance ('Govt. Saving Schemes').RecordTypeId__c,'Hold');
	    lstAsset.add(asset4);
	    Asset__c asset5 = initialize_Asset(objAccount,'PPF',AssetRecTypes__c.getInstance ('Govt. Saving Schemes').RecordTypeId__c,'Sell');
	    lstAsset.add(asset5);
	    
	    return lstAsset;
    }
    
    public GoalAssetAssociation__c intialize_GoalAssetAssociation(Asset__c asset, Goal__c goal)
    {
    	GoalAssetAssociation__c objGAA = new GoalAssetAssociation__c(Asset__c=asset.id,
    																Goal__c=goal.id,
    																Allocated__c=100);
    	return objGAA;
    }
    
    public Insurance__c initialize_Insurance(Account objAccount)
    {
    	Insurance__c  objInsurance = new Insurance__c(Flag__c = 'Analysis',
    									Entity__c=objAccount.id,
    									action__c ='To be grown till maturity and continue saving',
	                                    RecordTypeId=InsuranceRecTypes__c.getInstance ('Life Insurance').RecordTypeId__c,
	                                    Tenure_of_Insurance__c=10,Commencement_Date__c=System.today(),
	                                   	Next_Premium_Due_Date__c=system.today(),Premium_Amount_Rs__c =10000,
	                                   	Policy_Type__c='Whole Life',
	                                    Premium_Frequency__c='Annually');
    	return objInsurance;
    }
    
    public Insurance__c initialize_GeneralInsurance(Account objAccount, String policyType, String flag)
    {
    	Insurance__c objInsurance = new Insurance__c(Entity__c=objAccount.id,
    									Policy_Type__c=policyType,Premium_Amount_Rs__c=67,
    									flag__c=flag,
       									RecordTypeId=InsuranceRecTypes__c.getInstance ('General Insurance').RecordTypeId__c);
       	return objInsurance;								
    }
    
    public GoalInsuranceAssociation__c initialize_GoalIA(Insurance__c insurance, Goal__c goal)
    {
    	GoalInsuranceAssociation__c objGIA = new GoalInsuranceAssociation__c(Insurance__c=insurance.id,
    																		Goal__c=goal.id,
    																		Allocated__c=30);
    	return objGIA;
    }
    
	public GoalSIPAmount__c initialize_GoalSIPAmount(Goal__c initialize_Goal)
	{
		GoalSIPAmount__c objGoalSip = new GoalSIPAmount__c(Goal__c=initialize_Goal.Id,
										SIP_Debt__c=10000,SIP_Equity__c=200000,
										SIP_Gold__c=3000000,Goal_Year__c=2018);
		return objGoalSip;
	} 
	
	public Loan__c init_Loan(Account objAccount)
	{
		Loan__c objLoan = new  Loan__c(Principal_Amount_Outstanding__c=1000000,
								Entity__c=objAccount.id,EMI__c = 20000);
		return objLoan;
	}   
	
	public Income__c init_income(Account objAccount, Id recId)
	{
		Income__c objIncome = new Income__c(Entity__c = objAccount.Id,Income_Amount__c=null,
											Employer__c=null,Business_Name__c=null,Income_Type__c=null,
											Property_Name__c=null,Beneficiary__c=null,
											Income_Growth_Rate__c=null,Start_Year__c='1990',
											End_Year__c='2020', RecordTypeId=recId,Frequency__c='Monthly');
		return objIncome;
	}
	
	public Expense__c init_Expense(Account objAccount, String objGeneralExpenses)
	{
		Expense__c objExpense = new Expense__c(General_Expenses__c=objGeneralExpenses,Sub_Expenses__c='cook',
											Expense_Growth_Rate__c=6,Frequency__c='Monthly',
											Entity_Name__c=objAccount.id,Current_Expenses__c=10000);
		return objExpense;									
	}
	
	public Investment_Asset__c init_InvestmentAsset(Account objAccount, Id recId)
	{
		Investment_Asset__c objInvAsset = new Investment_Asset__c(Entity__c=objAccount.id,
											Script_Name__c='ABCD',
	  	                                    RecordTypeId=recId, Quantity__c =100, 
	  	                                    Current_Price__c=1000);
	  	return objInvAsset;
	}
	
	public GoalInvestmentAssetAssociation__c init_GoalInvAsset(Investment_Asset__c objInvAsset, Goal__c objGoal)
	{
		GoalInvestmentAssetAssociation__c objGoalInvAsset = new GoalInvestmentAssetAssociation__c
															(Investment_Asset__c = objInvAsset.id, 
															Goal__c = objGoal.id, 
															Allocated__c=60, Allocation_order__c = 2);
		return objGoalInvAsset;													
	}
	
	public EntityProfilerQuestion__c init_profilerQue(Account objAccount, ProfilerQuestions__c questionList, String Answer, String Score)
	{
		EntityProfilerQuestion__c entityPfQns = new EntityProfilerQuestion__c(Answer__c=Answer,
														Entity__c=objAccount.id,   
                                    					ProfilerQuestion__c=questionList.id,
                                    					Score__c=Score);
		return entityPfQns;                                                							
	}
	
	public Remarks__c init_Remark(Account objAccount, Id recId)
	{
		Remarks__c objRemark = new Remarks__c (Remark__c = 'Test Remark for Networth',
												Entity__c = objAccount.Id,
												RecordTypeId = recId);
		return objRemark;										
	}
	
	public Cheque_Details__c init_ChequeDetails(Account objAccount, String Installment) 
	{
		Cheque_Details__c chqDtls =  new Cheque_Details__c(Account__c = objAccount.Id,
										Installment__c = Installment,Cheque_Status__c = 'Deposited',
										Cheque_No__c = 'C1234',Cheque_Date__c = Date.Today(),
										Amount_Received__c = 5000);
		return chqDtls;										
	}
	
	public Workstation__c init_workstation(User objUser)
	{
		Workstation__c objWorkstation = new Workstation__c(Financial_Planner__c=objUser.Id,
											Compliance__c=objUser.Id,
											Business_Developer__c=objUser.Id,
											Tech__c=objUser.Id, Advisory__c=objUser.Id,
											Manager__c=objUser.Id,
											Member_Engagement__c=objUser.Id,
											Location__c='Pune');
		return objWorkstation;											
	}
	
	public Renewal__c init_Renewal(Account objAccount)
	{
		Renewal__c objRenewal = new Renewal__c (Entity__c=objAccount.Id);
		return objRenewal;
	}
	
	
	// Product Master Methods
	public Product_Manufacturer_Master__c init_PMM(String Name, String ShortCode, Boolean Active)
	{
		Product_Manufacturer_Master__c objPMM = new Product_Manufacturer_Master__c
												(Name = Name, 
												 Short_Code__c = ShortCode, 
												 Is_Active__c = Active);
		return objPMM;
	}
	
	public Product_Master__c init_ProductMaster(Product_Manufacturer_Master__c objPMM, String productType, String productName, 
												String CR, String assetClass, String invType)
	{
		Product_Master__c objProduct = new Product_Master__c(SIP_Allowed__c = 'Yes', 
											   Product_Manufacturer__c = objPMM.Id, 
											   Is_Active__c = false, 
											   ProductType__c = productType, 
											   Product_Name__c = productName, 
											   Currently_Recommended__c = CR,
											   Fees_in_Advance_or_On_Service_Delivery__c = true,
											   Asset_Class__c = assetClass,
											   Investment_Type__c = invType);
		return objProduct;											   
	}
	
	public Product_Recommendation_Master__c init_PRM(Product_Master__c objProduct, String currentStatus)
	{
		Product_Recommendation_Master__c objProdRec = new Product_Recommendation_Master__c
												(Product_code__c = objProduct.id, 
												 Recommendation_Start_date__c = system.today(), 
												 Recommendation_End_date__c = system.today() + 3,
												 Current_Status__c = currentStatus);
		return objProdRec;										 
	}
	
	public Attachment init_Attachment(Lead objLead)
	{ 
		Attachment objAttachment = new Attachment(ParentId = objLead.Id,
	    										Name = 'Test', 
	    										Body = Blob.valueOf('test'));
		return objAttachment;
	}	    										
	
	public Approve_Action_Plan__c init_ApproveActionPlan(Id objAccountId)
	{
		Approve_Action_Plan__c objApproveActionPlan = new Approve_Action_Plan__c(Account__c = objAccountId);
		return objApproveActionPlan;
	}
	public Approve_Action_Plan__c init_ApproveActionPlan_Details(Id objAccountId,Id investmentId)
	{
		Approve_Action_Plan__c objApproveActionPlan = new Approve_Action_Plan__c(Account__c = objAccountId,Investment_Asset__c = investmentId);
		return objApproveActionPlan;
	}
	
	public Execution_Tracker__c init_ExecutionTracker(Id accountId,String EtStatus,String ApplicationStatus,Id approveActionPlanId,String strType,String strAction)
	{
	 	Execution_Tracker__c objExecutionTracker = new Execution_Tracker__c(Entity_Name__c = accountId,  ET_Status__c = EtStatus, Is_Floating__c = false,
        									Risk_Commencement_Date__c = system.today(),Application_Status__c = ApplicationStatus, 
        									Approve_Action_Plan__c = approveActionPlanId, Type__c = strType,Action__c = strAction);
        return objExecutionTracker;									
        
	}
	
	/*---------------------------- Mapped Advsior -------------------------*/
	
	public Business_Unit__c init_Business_Unit(String shortCode)
	{
    	Business_Unit__c objBU = new Business_Unit__c(Short_Code__c =shortCode, Name = 'Business Unit 1');
    	return objBU;
	}
	
	public Department__c init_Department(String Type, Id objBUId)
	{
		Department__c objDepartment = new Department__c(Business_Unit__c = objBUId, Type_of_Department__c=Type);
		return objDepartment;
	}
	
	public Team_Member__c init_Team_Member(Id userId, Id departmentId)
	{
		Team_Member__c objTeam_Member = new Team_Member__c(Department__c=departmentId,  Name='User Name',
														Start_Date__c=system.today(), End_Date__c=system.today(),
														Team_Member__c=userId, Status__c='Active');
		return objTeam_Member;												
	}
	
	public Partner_Team_Member_Allocation__c init_Partner_Team_Member_Allocation(Account objVirtualAccount)
	{
		Partner_Team_Member_Allocation__c objPTM1 = new Partner_Team_Member_Allocation__c();
				objPTM1.Name = 'PST - ' + objVirtualAccount.Name;
				objPTM1.Partner__c = objVirtualAccount.Id;
				objPTM1.Allocation_Date__c = system.today();
				objPTM1.Allocated_By__c = objVirtualAccount.OwnerId;
				objPTM1.Team_Member__c = objVirtualAccount.PST_Team_Member__c;
		return objPTM1;
	}
	
	public Product_Default_Allocation__c init_Product_Default_Allocation(Business_Unit__c objBU,
																		 Product_Master__c objProduct,
																		//String AssetClass, String InvestmentType,
																		Integer SeqNo, Integer MinRange, Integer MaxRange,
																		Integer Ratio, String GoalType, String RiskProfile)
	{
		Product_Default_Allocation__c objPDA = new Product_Default_Allocation__c();
			objPDA.Name = 'Name';
			//objPDA.Partner__c = initVirtualAccount.Id ;
			objPDA.Business_Unit__c = objBU.Id;
			//objPDA.RecordTypeId = RecordTypeId;
			objPDA.Product__c = objProduct.Id;
			//objPDA.Asset_Class__c = AssetClass;
			//objPDA.Investment_Type__c = InvestmentType;
			objPDA.Sequence_No__c = SeqNo;
			objPDA.Risk_Profile__c = RiskProfile;
			objPDA.Minimum_Range__c = MinRange;
			objPDA.Maximum_Range__c = MaxRange;
			objPDA.Ratio__c = Ratio;
			objPDA.Goal_Type__c = GoalType;
		return objPDA;
	}
	
	public Product_Default_Allocation__c init_Product_Default_Allocation_Partner(Account initVirtualAccount, //Business_Unit__c objBU,
																		 Product_Master__c objProduct,
																		//String AssetClass, String InvestmentType,
																		Integer SeqNo, Integer MinRange, Integer MaxRange,
																		Integer Ratio, String GoalType, String RiskProfile)
	{
		Product_Default_Allocation__c objPDA = new Product_Default_Allocation__c();
			objPDA.Name = 'Name';
			objPDA.Partner__c = initVirtualAccount.Id ;
			//objPDA.Business_Unit__c = objBU.Id;
			//objPDA.RecordTypeId = RecordTypeId;
			objPDA.Product__c = objProduct.Id;
			//objPDA.Asset_Class__c = AssetClass;
			//objPDA.Investment_Type__c = InvestmentType;
			objPDA.Sequence_No__c = SeqNo;
			objPDA.Risk_Profile__c = RiskProfile;
			objPDA.Minimum_Range__c = MinRange;
			objPDA.Maximum_Range__c = MaxRange;
			objPDA.Ratio__c = Ratio;
			objPDA.Goal_Type__c = GoalType;
		return objPDA;
	}
	
/*	
	public List<RecTypes__c> getAccountRecordType()
	{
    	//Get RecordType record
    	List<RecTypes__c> lstRecTypes = new List<RecTypes__c>();
    	RecTypes__c objRecType = new RecTypes__c(Name='General_Business', 
    											 Record_Type_Value__c=RECORD_TYPE_INFO_MAP.get('General').getRecordTypeId());
    	
    	RecTypes__c objRecType1 = new RecTypes__c(Name='AccountFamily', 
    											 Record_Type_Value__c=RECORD_TYPE_INFO_MAP.get('Family Member').getRecordTypeId());
    	RecTypes__c objRecType2 = new RecTypes__c(Name='AccountClient', 
    											 Record_Type_Value__c=RECORD_TYPE_INFO_MAP.get('Client').getRecordTypeId());
    	
    	lstRecTypes.add(objRecType);										 
    	lstRecTypes.add(objRecType1);
    	lstRecTypes.add(objRecType2);	
    	return lstRecTypes;
    	
	}	
	
	public List<smagicbasic__SMS_Template__c> getSMSTemplate()
	{
    	List<smagicbasic__SMS_Template__c> lstTemplate = new List<smagicbasic__SMS_Template__c>();
    	
    	smagicbasic__SMS_Template__c template= new smagicbasic__SMS_Template__c(smagicbasic__Name__c= 'Discontinuation Template', 
    																			smagicbasic__ObjectName__c = 'Account');
    	
    	smagicbasic__SMS_Template__c template1= new smagicbasic__SMS_Template__c(smagicbasic__Name__c= 'Renewal Template', 
    																			smagicbasic__ObjectName__c = 'Account');
    	lstTemplate.add(template);
    	lstTemplate.add(template1);
    	
    	return lstTemplate;
    	
	}
	
	public Account getAccountGeneralRecordType()
	 {   
    	Account objBPAccount = new Account(Name='Parner Account Test',
    								RecordTypeId= RECORD_TYPE_INFO_MAP.get('General').getRecordTypeId());
    	return objBPAccount;
        
	 }
	 
	public Account getAccountClientRecordType()  
    {
        Account objAccount = new Account(LastName='Test Freedom', Adjustment_Factor__c='2',
                           PersonTitle='TestData',PersonBirthdate=system.today(),PersonHomePhone='54623676',PersonMobilePhone='5463712345',
                           Alternate_Mobile__c='356475',PersonEmail='sgdh@test.com', Alternate_E_Mail_Address__c='fdgr@test.com',PersonMailingStreet='aa',
                           PersonMailingCity='bbb',Retirement_Year__c=2034,Residential_Status_del__c='own',Retirement_Age__c='58',Estimated_Life_Expectancy__c='67',
                           Estimated_Life_EndYear__c=2041,Relationship_to_Entity__pc='husband', Related_To__c ='Ffreedom',
                           RecordTypeId = RECORD_TYPE_INFO_MAP.get('Client').getRecordTypeId(),Will__c = true);   
		return objAccount;
	}
    
    public Asset__c getAssetRecordType()  
    {
        
		return objAccount;
	}   
	*/
}