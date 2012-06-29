<cffunction name="clear">
	<cfset StructDelete(session,"index.cfm:start",false)>
	<cfset StructDelete(session,"index.cfm:end",false)>
	<cfset StructDelete(session,"target.cfm:start",false)>
	<cfset StructDelete(session,"target.cfm:end",false)>
</cffunction>

<cfset base="http://#cgi.HTTP_HOST##GetDirectoryFromPath(cgi.SCRIPT_NAME)#">

<cffunction name="test1246">
	<cfargument name="name" type="string" required="yes">
	<cfargument name="is" type="boolean" required="yes">
	<cfargument name="ie" type="boolean" required="yes">
	<cfargument name="ts" type="boolean" required="yes">
	<cfargument name="te" type="boolean" required="yes">
	<cfargument name="hideFileContent" type="boolean" default="false">
	<cfhttp url="#base##arguments.name#/">
        <cfhttpparam type="cookie" name="CFID" value="#session.CFID#">
        <cfhttpparam type="cookie" name="CFToken" value="#session.CFToken#">
    </cfhttp>
    <cfif not hideFileContent><cfoutput>#cfhttp.FileContent#</cfoutput></cfif>
    <cf_valueEquals left="#structKeyExists(session,"index.cfm:start")#" right="#arguments.is#" label="#arguments.name#-index.cfm:start">
    <cf_valueEquals left="#structKeyExists(session,"index.cfm:end")#" right="#arguments.ie#" label="#arguments.name#-index.cfm:end">
    <cf_valueEquals left="#structKeyExists(session,"target.cfm:start")#" right="#arguments.ts#" label="#arguments.name#-target.cfm:start">
    <cf_valueEquals left="#structKeyExists(session,"target.cfm:end")#" right="#arguments.te#" label="#arguments.name#-target.cfm:end">
    <cfset clear()>

</cffunction>


<!--- application.cfc with cflocation WITHOUT function onRequest ---->
<cfset test1246("application-cfc-location",true,true,true,true)>

<!--- application.cfc with cflocation WITH function onRequest ---->
<cfset test1246("application-cfc-onrequest-location",true,true,true,true)>

<!--- application.cfc with abort WITHOUT function onRequest ---->
<cfset test1246("application-cfc-abort",true,true,false,false)>

<!--- application.cfc with abort WITH function onRequest ---->
<cfset test1246("application-cfc-onrequest-abort",true,true,false,false)>

<!--- application.cfc with throw WITHOUT function onRequest ---->
<cfset test1246("application-cfc-throw",true,false,false,false,true)>

<!--- application.cfc with throw WITH function onRequest ---->
<cfset test1246("application-cfc-onrequest-throw",true,false,false,false,true)>



<!--- application.cfm with cflocation ---->
<cfset test1246("application-cfm-location",true,false,true,true)>

<!--- application.cfm with abort ---->
<cfset test1246("application-cfm-abort",true,false,false,false)>

<!--- application.cfm with throw ---->
<cfset test1246("application-cfm-throw",true,false,false,false,true)>



