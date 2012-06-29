<cfsetting showdebugoutput="no">

<cfset base="http://#cgi.HTTP_HOST##GetDirectoryFromPath(cgi.SCRIPT_NAME)#">


<cffunction name="test" output="yes">
	<CFTHREAD ACTION="RUN" NAME="T#CreateUUID()#">
    <cfhttp url="#base#call.cfm">
        <cfhttpparam type="cookie" name="CFID" value="#session.CFID#">
        <cfhttpparam type="cookie" name="CFToken" value="#session.CFToken#">
    </cfhttp>
    #cfhttp.FileContent#
    </cfthread>
</cffunction>



<cfset test()>
<cfset test()>
<cfset test()>
<cfset test()>

<cfthread action="join"/>

<cfloop collection="#cfthread#" item="key">
	<cfset t=cfthread[key]>
    <cfoutput>#t.output#</cfoutput>
</cfloop>
