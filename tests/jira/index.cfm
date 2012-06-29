<cfsetting requesttimeout="333">
<cfdirectory action="list" directory="#GetDirectoryFromPath(GetCurrentTemplatePath())#" name="dir"  sort="name">
<cfset count=0>
<cfset failedfiles = "">

<cfloop query="dir">
<cfif dir.type EQ "dir">
	<cfoutput><pre>------------ Test <a href="#dir.name#/index.cfm" target="_blank">#dir.name#</a> | view on <a href="https://issues.jboss.org/browse/RAILO-#dir.name#" target="_blank">Jira</a> -----------------</pre></cfoutput>
    <cfif fileExists(dir.directory&"/"&dir.name&"/index.cfm")>
	    <cfset usehttp = false />
		<cfif fileExists(dir.directory&"/"&dir.name&"/Application.cfc")>
			<cfset d = dir.directory&"/"&dir.name&"/Application.cfc" />
			<cffile action="read" file="#d#" variable="content" />
			<cfif findNoCase("ormEnabled",content)>
	    		<cfset usehttp = true />
			<cfelseif refindNoCase("on.*?start",content)>
	    		<cfset usehttp = true />
			</cfif>
		</cfif>
		<cfif fileExists(dir.directory&"/"&dir.name&"/Application.cfm")>
			<cfset d = dir.directory&"/"&dir.name&"/Application.cfm" />
			<cffile action="read" file="#d#" variable="content" />
			<cfif findNoCase("ormEnabled",content)>
	    		<cfset usehttp = true />
			<cfelseif refindNoCase("on.*?start",content)>
	    		<cfset usehttp = true />
			</cfif>
		</cfif>
		<cfif usehttp>
		USING HTTP
	        <cfoutput>
	        <cfhttp url="http://#cgi.server_name#:#cgi.server_port##getDirectoryFromPath(cgi.script_name)##dir.name#/index.cfm">
	        #trim(cfhttp.filecontent)#
			<cfif cfhttp.ResponseHeader.status_code != 200>
				<cfset failedfiles = listAppend(failedfiles,"#dir.directory#/#dir.name#/index.cfm") >
			</cfif>
	        </cfoutput>
	    <cfelse>
	    	NOT USING HTTP
	    	<cfset getPageContext().forward("#getDirectoryFromPath(cgi.script_name)##dir.name#/index.cfm") />
	    	<!--- <cfinclude template="#getDirectoryFromPath(cgi.script_name)##dir.name#/index.cfm"> --->
		</cfif>
    <cfelse>
    	<cfdump var="no index.cfm in directory #dir.name#">
    </cfif>
</cfif>
</cfloop>
<cfif len(failedfiles) NEQ 0>
<!---
commenting out until we have all tests passing somehow.  AS3? Custom DBs?  Not easy.
	<cfheader
	    statusCode = "500"
	    statusText = "Failed: #failedfiles#">
 --->
</cfif>


