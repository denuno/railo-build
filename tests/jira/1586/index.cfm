<cfsetting showdebugoutput="yes">

<cfset base="http://#cgi.HTTP_HOST##GetDirectoryFromPath(cgi.SCRIPT_NAME)#">

<cfhttp url="#base#target.cfm" method="post">
		<cfloop from="1" to="#arrayLen(request.data)#" index="i">
        	<cfhttpparam type="formfield" name="str#i#" value="#request.data[i]#">
        </cfloop>
</cfhttp>
<cfoutput>
#cfhttp.FileContent#
</cfoutput>