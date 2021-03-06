public with sharing class HandlerForAfterDeleteOnLoan 
{
	public void afterDeleteLoan(list<Loan__c> lstLoan)
	{
		system.debug('************************81.1'+lstLoan);
		SyncDeletedRecords__c objSDR = null;
		
	     list<SyncDeletedRecords__c> lstSDR = new List<SyncDeletedRecords__c>();
	     
	    for(Loan__c objLoan : lstLoan)
	    {
	    	objSDR = new SyncDeletedRecords__c();
	    	objSDR.Sobject_ID__c = objLoan.ID;
	    	objSDR.Sync_DataTime__c  = objLoan.Synched_Date_Time__c;
	    	objSDR.SObjectType__c = 'Loan__c';
	    	
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
      	  
      	  Loan__c objloan = new Loan__c();
      	  
      	  objloan.IsSynched__c = true;
      	   objloan.Entity__c = child.id;
      	     insert objloan;
      	     
      	     
      	            test.startTest();
              delete objloan;
          test.stopTest();
      }
	
}