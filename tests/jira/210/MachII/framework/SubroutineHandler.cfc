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
$Id: SubroutineHandler.cfc 651 2008-02-24 21:01:22Z peterfarrell $

Created version: 1.5.0
Updated version: 1.5.0

Notes:
--->
<cfcomponent 
	displayname="SubroutineHandler"
	output="false"
	hint="Handles processing of Commands for a Subroutine.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.commands = ArrayNew(1) />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="SubroutineHandler" output="false"
		hint="Used by the framework for initialization. Do not override.">
		<cfreturn this />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="handleSubroutine" access="public" returntype="boolean" output="true"
		hint="Handles a Subroutine.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		
		<cfset var continue = true />
		<cfset var command = "" />
		<cfset var i = 0 />
		
		<cfloop from="1" to="#ArrayLen(variables.commands)#" index="i">
			<cfset command = variables.commands[i] />
			<cfset continue = command.execute(arguments.event, arguments.eventContext) />
			<cfif continue IS false>
				<cfbreak />
			</cfif>
		</cfloop>
		
		<cfreturn continue />
	</cffunction>
	
	<cffunction name="addCommand" access="public" returntype="void" output="false"
		hint="Adds a Command.">
		<cfargument name="command" type="MachII.framework.Command" required="true" />
		<cfset ArrayAppend(variables.commands, arguments.command) />
	</cffunction>
	
</cfcomponent>