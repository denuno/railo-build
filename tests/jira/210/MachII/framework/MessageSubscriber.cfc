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
$Id: MessageSubscriber.cfc 947 2008-08-10 22:43:06Z peterfarrell $

Created version: 1.6.0
Updated version: 1.6.0

Notes:
--->
<cfcomponent
	displayname="MessageSubscriberInvoker"
	output="false"
	hint="Handles processing of a subscriber to a message.">

	<!---
	PROPERTIES
	--->
	<cfset variables.listener = "" />
	<cfset variables.listenerName = "" />
	<cfset variables.method = "" />
	<cfset variables.resultArg = "" />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="MessageSubscriber" output="false"
		hint="Initializes the subscriber.">
		<cfargument name="listenerName" type="string" required="true" />
		<cfargument name="listener" type="MachII.framework.Listener" required="true" />
		<cfargument name="method" type="string" required="true" />
		<cfargument name="resultArg" type="string" required="true" />

		<cfset setListenerName(arguments.listenerName) />
		<cfset setListener(arguments.listener) />
		<cfset setMethod(arguments.method) />
		<cfset setResultArg(arguments.resultArg) />

		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="invokeListener" access="public" returntype="void" output="false"
		hint="Invokes a listener method.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfset var listener = getListener() />
		<cfset var invoker = listener.getInvoker() />
		
		<cfset invoker.invokeListener(arguments.event, listener, getMethod(), "", getResultArg()) />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setListenerName" access="public" returntype="void" output="false">
		<cfargument name="listenerName" type="string" required="true" />
		<cfset variables.listenerName = arguments.listenerName />
	</cffunction>
	<cffunction name="getListenerName" access="public" returntype="string" output="false">
		<cfreturn variables.listenerName />
	</cffunction>

	<cffunction name="setListener" access="public" returntype="void" output="false">
		<cfargument name="listener" type="MachII.framework.Listener" required="true" />
		<cfset variables.listener = arguments.listener />
	</cffunction>
	<cffunction name="getListener" access="public" returntype="MachII.framework.Listener" output="false">
		<cfreturn variables.listener />
	</cffunction>

	<cffunction name="setMethod" access="public" returntype="void" output="false">
		<cfargument name="method" type="string" required="true" />
		<cfset variables.method = arguments.method />
	</cffunction>
	<cffunction name="getMethod" access="public" returntype="string" output="false">
		<cfreturn variables.method />
	</cffunction>

	<cffunction name="setResultArg" access="public" returntype="void" output="false">
		<cfargument name="resultArg" type="string" required="true" />
		<cfset variables.resultArg = arguments.resultArg />
	</cffunction>
	<cffunction name="getResultArg" access="public" returntype="string" output="false">
		<cfreturn variables.resultArg />
	</cffunction>

</cfcomponent>