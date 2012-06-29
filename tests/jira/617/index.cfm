<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>



<cftry>
    <cfquery datasource="railo_mirror">
    select * from testTinyInt617
    </cfquery>
    <cfcatch>
        <cfquery datasource="railo_mirror">
        CREATE TABLE testTinyInt617 (
        id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
        tiny TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
        bity BIT
        );
        </cfquery>
    </cfcatch>
</cftry>


<cfquery datasource="railo_mirror">
truncate table testTinyInt617
</cfquery>


<cfquery datasource="railo_mirror">
INSERT INTO testTinyInt617(tiny,bity)
VALUES(5,1);
</cfquery>

<cfquery datasource="railo_mirror" name="test">
select * from testTinyInt617
</cfquery>

<cf_valueEquals left="#test.id#" right="1">
<cf_valueEquals left="#test.bity#" right="1">
<cf_valueEquals left="#test.tiny#" right="1">