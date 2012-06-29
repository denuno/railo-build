<cfsetting showdebugoutput="no">
<cfset dsn="railo_mirror">



<cfobjectcache action="clear">

<!--- Create T1385 --->
<cftry>
	<cfquery datasource="#dsn#">
        select * from T1385
    </cfquery>
    <cfcatch>
    <cfquery datasource="#dsn#">
        CREATE TABLE T1385 (
            id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
            data VARCHAR(100) 
        )TYPE=innodb;
    </cfquery>
    </cfcatch>
</cftry>

<cfobjectcache action="clear">
<cfobjectcache action="size" result="size">
<cf_valueEquals left="#size#" right="0">

<cfquery name="getInformation" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
Select id from T1385
where id<><cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfobjectcache action="size" result="size">
<cf_valueEquals left="#size#" right="1">

<cfobjectcache action="clear" filter="*T1385*">
<cfobjectcache action="size" result="size">
<cf_valueEquals left="#size#" right="0">















