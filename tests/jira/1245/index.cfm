<cfsetting showdebugoutput="no">
<cfset test1245()>

<cffunction name="test1245" access="private" returntype="void">
       <cfargument name="arg1" default="sss">
       <cfset local.a="AA">
		<cf_test>
        <cf_valueEquals left="#local.a#" right="AAA">
        <cf_valueEquals left="#local.b#" right="BBB">
        <cf_valueEquals left="#local.c#" right="CCC">
</cffunction>