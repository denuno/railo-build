<cfcomponent>

	<cffunction name="standardInstall" output="false">
		<cfargument name="error" type="struct" />
		<cfargument name="path" type="string" />
		<cfargument name="config" type="struct" />
		<cfset var defaultstandards = "libs,tag,plugin,function" />
		<cfset var standards = "" />
		<cfdirectory action="list" directory="#path#" name="files">
		<cfloop query="files">
			<cfif listFindNoCase(defaultstandards,listFirst(name,"."))>
				<cfset standards = listAppend(standards,lcase(listFirst(name,"."))) />
			</cfif>
		</cfloop>
		<cfif find("libs",standards)>
			<cftry>
				<cfdirectory action="delete" directory="#getTempDirectory()#/#variables.extensionTag#libs" recurse="true">
				<cfcatch>
				</cfcatch>
			</cftry>
			<cfzip
				action = "unzip"
				destination = "#getTempDirectory()#/#variables.extensionTag#libs"
				file = "#path#libs.zip"
				overwrite = "yes"
				recurse = "yes"
				storePath = "yes" />
			<cfset addJars(error,"#getTempDirectory()#/#variables.extensionTag#libs",arguments.config) />
		</cfif>
		<cfif find("tag",standards)>
			<cfset config.isBuiltInTag=config.isBuiltInTag EQ "true" />
			<cfif config.isBuiltInTag>
				<cfzip
					action = "unzip"
					destination = "#getLibraryPath()#/tag"
					file = "#path#tag.zip"
					overwrite = "yes"
					recurse = "yes"
					storePath = "yes" />
				<cfset addCustomTagsMapping("#getLibraryPath()#/tag/#variables.extensionTag#") />
			<cfelse>
				<cfzip
					action = "unzip"
					destination = "#getLibraryPath()#/../customtags/"
					file = "#path#tag.zip"
					overwrite = "yes"
					recurse = "yes"
					storePath = "yes" />
				<cfset addCustomTagsMapping("#getLibraryPath()#/../customtags/#variables.extensionTag#") />
			</cfif>
		</cfif>
		<cfif find("function",standards)>
			<cfzip
				action = "unzip"
				destination = "#getLibraryPath()#/function"
				file = "#path#function.zip"
				overwrite = "yes"
				recurse = "yes"
				storePath = "yes" />
		</cfif>
		<cfif find("plugin",standards)>
			<cfzip
				action = "unzip"
				destination = "#getPluginDir()#"
				file = "#path#plugin.zip"
				overwrite = "yes"
				recurse = "yes"
				storePath = "yes" />
		</cfif>
	</cffunction>

	<cffunction name="standardUnInstall" output="false">
		<cfargument name="path" type="string" />
		<cfargument name="config" type="struct" />
		<cfset var defaultstandards = "libs,tag,plugin,function" />
		<cfset var standards = "" />
		<cfset var errors=array() />
		<cfdirectory action="list" directory="#path#" name="files">
		<cfloop query="files">
			<cfif listFindNoCase(defaultstandards,listFirst(name,"."))>
				<cfset standards = listAppend(standards,lcase(listFirst(name,"."))) />
			</cfif>
		</cfloop>
		<cftry>
			<cfif find("libs",standards)>
				<cfzip
					action = "unzip"
					destination = "#getTempDirectory()#/#variables.extensionTag#libs"
					file = "#path#libs.zip"
					overwrite = "yes"
					recurse = "yes"
					storePath = "yes" />
				<cfset removeJars(structNew(),"#getTempDirectory()#/#variables.extensionTag#libs",arguments.config) />
				<cfdirectory action="delete" directory="#getTempDirectory()#/#variables.extensionTag#libs" recurse="true">
			</cfif>
			<cfif find("tag",standards)>
				<cfset config.isBuiltInTag=config.isBuiltInTag EQ "true" />
				<cfif config.isBuiltInTag>
					<cffile action="copy" source="#path#tag.zip" destination="ram://#variables.extensionTag#tags.zip">
					<cfdirectory action="list" name="tags" directory="zip://ram://#variables.extensionTag#tags.zip" recurse="false">
					<cffile action="delete" file="ram://#variables.extensionTag#tags.zip">
					<cfloop query="tags">
						<cfif type eq "dir">
							<cfdirectory directory="#getLibraryPath()#/tag/#name#" action="delete" recurse="yes">
						<cfelse>
							<cffile action="delete" file="#getLibraryPath()#/tag/#name#">
						</cfif>
					</cfloop>
					<cfset removeCustomTagsMapping("#getLibraryPath()#/tag/#variables.extensionTag#") />
				<cfelse>
					<cfset removeCustomTagsMapping("#getLibraryPath()#/../customtags/#variables.extensionTag#") />
					<cfdirectory directory="#getLibraryPath()#/../customtags/#variables.extensionTag#" action="delete" recurse="yes">
				</cfif>
			</cfif>
			<cfif find("function",standards)>
				<cffile action="copy" source="#path#function.zip" destination="ram://#variables.extensionTag#function.zip">
				<cfdirectory action="list" name="functions" directory="zip://ram://#variables.extensionTag#function.zip" recurse="false">
				<cffile action="delete" file="ram://#variables.extensionTag#function.zip">
				<cfloop query="functions">
					<cfif type eq "dir">
						<cfdirectory directory="#getLibraryPath()#/function/#name#" action="delete" recurse="yes">
					<cfelse>
						<cffile action="delete" file="#getLibraryPath()#/function/#name#">
					</cfif>
				</cfloop>
			</cfif>
			<cfif find("plugin",standards)>
				<cffile action="copy" source="#path#plugin.zip" destination="ram://#variables.extensionTag#plugin.zip">
				<cfdirectory action="list" name="plugins" directory="zip://ram://#variables.extensionTag#plugin.zip" recurse="false">
				<cffile action="delete" file="ram://#variables.extensionTag#plugin.zip">
				<cfloop query="plugins">
					<cfdirectory action="delete" recurse="true" directory="#getPluginDir()#/#name#" />
				</cfloop>
			</cfif>
			<cfcatch>
				<cfset ArrayAppend(errors,cfcatch) />
			</cfcatch>
		</cftry>
		<cfif arrayLen(errors) EQ 1>
			<cfthrow object="#errors[1]#" />
		<cfelseif arrayLen(errors) GT 1>
			<cfset var message="" />
			<cfset var error="" />
			<cfloop array="#errors#" index="error">
				<cfset message&=error.message&chr(13)&chr(10) />
			</cfloop>
			<cfthrow message="#message#" />
		</cfif>
	</cffunction>

	<cffunction name="addJars" returntype="string" output="no"
		hint="called from Railo to install application">
		<cfargument name="error" type="struct" />
		<cfargument name="path" type="string" />
		<cfdirectory action="list" name="qJars" directory="#path#" filter="*.jar" sort="name desc"/>
		<cfsetting requesttimeout="360" />
		<cfloop query="qJars">
			<cfadmin action="updateJar" type="#request.adminType#" password="#session["password"&request.adminType]#" jar="#path#/#name#" />
		</cfloop>
		<cftry>
			<cfadmin action="updateJar" type="#request.adminType#" password="#session["password"&request.adminType]#" jar="#path#/defaults.properties" />
			<cfcatch>
			</cfcatch>
		</cftry>
		<!---
			<cfset request.debug(qJars)>
			<cfset request.debug(path)>
			--->
	</cffunction>

	<cffunction name="removeJars" returntype="string" output="no"
		hint="called from Railo to install application">
		<cfargument name="error" type="struct" />
		<cfargument name="path" type="string" />
		<cfdirectory action="list" name="qJars" directory="#path#" filter="*.jar" sort="name desc"/>
		<cfsetting requesttimeout="360" />
		<cfloop query="qJars">
			<cfadmin action="removeJar" type="#request.adminType#" password="#session["password"&request.adminType]#" jar="#path#/#name#" />
		</cfloop>
	</cffunction>

	<cffunction name="addCustomTagsMapping" output="false">
		<cfargument name="physicalPath" />
		<cfadmin action="getCustomTagMappings" returnVariable="customtagMappings" type="#request.adminType#" password="#session["password"&request.adminType]#" />
		<cfquery name="isAlreadyMapped" dbtype="query">
			SELECT * FROM customtagMappings WHERE strphysical =
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.physicalPath#" />
		</cfquery>
		<cfif NOT isAlreadyMapped.recordcount>
			<cfadmin action="updatecustomtag" archive="false" primary="false" trusted="false" virtual="#arguments.physicalPath#" physical="#arguments.physicalPath#" type="#request.adminType#" password="#session["password"&request.adminType]#" />
		<cfelse>
			<cfthrow type="#variables.extensionTag#.mappingsThereDude" detail="'#arguments.physicalPath#' has already been mapped as a custom tag directory" />
		</cfif>
		<cfadmin action="reload" type="#request.adminType#" password="#session["password"&request.adminType]#" />
		<cfreturn />
	</cffunction>

	<cffunction name="removeCustomTagsMapping" output="false">
		<cfargument name="physicalPath" />
		<cfadmin action="getCustomTagMappings" returnVariable="customtagMappings" type="#request.adminType#" password="#session["password"&request.adminType]#" />
		<cfquery name="isAlreadyMapped" dbtype="query">
			SELECT * FROM customtagMappings WHERE strphysical =
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.physicalPath#" />
		</cfquery>
		<cfif isAlreadyMapped.recordcount>
			<cfadmin action="removecustomtag" physical="#arguments.physicalPath#" virtual="#isAlreadyMapped.virtual#" type="#request.adminType#" password="#session["password"&request.adminType]#" />
		<cfelse>
			<cfthrow type="#variables.extensionTag#.noMappingToRemove" detail="no mapping for path: #arguments.physicalPath#" />
		</cfif>
		<cfadmin action="reload" type="#request.adminType#" password="#session["password"&request.adminType]#" /> <cfadmin action="getCustomTagMappings" returnVariable="customtagMappings" type="#request.adminType#" password="#session["password"&request.adminType]#" />
		<cfquery name="isAlreadyMapped" dbtype="query">
			SELECT * FROM customtagMappings WHERE strphysical =
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.physicalPath#" />
		</cfquery>
		<cfif isAlreadyMapped.recordcount>
			<cfthrow type="#variables.extensionTag#.mappingStillThereBro" detail="something is fscked up, mapping still exists!" />
		</cfif>
	</cffunction>

	<cffunction name="getLibraryPath" access="public" returntype="string">
		<cfswitch expression="#request.adminType#">
			<cfcase value="web">
				<cfreturn expandPath('{railo-web}/library') />
			</cfcase>
			<cfcase value="server">
				<cfreturn expandPath('{railo-server}/library') />
			</cfcase>
		</cfswitch>
	</cffunction>

	<cffunction name="getPluginDir" access="private" output="false">
		<cfset var pluginDir = "" />
		<cfadmin action="getPluginDirectory" type="#request.adminType#" password="#session["password"&request.adminType]#" returnVariable="pluginDir">
		<cfif NOT directoryExists(pluginDir)>
			<cfdirectory action="create" directory="#pluginDir#" recurse="true" />
		</cfif>
		<cfreturn pluginDir />
	</cffunction>

	<cffunction name="addTestPlugin" access="private" output="false">
		<cfargument name="testfile" required="true" />
		<cfargument name="isBuiltInTag" required="true" type="boolean" />
		<cfset var testfilename = listLast(testfile,'/\') />
		<cfset var lang = "" />
		<cfset var action = "" />
		<cfset var test = "" />
		<cfoutput>
			<cfsavecontent variable="lang">
				<?xml version="1.0" encoding="UTF-8"?>
				<languages>
					<language key="de">
						<title>
							#variables.extensionTag# test
						</title>
						<description>
							Dis et un test den #variables.extensionTag#
						</description>
					</language>
					<language key="en">
						<title>
							#variables.extensionTag# test
						</title>
						<description>
							Test for #variables.extensionTag#
						</description>
					</language>
				</languages>
			</cfsavecontent>
			<cfsavecontent variable="action">
				<%cfcomponent extends="railo-context.admin.plugin.Plugin"> <%cffunction name="init" hint="this function will be called to initalize"> <%cfargument name="lang" type="struct"> <%cfargument name="app" type="struct"> <%/cffunction> <%cffunction name="overview" output="yes"> <%cfargument name="lang" type="struct"> <%cfargument name="app" type="struct"> <%cfargument name="req" type="struct"> <%cfoutput><%cfinclude template="#testfilename#"/><%/cfoutput> <%/cffunction> <%/cfcomponent>
			</cfsavecontent>
		</cfoutput>
		<cfset pluginDir = getPluginDir() & "/" & variables.extensionTag />
		<cfif NOT directoryExists(pluginDir)>
			<cfdirectory action="create" directory="#pluginDir#" recurse="true" />
		</cfif>
		<cffile action="write" file="#pluginDir#/language.xml" output="#lang#" />
		<cffile action="write" file="#pluginDir#/Action.cfc" output="#replace(action,'<%','<','all')#" />
		<cffile action="read" file="#testfile#" variable="test" />
		<cfif isBuiltInTag>
			<cfset test = replace(test,"cf_#rereplace(variables.extensionTag,'^cf','')#","cf#rereplace(variables.extensionTag,'^cf','')#","all") />
		</cfif>
		<cffile action="write" file="#pluginDir#/#testfilename#" output="#test#" />
		<cfadmin action="reload" type="#request.adminType#" password="#session["password"&request.adminType]#"/>
	</cffunction>

	<cffunction name="addTestPluginFile" access="private" output="false">
		<cfargument name="testfile" required="true" />
		<cfset var testfilename = listLast(testfile,'/\') />
		<cfset pluginDir = getPluginDir() & "/" & variables.extensionTag />
		<cfif NOT directoryExists(pluginDir)>
			<cfdirectory action="create" directory="#pluginDir#" recurse="true" />
		</cfif>
		<cffile action="copy" destination="#pluginDir#/#testfilename#" source="#testfile#" />
	</cffunction>

</cfcomponent>
