<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Case_Registration_Confirmation</fullName>
        <description>Case Registration Confirmation</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>KnowYourClient/Case_Registration_Confirmation</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_when_case_of_Internal_record_type_is_closed</fullName>
        <description>Email alert when case of Internal record type is closed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>tech@ffreedom.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>KnowYourClient/Internal_Case_Closed</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_when_case_of_Internal_record_type_is_reopened</fullName>
        <description>Email alert when case of Internal record type is reopened</description>
        <protected>false</protected>
        <recipients>
            <recipient>tech@ffreedom.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>KnowYourClient/Case_Assignment</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_when_case_of_Internal_record_type_is_resolved</fullName>
        <ccEmails>tech@ffreedom.in</ccEmails>
        <description>Email alert when case of Internal record type is resolved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>KnowYourClient/Internal_Case_Resolved</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_when_new_case_of_Internal_record_type_is_created</fullName>
        <description>Email alert when new case of Internal record type is created</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>KnowYourClient/New_Case_of_Internal_Type</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_when_new_case_of_Internal_record_type_is_logged</fullName>
        <description>Email alert when new case of Internal record type is logged</description>
        <protected>false</protected>
        <recipients>
            <recipient>tech@ffreedom.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>KnowYourClient/Case_Assignment</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_when_status_of_Internal_record_type_case_is_Resolved_for_more_than_3</fullName>
        <ccEmails>tech@ffreedom.in</ccEmails>
        <description>Email alert when status of Internal record type case is Resolved for more than 3 days</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>KnowYourClient/Request_To_Log_New_Case</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_when_status_of_Internal_record_type_case_is_changed_to_Clarification</fullName>
        <description>Email alert when status of Internal record type case is changed to Clarification Provided</description>
        <protected>false</protected>
        <recipients>
            <recipient>tech@ffreedom.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>KnowYourClient/Clarification_Provided_for_Internal_Case</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_when_status_of_Internal_record_type_case_is_changed_to_Need_Clarific</fullName>
        <ccEmails>tech@ffreedom.in</ccEmails>
        <description>Email alert when status of Internal record type case is changed to Need Clarification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>KnowYourClient/Need_Clarification_for_Internal_Case</template>
    </alerts>
    <alerts>
        <fullName>Ffreedom_Internal_Case_Escalated</fullName>
        <ccEmails>bommi.setty@eternussolutions.com</ccEmails>
        <description>Ffreedom Internal Case Escalated</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>AsssignedTo__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Case_Owenr_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Ffreedom_Internal_Case_Escalate</template>
    </alerts>
    <alerts>
        <fullName>Ffreedom_Internal_Case_Logged</fullName>
        <ccEmails>bommi.setty@eternussolutions.com</ccEmails>
        <description>Ffreedom Internal Case Logged</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>AsssignedTo__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Case_Owenr_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Ffreedom_Internal_Case_Logged</template>
    </alerts>
    <alerts>
        <fullName>New_Case_Logged</fullName>
        <description>New Case Logged</description>
        <protected>false</protected>
        <recipients>
            <recipient>analytics@ffreedom.in</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tech@ffreedom.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>KnowYourClient/Case_Assignment</template>
    </alerts>
    <fieldUpdates>
        <fullName>Case_Escalate</fullName>
        <description>Case Escalated to Manager</description>
        <field>IsEscalated</field>
        <literalValue>1</literalValue>
        <name>Case Escalate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Test</fullName>
        <field>Status</field>
        <literalValue>Closed</literalValue>
        <name>Test</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Status_Field</fullName>
        <description>Internal record type case is in Resolved status for more than 3 days, automatically update the status to close.</description>
        <field>Status</field>
        <literalValue>Closed</literalValue>
        <name>Update Case Status Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Clarification Provided For Internal Type Case</fullName>
        <actions>
            <name>Email_alert_when_status_of_Internal_record_type_case_is_changed_to_Clarification</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Internal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Clarification Provided</value>
        </criteriaItems>
        <description>Status of Internal record type case changed to Clarification Provided</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ffreedom Internal Case Due Date</fullName>
        <active>false</active>
        <description>Ffreedom Internal Case Due Date</description>
        <formula>AND(
	(
		AND( 
			(RecordTypeId  = &apos;012W00000004MIU&apos;), 
			( Due_Date__c  =  TODAY() )
			)
	),
	( 
		NOT(
			(ISPICKVAL(Status, &apos;New&apos;)||(ISPICKVAL(Status, &apos;Resolved&apos;))||(ISPICKVAL(Status, &apos;Closed&apos;)))
		)
	)
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ffreedom Internal Type Case Resolved</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Ffreedom Internal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Resolved</value>
        </criteriaItems>
        <description>Ffreedom Internal Type Case Resolved</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ffrredom Internal Type Case Closed</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Ffreedom Internal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>Ffrredom Internal Type Case Closed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Internal Type Case Closed</fullName>
        <actions>
            <name>Email_alert_when_case_of_Internal_record_type_is_closed</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Internal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>Case of Internal record type is closed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Internal Type Case Reopened</fullName>
        <actions>
            <name>Email_alert_when_case_of_Internal_record_type_is_reopened</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Internal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Re-open</value>
        </criteriaItems>
        <description>Status of Internal record type case is reopen</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Internal Type Case Resolved</fullName>
        <actions>
            <name>Email_alert_when_case_of_Internal_record_type_is_resolved</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Internal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Resolved</value>
        </criteriaItems>
        <description>Case of Internal record type is resolved</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_alert_when_status_of_Internal_record_type_case_is_Resolved_for_more_than_3</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Update_Case_Status_Field</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Need Clarification For Internal Type Case</fullName>
        <actions>
            <name>Email_alert_when_status_of_Internal_record_type_case_is_changed_to_Need_Clarific</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Internal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Needs Clarification</value>
        </criteriaItems>
        <description>Status of Internal record type case changed to Need Clarification</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New Case</fullName>
        <actions>
            <name>Case_Registration_Confirmation</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>New_Case_Logged</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Customer Portal</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>New Ffreedom Internal Type Case Logged</fullName>
        <actions>
            <name>Ffreedom_Internal_Case_Logged</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Ffreedom Internal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>New Ffreedom Internal Type Case Logged</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Internal Type Case Logged</fullName>
        <actions>
            <name>Email_alert_when_new_case_of_Internal_record_type_is_created</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Email_alert_when_new_case_of_Internal_record_type_is_logged</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Internal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>New case of Internal record type is created</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
