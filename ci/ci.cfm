<cffunction name="runit">
	<cfif not structKeyExists(server,"ci")>
		<cfset server.ci = {"started"=now(),"runs"=arrayNew(1)} />
	</cfif>
	<cfsetting requesttimeout="999" />
	<cfset var properties = structNew() />
	<cfif structKeyExists(url,"target")>
		<cfset target = url.target />
	<cfelse>
		<cfset var target = "check.project.for.newrevision.git" />
		<cfset target = "help" />
		<cfset target = "set.mappings">
		<cfset var target = "build" />
		<cfset var target = "tests.build.start.run.stop.ifnew" />
	</cfif>
	<cfset var run = {"started"=now(), "target"=target,"status"="fail"}  />
	<cfset variables.buildDirectory = getDirectoryFromPath(getCurrentTemplatePath()) & "../build/" />
	<cfset properties["temp.dir"] = getDirectoryFromPath(getCurrentTemplatePath()) & "builds" />
	<cftry>
		<cfdirectory action="delete" directory="#properties["temp.dir"]#" recurse="true" />
		<cfcatch></cfcatch>
	</cftry>
	<cfdirectory action="create" directory="#properties["temp.dir"]#" />
	<cfset properties["cfdistro.target.build.dir"] = variables.buildDirectory />
	<cfset properties["server.type"] = "runwar" />
	<cfset properties["runwar.port"] = "8181" />
	<cfset properties["runwar.stop.socket"] = "8971" />
	<cf_antrunner antfile="#variables.buildDirectory#build.xml" properties="#properties#" target="#target#">
	<cfset run.status = "success" />
	<cfset run.errortext = cfantrunner.errortext />
	<cfset run.ended = now() />
	<cfset var logFile = expandPath('/../dist/') & "commit." & cfantrunner.properties["build.lastcommithash"] & ".log" />
	<cfset arrayAppend(server.ci.runs,run) />
	<cfif fileExists(logFile)>
		<cffile action="append" file="#logFile#" output="#cfantrunner.errortext##cfantrunner.outtext#" />
	</cfif>
	<cfoutput>
	<pre>#cfantrunner.errortext#</pre>
	<pre>#cfantrunner.outtext#</pre>

	<cfdump var="#logFile#">
	</cfoutput>
</cffunction>

Running ant task
<cfoutput>#runit()#</cfoutput>
