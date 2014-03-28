<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Asset_Class_Population</fullName>
        <field>Asset_Class__c</field>
        <formula>CASE(Product__r.Asset_Class__c, 
&quot;Equity&quot;, &quot;Equity&quot;, 
&quot;Debt&quot;, &quot;Debt&quot;, 
&quot;Gold&quot;, &quot;Gold&quot;, 
&quot;Real Estate&quot;, &quot;Real Estate&quot;, 
&quot;Loans&quot;,&quot;Loans&quot;, 
&quot;Insurance&quot;,&quot;Insurance&quot;, 
&quot;Service&quot;, &quot;Service&quot;, 
&quot;None&quot;)</formula>
        <name>Asset Class Population</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Investment_Type_population</fullName>
        <field>Investment_Type__c</field>
        <formula>CASE( Product__r.Investment_Type__c 
,&quot;Equity MF&quot;,&quot;Equity MF&quot;
,&quot;ULIP&quot;,&quot;ULIP&quot;
,&quot;Direct Stock&quot;,&quot;Direct Stock&quot;
,&quot;Debt MF&quot;,&quot;Debt MF&quot;
,&quot;Fixed Deposit&quot;,&quot;Fixed Deposit&quot;
,&quot;NCD&quot;,&quot;NCD&quot;
,&quot;Bonds&quot;,&quot;Bonds&quot;
,&quot;FMP&quot;,&quot;FMP&quot;
,&quot;Traditional Insurance Plan&quot;,&quot;Traditional Insurance Plan&quot;
,&quot;Savings&quot;,&quot;Savings&quot;
,&quot;Gold ETF&quot;,&quot;Gold ETF&quot;
,&quot;Gold MF&quot;,&quot;Gold MF&quot;
,&quot;Gold Scheme&quot;,&quot;Gold Scheme&quot;
,&quot;Physical Gold&quot;,&quot;Physical Gold&quot;
,&quot;Property&quot;,&quot;Property&quot;
,&quot;Land&quot;,&quot;Land&quot;
,&quot;REIT&quot;,&quot;REIT&quot;
,&quot;Home Loan&quot;,&quot;Home Loan&quot;
,&quot;Personal Loan&quot;,&quot;Personal Loan&quot;
,&quot;Business Loan&quot;,&quot;Business Loan&quot;
,&quot;Car Loan&quot;,&quot;Car Loan&quot;
,&quot;Mortgage Loan&quot;,&quot;Mortgage Loan&quot;
,&quot;Home Loan Transfer&quot;,&quot;Home Loan Transfer&quot;
,&quot;Commercial purchase&quot;,&quot;Commercial purchase&quot;
,&quot;Life Insurance&quot;,&quot;Life Insurance&quot;
,&quot;Health Insurance&quot;,&quot;Health Insurance&quot;
,&quot;Critical Illness&quot;,&quot;Critical Illness&quot;
,&quot;Top Up&quot;,&quot;Top Up&quot;
,&quot;Accident benefit&quot;,&quot;Accident benefit&quot;
,&quot;Credit Rating Report&quot;,&quot;Credit Rating Report&quot;
,&quot;Tax Planning &amp; filing&quot;,&quot;Tax Planning &amp; filing&quot;
,&quot;Will Writing&quot;,&quot;Will Writing&quot;
,&quot;Trust Formation&quot;,&quot;Trust Formation&quot;
,&quot;None&quot;)</formula>
        <name>Investment Type population</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Product_Name_Population</fullName>
        <field>Name</field>
        <formula>Product__r.Product_Name__c</formula>
        <name>Product Name Population</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Product Default Allocation Name Population</fullName>
        <actions>
            <name>Asset_Class_Population</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Investment_Type_population</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Product_Name_Population</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When Product Default Allocation record is created, selected Product Name will get populated in the Name field.</description>
        <formula>Product__c &lt;&gt; NULL</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
