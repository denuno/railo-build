<cfcomponent hint="railo-nightly" extends="railo-context.admin.plugin.Plugin">

	<cffunction name="init" hint="this function will be called to initalize">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
	</cffunction>


	<cffunction name="overview" output="yes" hint="list all font files, with add and delete">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		<cfargument name="req" type="struct">
	</cffunction>

	<cffunction name="buildinfo" output="yes" hint="list all font files, with add and delete">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		<cfargument name="req" type="struct">
	</cffunction>

	<cffunction name="saveRemote" output="yes" hint="list all font files, with add and delete">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		<cfargument name="req" type="struct">
		<cfset var configFile = getDirectoryFromPath(getCurrentTemplatepath()) & "remote.txt" />
		<cfif NOT fileExists(configFile)>
			<cffile action="write" file="#configFile#" output="#form.remoteuri#">
		</cfif>
		<cfoutput><cfinclude template="overview.cfm"/></cfoutput>
	</cffunction>





	<cffunction name="safeString" returntype="string" output="false">
		<cfargument name="stringToClean" required="true" type="string">
		<cfreturn rereplacenocase(stringToClean,'[^a-z|A-Z|0-9|_]','','all')>
	</cffunction>

</cfcomponent>