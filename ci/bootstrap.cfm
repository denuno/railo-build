<cflock scope="server" timeout="3">
	<cfif not structKeyExists(server,"ci")>
		<cfset server.ci = {"started"=now(),"runs"=arrayNew(1)} />
		<cfset server.ci.runningbuild = "false" />
		<cfset server.ci.startedbuild = "" />
	</cfif>
	<cfset request.runningbuild = server.ci.runningbuild />
</cflock>
