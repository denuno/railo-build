<cfsetting showdebugoutput="yes">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>
<cfset session.x=1>
<cf_valueEquals left="" right="">