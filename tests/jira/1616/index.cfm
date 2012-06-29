<cfsetting showdebugoutput="no">



<cfset base="http://#cgi.HTTP_HOST##GetDirectoryFromPath(cgi.SCRIPT_NAME)#">



<cffunction name="test">
	<cfargument name="name" type="string" required="yes">
	<cfargument name="right" type="string" required="yes">
	
	<cfhttp url="#base##arguments.name#"></cfhttp>  
    <cf_valueEquals left="#trim(cfhttp.FileContent)#" right="#arguments.right#">
</cffunction>



<cfset test("test1.cfm","abc")>
<cfif server.ColdFusion.ProductName EQ "Railo"><cfset test("test2.cfm","abc")></cfif>
<cfset test("test3.cfm","abc")>