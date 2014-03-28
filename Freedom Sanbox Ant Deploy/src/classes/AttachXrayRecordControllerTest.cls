/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *

 */
@isTest(seeAllData = true)
private class AttachXrayRecordControllerTest {

    static testMethod void xrayEmailServiceHandlerTest() {
    
	  //QuestionBank__c objInsuranceRecType = new QuestionBank__c(Name='FinancialXRay');
      //insert objInsuranceRecType;
      
      //Start Test 
      Test.startTest();
        
      //Create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
      //Setup the data for the email
      email.subject = 'Xray Email Service';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'hello';
      
      //Add an Text atatchment
      Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      
      //Get Railcar record from CSV
      attachmenttext.body = getXmlRecord();
      attachmenttext.fileName = 'textfiletwo3.xml';
      attachmenttext.mimeTypeSubType = 'texttwo/plain';
      email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
      
      //Call the email service class and test it with the data in the testMethod
      AttachXrayRecordController  attachXrayRecord = new AttachXrayRecordController ();
      XrayEmailServiceHandler xrayXmlFileHandler = new XrayEmailServiceHandler();
      xrayXmlFileHandler.handleInboundEmail(email, env);
      attachXrayRecord.readXmlFileBody(); 
      
      Lead newLead = [Select Id, Name From Lead Where Age__c =:20]; 
      system.assertEquals('Test3March14', newLead.Name);
      
      //End Test 
      Test.stopTest();
      
    }
    
     //Get Xray record from xml File
    private static String getXmlRecord(){
    	return '<?xml version="1.0" encoding="UTF-8"?><topmostSubform><Name>Test3March14</Name><Age>20</Age>' +
    					 '<Q1>No</Q1></topmostSubform>';	
    }
    
}//AttachXrayRecordControllerTest