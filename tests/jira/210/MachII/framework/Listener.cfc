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
$Id: Listener.cfc 625 2008-01-29 21:45:06Z peterfarrell $

Created version: 1.0.0
Updated version: 1.5.0

Notes:
All user-defined listeners extend this base listener component.
--->
<cfcomponent
	displayname="Listener"
	extends="MachII.framework.BaseComponent"
	output="false"
	hint="Base Listener component.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.invoker = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Listener" output="false"
		hint="Used by the framework for initialization. Do not override.">
		<cfargument name="appManager" type="MachII.framework.AppManager" required="true" />
		<cfargument name="parameters" type="struct" required="false" default="#StructNew()#" />
		<cfargument name="invoker" type="MachII.framework.ListenerInvoker" required="false" />
		
		<cfset super.init(arguments.appManager, arguments.parameters) />
		
		<cfif StructKeyExists(arguments, "invoker")>
			<cfset setInvoker(arguments.invoker) />
		</cfif>
		
		<cfreturn this />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setInvoker" access="public" returntype="void" output="false"
		hint="Sets the ListenerInvoker to use when invoking methods for this Listener.">
		<cfargument name="invoker" type="MachII.framework.ListenerInvoker" required="true" />
		<cfset variables.invoker = arguments.invoker />
	</cffunction>
	<cffunction name="getInvoker" access="public" type="MachII.framework.ListenerInvoker" output="false"
		hint="Gets the ListenerInvoker to use when invoking methods for this Listener.">
		<cfreturn variables.invoker />
	</cffunction>

</cfcomponent>