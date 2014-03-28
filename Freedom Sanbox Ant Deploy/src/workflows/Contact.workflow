<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Client_Birthday_Reminder</fullName>
        <description>Birthday Alert</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <recipients>
            <recipient>analytics@ffreedom.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Data_Exexution_Tracker/Birthday_Alert</template>
    </alerts>
    <alerts>
        <fullName>Wish_Client_Happy_BirthDay</fullName>
        <description>Wish Client Happy BirthDay</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Marketing_Templates/Happy_Birthday</template>
    </alerts>
    <rules>
        <fullName>Test</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Contact.AccountName</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Birthday_Due_In_Two_Days</fullName>
        <assignedToType>accountOwner</assignedToType>
        <description>Please call this entity. His Birthday is due in two days.</description>
        <dueDateOffset>-2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Contact.Birthday_This_Year__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Planned</status>
        <subject>Birthday Due In 2 Days</subject>
    </tasks>
    <tasks>
        <fullName>Wish_Happy_Birthday_To_Client</fullName>
        <assignedToType>accountOwner</assignedToType>
        <description>Please wish Happy Birthday to this client.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Contact.Birthday_This_Year__c</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Planned</status>
        <subject>Wish Happy Birthday Today</subject>
    </tasks>
</Workflow>
