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
$Id: Log.cfc 920 2008-07-28 16:26:57Z peterfarrell $

Created version: 1.6.0
Updated version: 1.6.0

Notes:
Mach-II Logging is heavily based on Apache Commons Logging interface.
--->
<cfcomponent
	displayname="Log"
	output="false"
	hint="A simple logging API.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.channel = "" />
	<cfset variables.logAdapters = StructNew() />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Log" output="false"
		hint="Initializes the logging facade.">
		<cfargument name="channel" type="string" required="true" />
		<cfargument name="logAdapters" type="struct" required="true" />

		<cfset setChannel(arguments.channel) />
		<cfset setLogAdapters(arguments.logAdapters) />
		
		<cfreturn this />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="debug" access="public" returntype="void" output="false"
		hint="Logs a message with debug log level.">
		<cfargument name="message" type="string" required="true" />
		<cfargument name="additionalInformation" type="any" required="false" />

		<cfset var key = "" />
		
		<cfloop collection="#variables.logAdapters#" item="key">
			<cfif StructKeyExists(arguments, "additionalInformation")>
				<cfset variables.logAdapters[key].debug(getChannel(), arguments.message, arguments.additionalInformation) />
			<cfelse>
				<cfset variables.logAdapters[key].debug(getChannel(), arguments.message) />
			</cfif>
		</cfloop>
	</cffunction>
	
	<cffunction name="error" access="public" returntype="void" output="false"
		hint="Logs a message with error log level.">
		<cfargument name="message" type="string" required="true" />
		<cfargument name="additionalInformation" type="any" required="false" />

		<cfset var key = "" />
		
		<cfloop collection="#variables.logAdapters#" item="key">
			<cfif StructKeyExists(arguments, "additionalInformation")>
				<cfset variables.logAdapters[key].error(getChannel(), arguments.message, arguments.additionalInformation) />
			<cfelse>
				<cfset variables.logAdapters[key].error(getChannel(), arguments.message) />
			</cfif>
		</cfloop>
	</cffunction>
	
	<cffunction name="fatal" access="public" returntype="void" output="false"
		hint="Logs a message with fatal log level.">
		<cfargument name="message" type="string" required="true" />
		<cfargument name="additionalInformation" type="any" required="false" />

		<cfset var key = "" />
		
		<cfloop collection="#variables.logAdapters#" item="key">
			<cfif StructKeyExists(arguments, "additionalInformation")>
				<cfset variables.logAdapters[key].fatal(getChannel(), arguments.message, arguments.additionalInformation) />
			<cfelse>
				<cfset variables.logAdapters[key].fatal(getChannel(), arguments.message) />
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="info" access="public" returntype="void" output="false"
		hint="Logs a message with info log level.">
		<cfargument name="message" type="string" required="true" />
		<cfargument name="additionalInformation" type="any" required="false" />

		<cfset var key = "" />
		
		<cfloop collection="#variables.logAdapters#" item="key">
			<cfif StructKeyExists(arguments, "additionalInformation")>
				<cfset variables.logAdapters[key].info(getChannel(), arguments.message, arguments.additionalInformation) />
			<cfelse>
				<cfset variables.logAdapters[key].info(getChannel(), arguments.message) />
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="trace" access="public" returntype="void" output="false"
		hint="Logs a message with trace log level.">
		<cfargument name="message" type="string" required="true" />
		<cfargument name="additionalInformation" type="any" required="false" />

		<cfset var key = "" />
		
		<cfloop collection="#variables.logAdapters#" item="key">
			<cfif StructKeyExists(arguments, "additionalInformation")>
				<cfset variables.logAdapters[key].trace(getChannel(), arguments.message, arguments.additionalInformation) />
			<cfelse>
				<cfset variables.logAdapters[key].trace(getChannel(), arguments.message) />
			</cfif>
		</cfloop>
	</cffunction>
	
	<cffunction name="warn" access="public" returntype="void" output="false"
		hint="Logs a message with warn log level.">
		<cfargument name="message" type="string" required="true" />
		<cfargument name="additionalInformation" type="any" required="false" />

		<cfset var key = "" />
		
		<cfloop collection="#variables.logAdapters#" item="key">
			<cfif StructKeyExists(arguments, "additionalInformation")>
				<cfset variables.logAdapters[key].warn(getChannel(), arguments.message, arguments.additionalInformation) />
			<cfelse>
				<cfset variables.logAdapters[key].warn(getChannel(), arguments.message) />
			</cfif>
		</cfloop>
	</cffunction>
	
	<cffunction name="isDebugEnabled" access="public" returntype="boolean" output="false"
		hint="Checks if debug level logging is enabled.">

		<cfset var key = "" />
		
		<cfloop collection="#variables.logAdapters#" item="key">
			<cfif variables.logAdapters[key].isDebugEnabled()>
				<cfreturn true />
			</cfif>
		</cfloop>
		
		<cfreturn false />
	</cffunction>
	
	<cffunction name="isErrorEnabled" access="public" returntype="boolean" output="false"
		hint="Checks if error level logging is enabled.">

		<cfset var key = "" />
		
		<cfloop collection="#variables.logAdapters#" item="key">
			<cfif variables.logAdapters[key].isErrorEnabled()>
				<cfreturn true />
			</cfif>
		</cfloop>
		
		<cfreturn false />
	</cffunction>
	
	<cffunction name="isFatalEnabled" access="public" returntype="boolean" output="false"
		hint="Checks if fatal level logging is enabled.">

		<cfset var key = "" />
		
		<cfloop collection="#variables.logAdapters#" item="key">
			<cfif variables.logAdapters[key].isFatalEnabled()>
				<cfreturn true />
			</cfif>
		</cfloop>
		
		<cfreturn false />
	</cffunction>
	
	<cffunction name="isInfoEnabled" access="public" returntype="boolean" output="false"
		hint="Checks if info level logging is enabled.">

		<cfset var key = "" />
		
		<cfloop collection="#variables.logAdapters#" item="key">
			<cfif variables.logAdapters[key].isInfoEnabled()>
				<cfreturn true />
			</cfif>
		</cfloop>
		
		<cfreturn false />
	</cffunction>
	
	<cffunction name="isTraceEnabled" access="public" returntype="boolean" output="false"
		hint="Checks if trace level logging is enabled.">

		<cfset var key = "" />
		
		<cfloop collection="#variables.logAdapters#" item="key">
			<cfif variables.logAdapters[key].isTraceEnabled()>
				<cfreturn true />
			</cfif>
		</cfloop>
		
		<cfreturn false />
	</cffunction>
	
	<cffunction name="isWarnEnabled" access="public" returntype="boolean" output="false"
		hint="Checks if warn level logging is enabled.">

		<cfset var key = "" />
		
		<cfloop collection="#variables.logAdapters#" item="key">
			<cfif variables.logAdapters[key].isWarnEnabled()>
				<cfreturn true />
			</cfif>
		</cfloop>
		
		<cfreturn false />
	</cffunction>

	<!--
	ACCESSORS
	--->
	<cffunction name="setChannel" access="private" returntype="void" output="false"
		hint="Sets the channel.">
		<cfargument name="channel" type="string" required="true" />
		<cfset variables.channel = arguments.channel />
	</cffunction>
	<cffunction name="getChannel" access="public" returntype="string" output="false"
		hint="Returns the channel.">
		<cfreturn variables.channel />
	</cffunction>
	
	<cffunction name="setLogAdapters" access="private" returntype="void" output="false"
		hint="Sets the log adapters.">
		<cfargument name="logAdapters" type="struct" required="true" />
		<cfset variables.logAdapters = arguments.logAdapters />
	</cffunction>
	<cffunction name="getLogAdapters" access="public" returntype="struct" output="false"
		hint="Returns the log adapters.">
		<cfreturn variables.logAdapters />
	</cffunction>

</cfcomponent>