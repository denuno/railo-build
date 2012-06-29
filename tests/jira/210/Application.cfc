<cfcomponent extends="MachII.mach-ii" output="false">

	<!---
	PROPERTIES - APPLICATION SPECIFIC
	--->
	<cfset this.name = "DashboardTest" />
	<cfset this.loginStorage = "session" />
	<cfset this.sessionManagement = true />
	<cfset this.setClientCookies = false />
	<cfset this.setDomainCookies = false />
	<cfset this.sessionTimeOut = CreateTimeSpan(0,12,0,0) />
	<cfset this.applicationTimeOut = CreateTimeSpan(1,0,0,0) />
	<cfset this.showDebugOutput = false>

	<cfset this.mappings[ "/MachII" ] = expandPath('./MachII')>

	<!---
	PROPERTIES - MACH-II SPECIFIC
	--->
	<!---Set the path to the application's mach-ii.xml file --->
	<cfset MACHII_CONFIG_PATH = ExpandPath("./config/MachII.xml") />
	<!--- Set the app key for sub-applications within a single cf-application. --->
	<cfset MACHII_APP_KEY =  GetFileFromPath(ExpandPath(".")) />
	<!--- Set the configuration mode (when to reinit): -1=never, 0=dynamic, 1=always --->
	<cfset MACHII_CONFIG_MODE = -1 />
	<!--- Whether or not to validate the configuration XML before parsing. Default to false. --->
	<cfset MACHII_VALIDATE_XML = FALSE />
	<!--- Set the path to the Mach-II's DTD file. --->
	<cfset MACHII_DTD_PATH = ExpandPath("./MachII/mach-ii_1_6_0.dtd") />

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="onApplicationStart" returnType="void" output="false" hint="Only runs when the App is started.">
		<cfsetting requesttimeout="120" />
		<cfset application.startTime = Now() />
		<cfset LoadFramework() />
	</cffunction>

	<cffunction name="onApplicationEnd" returntype="void" output="false" hint="Only runs when the App is shut down.">
		<cfargument name="ApplicationScope" required="true"/>
	</cffunction>

	<cffunction name="onSessionStart" returntype="void" output="false" hint="Only runs when a session is created.">
		<!---
		Example onSessionStart in a Session Facade
		<cfset getProperty("sessionFacade").onSessionStart() />
		--->
	</cffunction>

	<cffunction name="onSessionEnd" returntype="void" output="false" hint="Only run when a session ends.">
		<cfargument name="SessionScope" required="true"/>
		<!---
		Example onSessionEnd
		<cfset getProperty("sessionFacade").onSessionEnd(arguments.SessionScope) />
		--->
	</cffunction>

	<cffunction name="onRequestStart" returnType="void" output="true" hint="Run at the start of a page request.">
		<cfargument name="targetPage" type="string" required="true" />

		<!--- Request Scope Variable Defaults --->
		<cfset request.self = "index.cfm">

		<!--- Set per session cookies if not using J2EE session management --->
		<cfif StructKeyExists(session, "cfid") AND (NOT StructKeyExists(cookie, "cfid") OR NOT StructKeyExists(cookie, "cftoken"))>
			<cfcookie name="cfid" value="#session.cfid#" />
			<cfcookie name="cftoken" value="#session.cftoken#" />
		</cfif>

		<!--- Temporarily override the default config mode
			Set the configuration mode (when to reinit): -1=never, 0=dynamic, 1=always --->
		<cfif StructKeyExists(url, "init")>
			<cfsetting requesttimeout="120" />
			<cfset MACHII_CONFIG_MODE = 1 />
		</cfif>

		<!--- Handle the request. Make sure we only process Mach-II requests. --->
		<cfif findNoCase('index.cfm', listLast(arguments.targetPage, '/'))>
			<cfset handleRequest() />
		</cfif>
	</cffunction>

</cfcomponent>