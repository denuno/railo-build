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
Author: Ben Edwards (ben@ben-edwards.com)
$Id: NotifyCommand.cfc 771 2008-05-11 03:20:54Z peterfarrell $

Created version: 1.0.0
Updated version: 1.5.0

Notes:
--->
<cfcomponent 
	displayname="NotifyCommand" 
	extends="MachII.framework.Command"
	output="false"
	hint="An Command for notifying a Listener.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.listener = "" />
	<cfset variables.method = "" />
	<cfset variables.resultKey = "" />
	<cfset variables.resultArg = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="NotifyCommand" output="false"
		hint="Used by the framework for initialization.">
		<cfargument name="listener" type="MachII.framework.Listener" required="true" />
		<cfargument name="method" type="string" required="true" />
		<cfargument name="resultKey" type="string" required="true" />
		<cfargument name="resultArg" type="string" required="true" />
		
		<cfset setListener(arguments.listener) />
		<cfset setMethod(arguments.method) />
		<cfset setResultKey(arguments.resultKey) />
		<cfset setResultArg(arguments.resultArg) />
		
		<cfreturn this />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="execute" access="public" returntype="boolean"
		hint="Executes the command.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
			
		<cfset var listener = getListener() />
		<cfset var invoker = listener.getInvoker() />
		<cfset invoker.invokeListener(arguments.event, listener, getMethod(), getResultKey(), getResultArg()) />
		
		<cfreturn true />
	</cffunction>
	
	<!---
	ACCESSORS
	--->
	<cffunction name="setListener" access="private" returntype="void" output="false">
		<cfargument name="listener" type="MachII.framework.Listener" required="true" />
		<cfset variables.listener = arguments.listener />
	</cffunction>
	<cffunction name="getListener" access="private" returntype="MachII.framework.Listener" output="false">
		<cfreturn variables.listener />
	</cffunction>
	
	<cffunction name="setMethod" access="private" returntype="void" output="false">
		<cfargument name="method" type="string" required="true" />
		<cfset variables.method = arguments.method />
	</cffunction>
	<cffunction name="getMethod" access="private" returntype="string" output="false">
		<cfreturn variables.method />
	</cffunction>
	
	<cffunction name="setResultKey" access="private" returntype="void" output="false">
		<cfargument name="resultKey" type="string" required="true" />
		<cfset variables.resultKey = arguments.resultKey />
	</cffunction>
	<cffunction name="getResultKey" access="private" returntype="string" output="false">
		<cfreturn variables.resultKey />
	</cffunction>
	<cffunction name="hasResultKey" access="private" returntype="boolean" output="false">
		<cfreturn Len(variables.resultKey) />
	</cffunction>
	
	<cffunction name="setResultArg" access="private" returntype="void" output="false">
		<cfargument name="resultArg" type="string" required="true" />
		<cfset variables.resultArg = arguments.resultArg />
	</cffunction>
	<cffunction name="getResultArg" access="private" returntype="string" output="false">
		<cfreturn variables.resultArg />
	</cffunction>
	<cffunction name="hasResultArg" access="private" returntype="boolean" output="false">
		<cfreturn Len(variables.resultArg) />
	</cffunction>

</cfcomponent>