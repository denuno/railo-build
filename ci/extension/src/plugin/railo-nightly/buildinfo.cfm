<cfset var configFile = getDirectoryFromPath(getCurrentTemplatepath()) & "remote.txt" />
<cffile action="read" file="#configFile#" variable="remoteuri">
<cfhttp url="#remoteuri#index.cfm?info=1&buildid=#url.buildid#" result="build">
<cfset build = deserializeJSON(build.filecontent) />
<cfoutput>
<h2><a href="#action('overview')#">Nightly Build</a></h2>
<br /><strong><cfoutput>#buildid# <a href="#action('install')#buildid=#buildid#">&lt;--INSTALL</a></cfoutput></strong>
<pre><cfoutput>#build.commits#</cfoutput></pre>
</cfoutput>

