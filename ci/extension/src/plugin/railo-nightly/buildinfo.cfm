<cfset var configFile = getDirectoryFromPath(getCurrentTemplatepath()) & "remote.txt" />
<cffile action="read" file="#configFile#" variable="remoteuri">
<cfhttp url="#trim(remoteuri)#commit.#listGetAt(buildid,5,".")#.log" result="build">
<cfset build = build.filecontent />
<cfoutput>
<h2><a href="#action('overview')#">Nightly Build</a></h2>
<br /><strong><cfoutput>#buildid# <a href="#action('install')#buildid=#buildid#">&lt;--INSTALL</a></cfoutput></strong>
<pre><cfoutput>#build#</cfoutput></pre>
</cfoutput>

