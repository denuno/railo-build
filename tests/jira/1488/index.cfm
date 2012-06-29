<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>

<cfset dsn="railo_mirror">

<!--- create the table --->
<cfquery name="tables" datasource="#dsn#">
show tables like 'jira1488'
</cfquery>
<cfif tables.recordcount EQ 0>
    <cfquery name="tables" datasource="#dsn#">
    CREATE TABLE `jira1488` (`theDate` DATETIME NOT NULL );
    </cfquery>
</cfif>

<!--- delete everything from prior tests --->
<cfquery name="test" datasource="#dsn#">
    truncate table jira1488
</cfquery>


<!--- set a timezone different from database timezone --->
<cfset setTimezone("US/Hawaii")>


<!--- insert a record as string (timezone from datasource is used) --->
<cfquery name="tables" datasource="#dsn#">
    INSERT INTO jira1488 (theDate) values ('2011-08-25 21:27:00');
</cfquery>


<cfquery name="test" datasource="#dsn#">
    select theDate from jira1488
</cfquery>
<cf_valueEquals left="#test.theDate#" right="{ts '2011-08-25 09:27:00'}">

<cfquery name="test" datasource="#dsn#">
    truncate table jira1488
</cfquery>


<!--- insert a record as date object (this is indepenend from any timezone) --->
<cfquery name="tables" datasource="#dsn#">
    INSERT INTO jira1488 (theDate) values (<cfqueryparam value="2011-08-25 21:27:00" cfsqltype="cf_sql_timestamp">);
</cfquery>


<cfquery name="test" datasource="#dsn#">
    select theDate from jira1488
</cfquery>
<cf_valueEquals left="#test.theDate#" right="{ts '2011-08-25 21:27:00'}">

<cfquery name="test" datasource="#dsn#">
    truncate table jira1488
</cfquery>

