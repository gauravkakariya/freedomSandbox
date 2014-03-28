<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Time_Member_Name_Populate</fullName>
        <description>Time Member Name Populate</description>
        <field>Name</field>
        <formula>Team_Member__r.FirstName + &apos; &apos; +  Team_Member__r.LastName</formula>
        <name>Time Member Name Populate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Team Member Name population</fullName>
        <actions>
            <name>Time_Member_Name_Populate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Team Member (User)  Name should be populated in the name field so that it can be displayed properly on account.</description>
        <formula>Team_Member__c &lt;&gt; NULL</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
