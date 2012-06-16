<cfset var configFile = getDirectoryFromPath(getCurrentTemplatepath()) & "remote.txt" />
<cfset var rcDir = getDirectoryFromPath(getCurrentTemplatepath()) & "rc" />
<cftry><cfset directoryCreate(rcDir)><cfcatch></cfcatch></cftry>
<cffile action="read" file="#configFile#" variable="remoteuri">
<cfset remoteuri = trim(remoteuri) />
<cfoutput>
<h2><a href="#action('overview')#">Install Nightly Build</a></h2>
<h3>Downloading rc file...</h3>
<cfflush>
<cfhttp url="#remoteuri##buildid#">
<cfif cfhttp.StatusCode eq 500 || cfhttp.StatusCode eq 404>
	Error getting: #remoteuri#dist/#buildid#<br />
	#cfhttp.FileContent#
<cfelse>
	<cfset destRcName = buildid />
	<cfif listLen(destRcName,".") eq 6>
		<cfset destRcName = listDeleteAt(destRcName,5,".")>
	</cfif>
	<cffile action="write" file="#rcDir#/#buildid#" output="#cfhttp.FileContent#">
	<cffile action="copy" source="#rcDir#/#buildid#" destination="#expandPath('{railo-server}/../patches/')#/#destRcName#">
	INSTALLED!<br /><br />
	(#expandPath('{railo-server}/../patches/')#/#destRcName#)<br /><br />
	Now you'll need to <a href="http://#cgi.HTTP_HOST#/railo-context/admin/server.cfm?action=services.restart">restart Railo</a>.
</cfif>
</cfoutput>

