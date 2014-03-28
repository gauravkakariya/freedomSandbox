<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CurrentActiveRecommnedation</fullName>
        <field>CurrentActiveRecommnedation__c</field>
        <formula>1</formula>
        <name>CurrentActiveRecommnedation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CurrentActiveRecommnedation_Expired</fullName>
        <description>Set value of CurrentActiveRecommnedation as 0 if Status of recommendation record is set as &apos;Expired&apos;.</description>
        <field>CurrentActiveRecommnedation__c</field>
        <formula>0</formula>
        <name>CurrentActiveRecommnedation_Expired</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Header</fullName>
        <field>CurrentActiveRecommnedation__c</field>
        <formula>1</formula>
        <name>Header</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Currently Recommanded must be no if recommendations are expired</fullName>
        <actions>
            <name>CurrentActiveRecommnedation_Expired</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>For that if End date is blank, then Start date must be less than today else start date &lt; today &gt; end date and status is Expired for both then Currently recommended field of Product should be set to &apos;No&apos;.</description>
        <formula>IF( ISNULL(Recommendation_End_date__c), 
	     AND(TODAY() &gt;=  Recommendation_Start_date__c , 
		  ISPICKVAL(Current_Status__c, &apos;Expired&apos;)),
	     AND(TODAY() &gt;=  Recommendation_Start_date__c , 
		 TODAY() &lt;= Recommendation_End_date__c, 
		ISPICKVAL(Current_Status__c, &apos;Expired&apos;)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Product Recommendation needs to exist</fullName>
        <actions>
            <name>CurrentActiveRecommnedation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Atleast 1 Active Product Recommendation needs to exist for the current Product in order to mark it as Recommended
For that if End date is blank, then Start date must be less than today else start date &lt; today &gt; end date and status must be active for both</description>
        <formula>IF( ISNULL(Recommendation_End_date__c), 
	     AND(TODAY() &gt;=  Recommendation_Start_date__c , 
		  ISPICKVAL(Current_Status__c, &apos;Active&apos;)),
	     AND(TODAY() &gt;=  Recommendation_Start_date__c , 
		 TODAY() &lt;= Recommendation_End_date__c, 
		ISPICKVAL(Current_Status__c, &apos;Active&apos;)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
