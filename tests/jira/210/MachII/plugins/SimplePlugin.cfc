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
$Id: SimplePlugin.cfc 903 2008-07-26 19:28:37Z peterfarrell $

Created version: 1.0.0
Updated version: 1.6.0

Notes:
The PluginManager only calls plugin points that are utilized.
Remove any un-implemented plugin point methods (i.e. preProcess(), etc.)
to improve application performance as fewer plugin points will
be called on each request.  For example if your plugin only implements the
preEvent plugin point, then remove the remaining points. (pfarrell)
--->
<cfcomponent 
	displayname="SimplePlugin" 
	extends="MachII.framework.Plugin" 
	output="false"
	hint="A simple Plugin example.">

	<!---
	PROPERTIES
	--->
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the plugin.">
		<!--- Put configuration logic here --->
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="preProcess" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.preProcess()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="preEvent" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.preEvent()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="postEvent" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.postEvent()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="preView" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.preView()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="postView" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.postView()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="postProcess" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.postProcess()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="onSessionStart" access="public" returntype="void" output="true">
		<!--- There is no access to the eventContext since sessions start asynchronously 
			from the Mach-II request life cycle--->
	</cffunction>
	
	<cffunction name="onSessionEnd" access="public" returntype="void" output="true">
		<cfargument name="sessionScope" type="struct" required="true"
			hint="The session scope is passed in since direct access to it is not available." />
		<!--- There is no access to the eventContext since sessions end asynchronously
			from the Mach-II request life cycle--->
	</cffunction>
	
	<cffunction name="handleException" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="exception" type="MachII.util.Exception" required="true" />
		<cfoutput>&nbsp;SimplePlugin.handleException()<br /></cfoutput>
	</cffunction>

	<!---
	PROTECTED FUNCTIONS
	--->

	<!---
	ACCESSORS
	--->

</cfcomponent>