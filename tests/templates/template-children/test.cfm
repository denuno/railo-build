<cfsetting showdebugoutput="no">

<cfset base="http://#cgi.HTTP_HOST##GetDirectoryFromPath(cgi.SCRIPT_NAME)#">


<cffunction name="clear">
	<cfset StructDelete(session,"exception",false)>
</cffunction>

<cffunction name="test1250">
	<cfargument name="name" type="string" required="yes">
	<cfargument name="hideFileContent" type="boolean" default="false">

	<cfhttp url="#base##arguments.name#">
        <cfhttpparam type="cookie" name="CFID" value="#session.CFID#">
        <cfhttpparam type="cookie" name="CFToken" value="#session.CFToken#">
    </cfhttp>
    <cfif not hideFileContent><cfoutput>#cfhttp.FileContent#</cfoutput></cfif>
    
    <cf_valueEquals left="#session.exception.ErrorCode#" right="CUSTOM_ERROR" label="#name#:CUSTOM_ERROR">
    <cf_valueEquals left="#session.exception.ExtendedInfo#" right="testMe" label="#name#:ExtendedInfo">
    <cf_valueEquals left="#session.exception.code#" right="CUSTOM_ERROR" label="#name#:code">
    <cf_valueEquals left="#session.exception.extended_info#" right="testMe" label="#name#:extended_info">

    <cfset clear()>

</cffunction>

<cfset test1250("first")>
<cfset test1250("second")>
<cfset test1250("third")>

