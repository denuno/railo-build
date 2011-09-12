<cfset distDir = expandPath('/../dist') />
<cfdirectory name="builds" action="list" directory="#distDir#" filter="*.rc">
<cfif structKeyExists(url,"list")>
	<cfset json = "[ " />
	<cfloop query="builds">
		<cfset json &= "{'name':" & serializeJSON(builds["name"][currentrow]) & ",'size':" &
		serializeJSON(builds["size"][currentrow]) & ",'built':" & serializeJSON(builds["dateLastModified"][currentrow]) & "},">
	</cfloop>
	<cfoutput>#left(json,len(json)-1)#]</cfoutput>
	<cfabort>
</cfif>
<cfif structKeyExists(url,"info")>
	<cfif listLen(url.buildid,".") eq 6>
		<cfset logfile = "commit." & listGetAt(url.buildid,5,".") & ".log">
	<cfelse>
		<cfset logfile = "commit.log">
	</cfif>
	<cffile action="read" file="#distDir#/#logFile#" variable="commitlog">
	<cfset json = "{'commits':" & serializeJSON(commitLog) & "}">
	<cfoutput>#json#</cfoutput>
	<cfabort>
</cfif>
<h2>Continious Integration</h2>
<h3><a href="ci.cfm?target=build">Run a Build</a></h3>
<h3>Available builds</h3>
<cfdirectory name="builds" action="list" directory="#expandPath('/../dist')#" filter="*.rc">
<cfloop query="builds">
	<cfoutput><a href="./#name#">#name#</a>  <a href="./commit.#listGetAt(name,5,".")#.log">build log</a></cfoutput><br />
</cfloop>

<cfif structKeyExists(server,"ci")>
<cfdump var="#server.ci#">
</cfif>