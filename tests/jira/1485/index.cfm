<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>


<cfset test=new Test()>
<cf_valueEquals left="#test.testSusi()#" right="testSusi" cs="true">