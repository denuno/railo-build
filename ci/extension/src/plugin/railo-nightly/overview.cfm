<cfset var configFile = getDirectoryFromPath(getCurrentTemplatepath()) & "remote.txt" />

<cfif NOT fileExists(configFile)>
	<cffile action="write" file="#configFile#" output="http://#cgi.HTTP_HOST#/" addnewline="false">
</cfif>
<cffile action="read" file="#configFile#" variable="remoteuri">
<cfhttp url="#trim(remoteuri)#index.cfm?json=1" result="builds">
<cftry>
<cfset builds = deserializeJSON(builds.filecontent) />
<cfcatch>REMOTE URI UNAVAILABLE! <cfoutput>#builds.filecontent#</cfoutput><cfset builds=arrayNew(1)></cfcatch>
</cftry>
<cfoutput>
<h2>Nightly Build</h2>
<form action="#action('saveRemote')#" method="post" enctype="multipart/form-data">
  Remote URI <input type="text" name="remoteuri" id="remoteuri" size="53" value="#remoteuri#" />
</form>
<table class="tbl" width="650">
<tr>
	<td></td>
	<td class="tblHead">Build</td>
	<td class="tblHead">Size</td>
	<td class="tblHead">Built</td>
</tr>
<cfloop array="#builds#" index="build">
<tr>
	<td></td>
	<td class="tblHead"><a href="#action('buildinfo')#&buildid=#build.name#">#build.name#</a></td>
	<td class="tblHead">#round(build.size/1048576)#M</td>
	<td class="tblHead">#build.dateLastModified#</td>
</tr>
</cfloop>
</table>
</cfoutput>