<cffunction name="runit">
	<cfsetting requesttimeout="999" />
	<cflock scope="server" timeout="3">
		<cfif not structKeyExists(server,"ci")>
			<cfset server.ci = {"started"=now(),"runs"=arrayNew(1)} />
			<cfset server.ci.runningbuild = "false" />
		</cfif>
		<cfset request.runningbuild = server.ci.runningbuild />
	</cflock>

	<cfif not request.runningbuild>
		<cfthread action="run" name="buildthread">
			<cfset server.ci.runningbuild = true />
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
			<cfset var run = {"id"=createUUID(),"started"=now(), "target"=target,"status"="starting"}  />
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
			<cfset run.status = "run" />
			<cfset run.commithash = cfantrunner.properties["build.lastcommithash"] />
			<cfset run.errortext = cfantrunner.errortext />
			<cfset run.outtext = cfantrunner.outtext />
			<cfset run.ended = now() />
			<cfset server.ci.runningbuild = false />
			<cfset var logFile = expandPath('/../dist/') & "commit." & cfantrunner.properties["build.lastcommithash"] & ".log" />
<!---
			use files instead so we only worry about disk space vs memory too
			<cfset arrayAppend(server.ci.runs,run) />
 --->
			<cfif fileExists(logFile)>
				<cffile action="append" file="#logFile#" output="#cfantrunner.errortext##cfantrunner.outtext#" />
			</cfif>
			<cfset runsdir = expandPath('/../dist/buildlog/') />
			<cftry><cfdirectory action="create" directory="#runsdir#"><cfcatch></cfcatch></cftry>
			<cffile action="write" file="#runsdir#/#run.id#.json" output="#serializeJSON(run)#" />
			<!---
					<cfoutput>
					<pre>#cfantrunner.errortext#</pre>
					<pre>#cfantrunner.outtext#</pre>
					<cfdump var="#logFile#">
					</cfoutput>
			 --->
		</cfthread>
		Started build.
	<cfelse>
		A build is currently running.  Please wait for it to complete.
	</cfif>
</cffunction>

Running ant task
<cfoutput>#runit()#</cfoutput>
