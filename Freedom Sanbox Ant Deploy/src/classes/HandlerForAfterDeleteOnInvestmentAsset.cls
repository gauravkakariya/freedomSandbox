public with sharing class HandlerForAfterDeleteOnInvestmentAsset 
{
	public void afterDeleteInvestment(list<Investment_Asset__c> lstInvestmentAsset)
	{
		system.debug('************************81.1'+lstInvestmentAsset);
		SyncDeletedRecords__c objSDR = null;
		
	     list<SyncDeletedRecords__c> lstSDR = new List<SyncDeletedRecords__c>();
	     
	    for(Investment_Asset__c objInvestmentAsset : lstInvestmentAsset)
	    {
	    	objSDR = new SyncDeletedRecords__c();
	    	objSDR.Sobject_ID__c = objInvestmentAsset.ID;
	    	objSDR.Sync_DataTime__c  = objInvestmentAsset.Synched_Date_Time__c;
	    	objSDR.SObjectType__c = 'Investment_Asset__c';
	    	
	    	lstSDR.add(objSDR);
	    } 	
	    insert lstSDR;
	
	}
	
		 @IsTest(seealldata = true) 
      public static void testCoverage() 
      {
      	 TestData_Ffreedom testData = new TestData_Ffreedom();
      	 Account parent = new Account();
          parent = testData.initializeAccount();
          insert parent;
          Account child = new Account(); 
          child = testData.init_FamilyMember(parent);
          child.Portal_Id__c = '1';
          insert child;
      	  
      	  Investment_Asset__c objInvAsset = new Investment_Asset__c();
      	  objInvAsset.Entity__c = child.id;
      	  objInvAsset.Face_Value__c = 2125;
      	 // objFinAccount.Account__c = child.id;
      	     insert objInvAsset;
      	     
      	     
      	            test.startTest();
              delete objInvAsset;
          test.stopTest();
      }
}