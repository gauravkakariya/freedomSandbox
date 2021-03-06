/*
Revision History:

		Version     Version Author     Date        Comments
		1.0         --           	   --	  	   Initial Draft
		2.0  		Prajakta Sanap     25/04/2013	Created TestData_Ffreedom which contains all the test data for this test class.				   				 					   
*/

@isTest
private class LifeInsurancePlanningPageControllerTest 
{
    
	static LifeInsurancePlanningPageController lifeInsurancePlanning;
	static Account acc;
	static Account spouse;
	static List<Account> accountlist = new List<Account>();
	 
	public static void testData()
	{
		TestData_Ffreedom testData = new TestData_Ffreedom();
		acc = testData.initializeAccount();
       
       upsert acc;
       system.assertNotEquals(null,acc);
       
       Loan__c loan = testData.init_Loan(acc);
       upsert loan;
       system.assertNotEquals(null,loan.id);
      
       List<Insurance__c> insuranceList = new List<Insurance__c>();
       Insurance__c ins = testData.initialize_Insurance(acc);
       insuranceList.add(ins);
       Insurance__c ins1 = testData.initialize_Insurance(acc);
       insuranceList.add(ins1);
       insert insuranceList;
       
	   List<Investment_Asset__c> invAssetList = new List<Investment_Asset__c>();
       Investment_Asset__c inss1 = testData.init_InvestmentAsset(acc, InvestmentAsset__c.getInstance ('Fixed Income').RecordTypeId__c);
       invAssetList.add(inss1);
       
       Investment_Asset__c inss3 = testData.init_InvestmentAsset(acc, InvestmentAsset__c.getInstance ('Gold and Silver').RecordTypeId__c);
       invAssetList.add(inss3);
       
       Investment_Asset__c inss2 = testData.init_InvestmentAsset(acc, InvestmentAsset__c.getInstance ('Stocks').RecordTypeId__c);
       invAssetList.add(inss2);
        
       Investment_Asset__c inss4 = testData.init_InvestmentAsset(acc, InvestmentAsset__c.getInstance ('Mutual Fund').RecordTypeId__c); 
       invAssetList.add(inss4);
       insert invAssetList;
       
       Expense__c exp = testData.init_Expense(acc, 'Housing');
       upsert exp;
       system.assertNotEquals(null,exp.id);
	    Remarks__c objRemarks = new Remarks__c(Entity__c=acc.id,Remark__c='aaa');
	    insert objRemarks;
       
	}

	
	public static testMethod void lifeInsurancePlanTest()
	{
	    testData();
	    Test.startTest();
	  	TestData_Ffreedom testData = new TestData_Ffreedom();
		
	    spouse = new Account(FirstName='ACD',LastName='GHJ',Estimated_Life_Expectancy__c='67',Dependent__c=acc.Id,
	    					Relationship_to_Entity__pc='wife',PersonBirthdate=system.today(),Parent_Entity__c = acc.Id);
		accountlist.add(spouse);
		
	    Account daughter = new Account(FirstName='Girl',LastName='GHJ',Estimated_Life_Expectancy__c='67',Dependent__c=acc.Id,
	    					Relationship_to_Entity__pc='daughter',PersonBirthdate=system.today(),Parent_Entity__c = acc.Id);				
	    accountlist.add(daughter);
	    insert accountlist;
	    Apexpages.currentPage().getParameters().put('entityId',acc.id);
        lifeInsurancePlanning = new LifeInsurancePlanningPageController();
	    system.assertNotEquals(null,spouse);
   	
   		lifeInsurancePlanning.getEntityPicklist();
	    lifeInsurancePlanning.getAdjustmentFactor();
	   // lifeInsurancePlanning.Calculate();
	    lifeInsurancePlanning.output();
	    lifeInsurancePlanning.analysis();
	    lifeInsurancePlanning.entities = null;
	    
	    test.stopTest();
	}
	
	/*public static testMethod void lifeInsurancePlanTest2()
	{
	   // testData();
	   
	    TestData_Ffreedom testData = new TestData_Ffreedom();
		acc = testData.initializeAccount();
       
        insert acc;
	    spouse = new Account(FirstName='ACD',LastName='GHJ',Estimated_Life_Expectancy__c='67',Dependent__c=acc.Id,
	    					Relationship_to_Entity__pc='wife',PersonBirthdate=system.today(),Parent_Entity__c = acc.Id);
		accountlist.add(spouse);
		
	    Account daughter = new Account(FirstName='Girl',LastName='GHJ',Estimated_Life_Expectancy__c='67',Dependent__c=acc.Id,
	    					Relationship_to_Entity__pc='daughter',PersonBirthdate=system.today(),Parent_Entity__c = acc.Id);				
	    accountlist.add(daughter);
	    insert accountlist;
	    Test.startTest();
	    Apexpages.currentPage().getParameters().put('entityId',acc.id);
        lifeInsurancePlanning = new LifeInsurancePlanningPageController();
	    system.assertNotEquals(null,spouse);
   	
   		lifeInsurancePlanning.getEntityPicklist();
	    lifeInsurancePlanning.getAdjustmentFactor();
	    lifeInsurancePlanning.Calculate();
	    
	    test.stopTest();
	   
	}*/
	public static testMethod void lifeInsurancePlanTest1()
	{
		
	    TestData_Ffreedom testData = new TestData_Ffreedom();
		acc = testData.initializeAccount();
       	upsert acc;
       	system.assertNotEquals(null,acc);
       
       	Loan__c loan = testData.init_Loan(acc);
       	upsert loan;
       	system.assertNotEquals(null,loan.id);
      
       	List<Insurance__c> insuranceList = new List<Insurance__c>();
       	Insurance__c ins = testData.initialize_Insurance(acc);
       	insuranceList.add(ins);
       
       	Insurance__c ins1 = testData.initialize_Insurance(acc);
       	insuranceList.add(ins1);
      	insert insuranceList;
       
	   	List<Investment_Asset__c> invAssetList = new List<Investment_Asset__c>();
       
       	Investment_Asset__c inss1 = testData.init_InvestmentAsset(acc, InvestmentAsset__c.getInstance ('Fixed Income').RecordTypeId__c);
       	invAssetList.add(inss1);
       
       /* Prajakta - FP changes - 26-02-2013 */
       	Investment_Asset__c inss3 = testData.init_InvestmentAsset(acc, InvestmentAsset__c.getInstance ('Gold and Silver').RecordTypeId__c);
       	invAssetList.add(inss3);
       
       	Investment_Asset__c inss2 = testData.init_InvestmentAsset(acc, InvestmentAsset__c.getInstance ('Stocks').RecordTypeId__c);
       	invAssetList.add(inss2);
       
        Investment_Asset__c inss4 = testData.init_InvestmentAsset(acc, InvestmentAsset__c.getInstance ('Mutual Fund').RecordTypeId__c);
       invAssetList.add(inss4);
       insert invAssetList;
      
	    Remarks__c objRemarks = new Remarks__c(Entity__c=acc.id,Remark__c='aaa');
	    insert objRemarks;
       
        List<HLVDetails__c> lstHLVDetails = new List<HLVDetails__c>();
       	HLVDetails__c HLVDetails = new HLVDetails__c(Present_Age_in_case_of_Death_A__c=50,Normal_Age_of_Retirement_B__c=60,
        									Working_Life_B_A__c=10,Present_Age_in_case_of_Death_A_Dependent__c=65,
        									Normal_Life_Expectancy_B__c=85,Living_Years_B_A__c=15,
        									Expected_Return_on_Investments__c=8,Expected_Inflation__c=9,
        									Expected_Inflation_Adjusted_Return__c=10,
        									Selected_Entity_Name__c=acc.Id,entity__c=acc.id);
        lstHLVDetails.add(HLVDetails);
        insert lstHLVDetails;	
       	  
	  	Test.startTest();
	    Apexpages.currentPage().getParameters().put('entityId',acc.id);
        lifeInsurancePlanning = new LifeInsurancePlanningPageController();
   	
   		lifeInsurancePlanning.getEntityPicklist();
	    lifeInsurancePlanning.getAdjustmentFactor();
	    //lifeInsurancePlanning.Calculate();
	    //lifeInsurancePlanning.getHLVEntityDetails(acc.Id);
	    lifeInsurancePlanning.save();
	    lifeInsurancePlanning.output();
	    lifeInsurancePlanning.analysis();
	   
	    lifeInsurancePlanning.entities = null;
	    //lifeInsurancePlanning.calculateSummaryBeanValues();
	    test.stopTest();
		
	}
	
}