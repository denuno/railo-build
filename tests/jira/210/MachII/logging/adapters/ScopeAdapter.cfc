<!---
License:
Copyright 2008 GreatBizTools, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Copyright: GreatBizTools, LLC
Author: Peter J. Farrell (peter@mach-ii.com)
$Id: ScopeAdapter.cfc 1235 2009-01-09 10:09:35Z peterfarrell $

Created version: 1.6.0
Updated version: 1.6.0

Notes:
Special thanks to the Simple Log in Apache Commons Logging project for inspiration for this component.

Uses the GenericChannelFitler for filtering. See that CFC for information on how to use to setup filters.

Configuration Example:
<property name="logging" type="MachII.properties.LoggingProperty">
	<parameters>
		<parameter name="MachIILog">
			<struct>
				<key name="type" value="MachII.logging.adapters.MachIILogAdapter" />
				<!-- Optional and defaults to true />
				<key name="loggingEnabled" value="true|false" />
				<!-- Optional and defaults to 'info' -->
				<key name="loggingLevel" value="all|trace|debug|info|warn|error|fatal|off" />
				<!-- Optional and defaults to false -->
				<key name="debugModeOnly" value="true|false" />
				<!-- Optional -->
				<key name="filter" value="list,of,filter,criteria" />
				- OR -
				<key name="filter">
					<array>
						<element value="array" />
						<element value="of" />
						<element value="filter" />
						<element value="criteria" />
					</array>
				</key>
			</struct>
		</parameter>
	</parameters>
</property>
--->
<cfcomponent
	displayname="ScopeAdapter"
	extends="MachII.logging.adapters.AbstractLogAdapter"
	output="false"
	hint="A concrete adapter for scope logging. Logs messages to a scope.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.LOG_LEVEL_TRACE = 1 />
	<cfset variables.LOG_LEVEL_DEBUG = 2 />
	<cfset variables.LOG_LEVEL_INFO = 3 />
	<cfset variables.LOG_LEVEL_WARN = 4 />
	<cfset variables.LOG_LEVEL_ERROR = 5 />
	<cfset variables.LOG_LEVEL_FATAL = 6 />
	<cfset variables.LOG_LEVEL_ALL = 0 />
	<cfset variables.LOG_LEVEL_OFF = 7 />
	
	<cfset variables.level = variables.LOG_LEVEL_DEBUG />
	<cfset variables.debugModeOnly = false />
	
	<cfset variables.instance.loggingScope = "request" />
	<cfset variables.instance.loggingPath = "_ScopeLogging" & "_" & Hash(getTickCount() & RandRange(0, 100000) & RandRange(0, 100000)) />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the adapter.">
		
		<cfif isParameterDefined("loggingScope")>
			<cfset setLoggingScope(getParameter("loggingScope")) />
		</cfif>
		<cfif isParameterDefined("loggingPath")>
			<cfset setLoggingPath(getParameter("loggingPath")) />
		</cfif>
		<cfif isParameterDefined("loggingLevel")>
			<cfset setLoggingLevel(getParameter("loggingLevel")) />
		</cfif>
		<cfif isParameterDefined("loggingEnabled")>
			<cfset setLoggingEnabled(getParameter("loggingEnabled")) />
		</cfif>
		<cfif isParameterDefined("debugModeOnly")>
			<cfset setDebugModeOnly(getParameter("debugModeOnly")) />
		</cfif>
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="debug" access="public" returntype="void" output="false"
		hint="Logs a message with debug log level.">
		<cfargument name="channel" type="string" required="true" />
		<cfargument name="message" type="string" required="true" />
		<cfargument name="additionalInformation" type="any" required="false" />
		
		<cfif isDebugEnabled()>
			<cfif StructKeyExists(arguments, "additionalInformation")>
				<cfset logMessage(arguments.channel, variables.LOG_LEVEL_DEBUG, arguments.message, arguments.additionalInformation) />
			<cfelse>
				<cfset logMessage(arguments.channel, variables.LOG_LEVEL_DEBUG, arguments.message) />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="error" access="public" returntype="void" output="false"
		hint="Logs a message with error log level.">
		<cfargument name="channel" type="string" required="true" />
		<cfargument name="message" type="string" required="true" />
		<cfargument name="additionalInformation" type="any" required="false" />
		
		<cfif isErrorEnabled()>
			<cfif StructKeyExists(arguments, "additionalInformation")>
				<cfset logMessage(arguments.channel, variables.LOG_LEVEL_ERROR, arguments.message, arguments.additionalInformation) />
			<cfelse>
				<cfset logMessage(arguments.channel, variables.LOG_LEVEL_ERROR, arguments.message) />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="fatal" access="public" returntype="void" output="false"
		hint="Logs a message with fatal log level.">
		<cfargument name="channel" type="string" required="true" />
		<cfargument name="message" type="string" required="true" />
		<cfargument name="additionalInformation" type="any" required="false" />
		
		<cfif isFatalEnabled()>
			<cfif StructKeyExists(arguments, "additionalInformation")>
				<cfset logMessage(arguments.channel, variables.LOG_LEVEL_FATAL, arguments.message, arguments.additionalInformation) />
			<cfelse>
				<cfset logMessage(arguments.channel, variables.LOG_LEVEL_FATAL, arguments.message) />
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="info" access="public" returntype="void" output="false"
		hint="Logs a message with info log level.">
		<cfargument name="channel" type="string" required="true" />
		<cfargument name="message" type="string" required="true" />
		<cfargument name="additionalInformation" type="any" required="false" />

		<cfif isInfoEnabled()>
			<cfif StructKeyExists(arguments, "additionalInformation")>
				<cfset logMessage(arguments.channel, variables.LOG_LEVEL_INFO, arguments.message, arguments.additionalInformation) />
			<cfelse>
				<cfset logMessage(arguments.channel, variables.LOG_LEVEL_INFO, arguments.message) />
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="trace" access="public" returntype="void" output="false"
		hint="Logs a message with trace log level.">
		<cfargument name="channel" type="string" required="true" />
		<cfargument name="message" type="string" required="true" />
		<cfargument name="additionalInformation" type="any" required="false" />

		<cfif isTraceEnabled()>
			<cfif StructKeyExists(arguments, "additionalInformation")>
				<cfset logMessage(arguments.channel, variables.LOG_LEVEL_TRACE, arguments.message, arguments.additionalInformation) />
			<cfelse>
				<cfset logMessage(arguments.channel, variables.LOG_LEVEL_TRACE, arguments.message) />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="warn" access="public" returntype="void" output="false"
		hint="Logs a message with warn log level.">
		<cfargument name="channel" type="string" required="true" />
		<cfargument name="message" type="string" required="true" />
		<cfargument name="additionalInformation" type="any" required="false" />

		<cfif isWarnEnabled()>
			<cfif StructKeyExists(arguments, "additionalInformation")>
				<cfset logMessage(arguments.channel, variables.LOG_LEVEL_WARN, arguments.message, arguments.additionalInformation) />
			<cfelse>
				<cfset logMessage(arguments.channel, variables.LOG_LEVEL_WARN, arguments.message) />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="isDebugEnabled" access="public" returntype="boolean" output="false"
		hint="Checks if debug level logging is enabled.">
		<cfreturn isLevelEnabled(variables.LOG_LEVEL_DEBUG) />
	</cffunction>
	
	<cffunction name="isErrorEnabled" access="public" returntype="boolean" output="false"
		hint="Checks if error level logging is enabled.">
		<cfreturn isLevelEnabled(variables.LOG_LEVEL_ERROR) />
	</cffunction>
	
	<cffunction name="isFatalEnabled" access="public" returntype="boolean" output="false"
		hint="Checks if fatal level logging is enabled.">
		<cfreturn isLevelEnabled(variables.LOG_LEVEL_FATAL) />
	</cffunction>
	
	<cffunction name="isInfoEnabled" access="public" returntype="boolean" output="false"
		hint="Checks if info level logging is enabled.">
		<cfreturn isLevelEnabled(variables.LOG_LEVEL_INFO) />
	</cffunction>
	
	<cffunction name="isTraceEnabled" access="public" returntype="boolean" output="false"
		hint="Checks if trace level logging is enabled.">
		<cfreturn isLevelEnabled(variables.LOG_LEVEL_TRACE) />
	</cffunction>
	
	<cffunction name="isWarnEnabled" access="public" returntype="boolean" output="false"
		hint="Checks if warn level logging is enabled.">
		<cfreturn isLevelEnabled(variables.LOG_LEVEL_WARN) />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS - UTILS
	--->
	<cffunction name="isLoggingDataDefined" access="public" returntype="boolean" output="false"
		hint="Checks if logging data is defined.">

		<cfset var scope = StructGet(getLoggingScope()) />
		
		<cfreturn StructKeyExists(scope, getLoggingPath()) />
	</cffunction>
	
	<cffunction name="getLoggingData" access="public" returntype="struct" output="false"
		hint="Gets logging data. Call isLoggingDataDefined() first to check if defined.">

		<cfset var scope = StructGet(getLoggingScope()) />
		
		<cfreturn scope[getLoggingPath()] />
	</cffunction>
	
	<!---
	PROTECTED FUNCTIONS
	--->
	<cffunction name="isLevelEnabled" access="private" returntype="boolean" output="false"
		hint="Checks if the passed log level is enabled.">
		<cfargument name="logLevel" type="numeric" required="true"
			hint="Log levels are numerically ordered for easier comparison." />
		<cfif getLoggingEnabled() AND ((getDebugModeOnly() AND isDebugMode()) OR NOT getDebugModeOnly())>
			<cfreturn arguments.logLevel GTE getLevel() />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>
	
	<cffunction name="logMessage" access="private" returntype="void" output="false"
		hint="Logs a message.">
		<cfargument name="channel" type="string" required="true" />
		<cfargument name="logLevel" type="numeric" required="true" />
		<cfargument name="message" type="string" required="true" />
		<cfargument name="additionalInformation" type="any" required="false" />
		
		<cfset var entry = StructNew() />
		<cfset var scope = StructGet(getLoggingScope()) />
		
		<!--- Filter the message by channel --->
		<cfif NOT isFilterDefined() OR getFilter().decide(arguments)>		
			<!--- See if we need to create a place to put the log messages --->
			<cfif NOT IsDefined(getLoggingScope() & "." & getLoggingPath() & ".data")>
				<cfset scope[getLoggingPath()] = StructNew() />
				<cfset scope[getLoggingPath()].data = ArrayNew(1) />
			</cfif>
			
			<cfset entry.channel = arguments.channel />
			<cfset entry.logLevel = arguments.logLevel />
			<cfset entry.logLevelName = translateLevelToName(arguments.logLevel) />
			<cfset entry.message = arguments.message />
			<cfset entry.currentTick = getTickCount() />
			
			<cfif StructKeyExists(arguments, "additionalInformation")>
				<cfset entry.additionalInformation = arguments.additionalInformation />
			<cfelse>
				<cfset entry.additionalInformation = "" />
			</cfif>
			
			<cfset ArrayAppend(scope[getLoggingPath()].data, entry) />
		</cfif>
	</cffunction>
	
	<cffunction name="translateLevelToName" access="private" returntype="string" output="false"
		hint="Translate a numerical logging level to human readable string.">
		<cfargument name="level" type="numeric" required="true" />

		<cfset var loggingLevelName = "" />
		
		<cfif arguments.level EQ 1>
			<cfset loggingLevelName = "trace" />
		<cfelseif  arguments.level EQ 2>
			<cfset loggingLevelName = "debug" />
		<cfelseif  arguments.level EQ 3>
			<cfset loggingLevelName = "info" />
		<cfelseif  arguments.level EQ 4>
			<cfset loggingLevelName = "warn" />
		<cfelseif  arguments.level EQ 5>
			<cfset loggingLevelName = "error" />
		<cfelseif  arguments.level EQ 6>
			<cfset loggingLevelName = "fatal" />
		<cfelseif  arguments.level EQ 0>
			<cfset loggingLevelName = "all" />
		<cfelseif  arguments.level EQ 7>
			<cfset loggingLevelName = "off" />
		</cfif>
		
		<cfreturn loggingLevelName />
	</cffunction>
	
	<!---
	ACCESSORS
	--->
	<cffunction name="setLoggingLevel" access="public" returntype="void" output="false"
		hint="Sets the logging level by name.">
		<cfargument name="loggingLevelName" type="string" required="true"
			hint="Accepts 'trace', 'debug', 'info', 'warn', 'error', 'fatal', 'all' or 'off'." />
		
		<cfset var level = "" />
		
		<cfif NOT ListFindNoCase("trace|debug|info|warn|error|fatal|all|off",  arguments.loggingLevelName, "|")>
			<cfthrow message="The argument named 'loggingLevelName' accepts 'trace', 'debug', 'info', 'warn', 'error', 'fatal', 'all' or 'off'."
				detail="Passed value:#arguments.loggingLevelName#" />
		</cfif>
		
		<cfif arguments.loggingLevelName EQ "trace">
			<cfset level = 1 />
		<cfelseif  arguments.loggingLevelName EQ "debug">
			<cfset level = 2 />
		<cfelseif  arguments.loggingLevelName EQ "info">
			<cfset level = 3 />
		<cfelseif  arguments.loggingLevelName EQ "warn">
			<cfset level = 4 />
		<cfelseif  arguments.loggingLevelName EQ "error">
			<cfset level = 5 />
		<cfelseif  arguments.loggingLevelName EQ "fatal">
			<cfset level = 6 />
		<cfelseif  arguments.loggingLevelName EQ "all">
			<cfset level = 0 />
		<cfelseif  arguments.loggingLevelName EQ "off">
			<cfset level = 7 />
		</cfif>
		
		<!--- Set the numerical representation of this logging level name --->
		<cfset setLevel(level) />
	</cffunction>
	<cffunction name="getLoggingLevel" access="public" returntype="string" output="false"
		hint="Gets the logging level by name.">
		<cfreturn translateLevelToName(getLevel()) />
	</cffunction>
	
	<cffunction name="setLevel" access="private" returntype="void" output="false"
		hint="Sets the internal numeric log level.">
		<cfargument name="level" type="numeric" required="true"
			hint="Accepts an integer 0 through 7" />
		
		<cfif NOT REFind("^([0-7]{1})$", arguments.level)>
			<cfthrow message="The argument named 'level' accepts an integer 0 through 7."
				detail="Passed value:#arguments.level#" />
		</cfif>
		
		<cfset variables.level = arguments.level />
	</cffunction>
	<cffunction name="getLevel" access="private" returntype="numeric" output="false"
		hint="Returns the internal numeric log level.">
		<cfreturn variables.level />
	</cffunction>
	
	<cffunction name="setLoggingScope" access="private" returntype="void" output="false"
		hint="Sets the logging scope.">
		<cfargument name="loggingScope" type="string" required="true" />
		<cfset variables.instance.loggingScope = arguments.loggingScope />
	</cffunction>
	<cffunction name="getLoggingScope" access="public" returntype="string" output="false"
		hint="Gets the logging scope.">
		<cfreturn variables.instance.loggingScope />
	</cffunction>

	<cffunction name="setLoggingPath" access="private" returntype="void" output="false"
		hint="Sets the logging path.">
		<cfargument name="loggingPath" type="string" required="true" />
		<cfset variables.instance.loggingPath = arguments.loggingPath />
	</cffunction>
	<cffunction name="getLoggingPath" access="public" returntype="string" output="false"
		hint="Gets the logging path.">
		<cfreturn variables.instance.loggingPath />
	</cffunction>
	
	<cffunction name="setDebugModeOnly" access="private" returntype="void" output="false"
		hint="Sets if the adapter will log if the CFML server debug mode is enabled.">
		<cfargument name="debugModeOnly" type="boolean" required="true" />
		<cfset variables.debugModeOnly = arguments.debugModeOnly />
	</cffunction>
	<cffunction name="getDebugModeOnly" access="public" returntype="string" output="false"
		hint="Gets if the adapter will log if the CFML server debug mode is enabled.">
		<cfreturn variables.debugModeOnly />
	</cffunction>
	
</cfcomponent>