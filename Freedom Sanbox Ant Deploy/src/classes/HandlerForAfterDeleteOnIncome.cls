public with sharing class HandlerForAfterDeleteOnIncome 
{
	public void afterDeleteIncome(list<Income__c> lstIncome)
	{
		system.debug('************************81.1'+lstIncome);
		SyncDeletedRecords__c objSDR = null;
		
	     list<SyncDeletedRecords__c> lstSDR = new List<SyncDeletedRecords__c>();
	     
	    for(Income__c objIncome : lstIncome)
	    {
	    	objSDR = new SyncDeletedRecords__c();
	    	objSDR.Sobject_ID__c = objIncome.ID;
	    	objSDR.SObjectType__c = 'Income';
	    	objSDR.Sync_DataTime__c  = objIncome.Synched_Date_Time__c;
	    	
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
      	  
      	  Income__c objIncome = new Income__c();
      	  objIncome.Entity__c = child.id;
      	  objIncome.Annualized_del__c = 21256454;
      	 // objFinAccount.Account__c = child.id;
      	     insert objIncome;
      	     
      	     
      	            test.startTest();
              delete objIncome;
          test.stopTest();
      }
      	  
}