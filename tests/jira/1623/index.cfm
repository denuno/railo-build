<cfsetting showdebugoutput="yes">
<cfset ds="railo_mirror">

<cftry>
    <cfquery datasource="#ds#">
    CREATE TABLE test1623 (
    pk int NOT NULL,
    test int NULL
    )
    </cfquery>
	<cfcatch></cfcatch>
</cftry>


<cfquery datasource="#ds#" result="qResult" name="qInsert">
INSERT INTO test1623 (pk,test)
VALUES (1,1)
</cfquery>

<cfquery datasource="#ds#" result="qResult" name="qInsert">
select * from test1623
</cfquery>
