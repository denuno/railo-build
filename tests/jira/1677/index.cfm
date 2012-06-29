<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>



<cfscript>
test = CreateObject("component", "B").write();
</cfscript>


<cf_valueEquals left="#trim(test)#" right="A Reached!">