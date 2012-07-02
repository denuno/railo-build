<cflock scope="server" timeout="3">
	<cfif not structKeyExists(server,"ci")>
		<cfset server.ci = {"started"=now(),"runs"=arrayNew(1)} />
		<cfset server.ci.runningbuild = "false" />
		<cfset server.ci.startedbuild = "" />
	</cfif>
	<cfif structKeyExists(server,"buildthread") && structKeyExists(server.buildthread,"run")>
		<cfset request.currentrun = server.buildthread.run />
	<cfelse>
		<cfset request.currentrun = {target:""} />
	</cfif>
	<cfset request.ci = server.ci />
	<cfset request.runningbuild = server.ci.runningbuild />
</cflock>
