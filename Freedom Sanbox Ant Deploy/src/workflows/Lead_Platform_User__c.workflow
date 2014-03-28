<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_On_Meeting_Fixed</fullName>
        <description>Email On Meeting Fixed</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Leads_Templates/Lead_In_Meeting_Fixed_Stage_Overdue</template>
    </alerts>
    <alerts>
        <fullName>Lead_In_Open_Stage_Overdue</fullName>
        <description>Lead In Open Stage Overdue</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Leads_Templates/Lead_In_Open_Stage_Overdue</template>
    </alerts>
    <fieldUpdates>
        <fullName>Owner_Change_to_Ffreedom_Team</fullName>
        <description>Change lead owner from Guest User(Site - XRay) to Marketing User(Ffreedom Team)</description>
        <field>OwnerId</field>
        <lookupValue>marketing@ffreedom.in</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Owner Change to Ffreedom Team</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>EmailOnLeadInitiating</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Lead_Platform_User__c.Lead_Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Lead_In_Open_Stage_Overdue</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Lead_Platform_User__c.Status_Change_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>EmailOnMeetingConformation %28LeadC%29</fullName>
        <actions>
            <name>Email_On_Meeting_Fixed</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead_Platform_User__c.Lead_Status__c</field>
            <operation>equals</operation>
            <value>Meeting Fixed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead_Platform_User__c.Lead_Source__c</field>
            <operation>notEqual</operation>
            <value>Web</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>EmailOnMeetingFollowUpLeadC</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Lead_Platform_User__c.Lead_Status__c</field>
            <operation>equals</operation>
            <value>Meeting Follow-up</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Lead_Platform_User__c.Status_Change_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Lead Owner change from Guest User to Ffreedom Team</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Lead_Platform_User__c.OwnerId</field>
            <operation>equals</operation>
            <value>Ffreedom Planners</value>
        </criteriaItems>
        <description>Change lead owner from Guest User(Site - XRay) to Marketing User(Ffreedom Team)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Task Creation On Meeting Fixed</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Lead_Platform_User__c.Lead_Status__c</field>
            <operation>equals</operation>
            <value>Meeting Fixed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Web to Lead - Careers Page</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Lead_Platform_User__c.Lead_Source__c</field>
            <operation>equals</operation>
            <value>Web</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead_Platform_User__c.Lead_Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead_Platform_User__c.OwnerId</field>
            <operation>equals</operation>
            <value>Analytics Team</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Web to Lead - Comp_Con Page</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Lead_Platform_User__c.Lead_Source__c</field>
            <operation>equals</operation>
            <value>Web</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead_Platform_User__c.Lead_Status__c</field>
            <operation>equals</operation>
            <value>Meeting Fixed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead_Platform_User__c.OwnerId</field>
            <operation>equals</operation>
            <value>Ffreedom Team</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Web to Lead - Ffreedom Day</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Lead_Platform_User__c.Lead_Source__c</field>
            <operation>equals</operation>
            <value>Web</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead_Platform_User__c.Lead_Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead_Platform_User__c.OwnerId</field>
            <operation>equals</operation>
            <value>Ffreedom Marketing Team</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead_Platform_User__c.Description__c</field>
            <operation>contains</operation>
            <value>Ffreedom Day</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>Please_Follow_Up_With_This_Lead</fullName>
        <assignedToType>owner</assignedToType>
        <description>Please Follow Up With This Lead To Get The Meeting Fixed &amp; Please Update AF ASAP.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Planned</status>
        <subject>Please Follow Up With This Lead</subject>
    </tasks>
</Workflow>
