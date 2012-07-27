<cffunction name="loadProperties">
	<cfargument name="propsfile" required="true" />
	<cfscript>
		var properties = createObject('java', 'java.util.Properties').init();
		var fileStream = createObject('java', 'java.io.FileInputStream').init(propsfile);
		properties.load(fileStream);
		return properties;
	</cfscript>
</cffunction>

<cffunction name="storeProperties">
	<cfargument name="propsfile" required="true" />
	<cfargument name="properties" required="true" />
	<cfargument name="comment" default="modified #now()#" />
	<cfscript>
		var fileStream = createObject('java', 'java.io.FileOutputStream').init(propsfile);
		properties.store(fileStream,comment);
		return properties;
	</cfscript>
</cffunction>

<cffunction name="runit">
	<cfsetting requesttimeout="999" />
	<cfinclude template="bootstrap.cfm">

	<cflock scope="server" timeout="5">
	<cfif !server.ci.runningbuild>
		<cfthread action="run" name="buildthread">
			<cftry>
				<cfset server.ci.runningbuild = true />
				<cfset server.ci.startedbuild = now() />
				<cfset var properties = structNew() />
				<cfif structKeyExists(url,"target")>
					<cfset target = url.target />
				<cfelse>
	<!---
					<cfset var target = "check.project.for.newrevision.git" />
					<cfset target = "help" />
					<cfset target = "set.mappings">
					<cfset var target = "build" />
					<cfset var target = "tests.build.start.run.stop.ifnew" />
	 --->
					<cfset var target = "project.build.ifnew" />
				</cfif>
				<cfset var run = {"id"=createUUID(),"started"=now(), "target"=target,"status"="starting"}  />
				<cfset thread.run = run  />
				<cfset var buildDirectory = getDirectoryFromPath(getCurrentTemplatePath()) & "../build/" />
				<cfset var ciProps = loadProperties(buildDirectory & "build.ci.properties") />
				<cfset var buildErrorEmails = ciProps.getProperty("build.error.emails","") />
				<cfset properties["temp.dir"] = getDirectoryFromPath(getCurrentTemplatePath()) & "/builds" />
				<cftry>
					<cfdirectory action="delete" directory="#properties["temp.dir"]#" recurse="true" />
					<cfcatch></cfcatch>
				</cftry>
				<cfdirectory action="create" directory="#properties["temp.dir"]#" />
				<cfset properties["cfdistro.target.build.dir"] = buildDirectory />
				<cfset properties["server.type"] = "runwar" />
				<cfset properties["runwar.port"] = "8181" />
				<cfset properties["runwar.stop.socket"] = "8971" />
				<cfloop list="#structKeyList(url)#" index="daVar">
					<cfset properties[daVar] =  url[daVar] />
				</cfloop>
				<cfloop list="#structKeyList(form)#" index="daVar">
					<cfset properties[daVar] =  form[daVar] />
				</cfloop>
				<cfset Thread.outputstream = createObject("java","java.io.ByteArrayOutputStream") />
				<cfset proplist = "" />
				<cfloop list="#structKeyList(properties)#" index="key">
					<cfset proplist &= "#key#=#properties[key]# " />
				</cfloop>
				<cf_antrunner antfile="#buildDirectory#build.xml" target="#target#" properties="#properties#" outputstream="#Thread.outputstream#"/>
<!---
				<cf_antrunner antfile="#buildDirectory#build.xml" properties="#properties#" outputstream="#Thread.outputstream#">
					<cfset writeoutput('<cfdistro target="#target#" properties="#proplist#" />') />
				</cf_antrunner>
 --->
				<cfset run.status = "run" />
				<cfset run.target = target />
				<cfset run.commithash = cfantrunner.properties["build.lastcommithash"] />
				<cfset run.errortext = cfantrunner.errortext />
				<cfset run.outtext = cfantrunner.outtext />
				<cfset var logFile = expandPath('/../dist/') & "commit." & cfantrunner.properties["build.lastcommithash"] & ".log" />
				<cfif fileExists(logFile)>
					<cffile action="append" file="#logFile#" output="#cfantrunner.errortext##cfantrunner.outtext#" />
				</cfif>
				<cfcatch>
					<cfset run.status = "error" />
					<cfset run.commithash = "" />
					<cfset run.errortext = cfcatch.message & " " & cfcatch.detail />
					<cfset run.errortext &= " Sending errors to #buildErrorEmails#" />
					<cfif !structKeyExists(run,"outtext") && !isNull(Thread.outputstream)>
						<cfset run.outtext = Thread.outputstream.toString() />
					</cfif>
				</cfcatch>
			</cftry>
			<cfset run.ended = now() />
			<cfset server.ci.runningbuild = false />
			<cfset server.ci.startedbuild = "" />
			<cfset server.buildthread = javacast("null","") />
			<cftry>
				<cfdirectory action="delete" directory="#properties["temp.dir"]#" recurse="true" /><cfcatch></cfcatch>
			</cftry>
			<cfif !find("Revisions are the same, not ",run.outtext)>
				<cfset emailRun(buildErrorEmails,run) />
				<cfset runsdir = expandPath('/../dist/buildlog/') />
				<cftry><cfdirectory action="create" directory="#runsdir#"><cfcatch></cfcatch></cftry>
				<cffile action="write" file="#runsdir#/#run.id#.json" output="#serializeJSON(run)#" />
			</cfif>
			<!---
					<cfoutput>
					<pre>#cfantrunner.errortext#</pre>
					<pre>#cfantrunner.outtext#</pre>
					<cfdump var="#logFile#">
					</cfoutput>
			 --->
		</cfthread>
		<cfset server.buildthread = buildthread />
		Started build.
	<cfelse>
		A build is currently running.  Please wait for it to complete.
		<cfif structKeyExists(server,"buildthread") && structKeyExists(server.buildthread,"outputstream")>
			<pre><cfoutput>#toString(server.buildthread.outputstream)#</cfoutput></pre>
		<cfelseif !structKeyExists(server,"buildthread")>
			<br />The build thread isn't there.  Forcing idle.
			<cfset server.ci.runningbuild = false />
			<cfexecute name="#expandPath('.')#/../build/psaux.sh" timeout="7"  variable="ps"/><br />
			Current number of running java processes: <cfoutput>#arrayLen(ps.split("cfml\s+\d+"))#</cfoutput>
			<pre>#ps#</pre>
		</cfif>
	</cfif>
	</cflock>
</cffunction>

<cffunction name="emailRun">
	<cfargument name="emails" required="true">
	<cfargument name="run" required="true">
	<cftry>
		<cfmail server="127.0.0.1" to="#emails#" from="cfml@loganberry.viviotech.net" subject="[railo-build] target: #run.target# : #run.status#">#run.errortext#
#run.outtext#
#run.commithash#
		</cfmail>
		<cfcatch>
		</cfcatch>
	</cftry>
</cffunction>
<html>
<head>
<meta http-equiv="refresh" content="3; url=index.cfm" />
</head>
<body>
Running ant task
<cfoutput>#runit()#</cfoutput>
</body>
</html>

