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
$Id: Command.cfc 1098 2008-10-19 02:57:06Z kurtwiersma $

Created version: 1.0.0
Updated version: 1.6.0

Notes:
--->
<cfcomponent 
	displayname="Command"
	output="false"
	hint="Base Command component.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.parameters = StructNew() />
	<cfset variables.log = "" />
	<cfset variables.expressionEvaluator = "" />
	<cfset variables.propertyManager = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Command" output="false"
		hint="Used by the framework for initialization.">
		<cfreturn this />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="execute" access="public" returntype="boolean" output="true"
		hint="Overridden by the command that extends this component.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		
		<cfset var log = getLog() />
		
		<cfif log.isInfoEnabled()>
			<cfset log.info("Executing a default command named '#getParameter("commandName")#'. This is not a concrete command. Check your configuration file.") />
		</cfif>
		
		<cfreturn true />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS - UTIL
	--->
	<cffunction name="setParameters" access="public" returntype="void" output="false"
		hint="Sets a struct of parameters to this command.">
		<cfargument name="parameters" type="struct" required="true" />

		<cfset var key = "" />

		<cfloop collection="#arguments.parameters#" item="key">
			<cfset setParameter(key, parameters[key]) />
		</cfloop>
	</cffunction>
	
	<!---
	ACCESSORS
	--->
	<cffunction name="setParameter" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="value" type="any" required="true" />
		<cfset variables.parameters[arguments.name] = arguments.value />
	</cffunction>
	<cffunction name="getParameter" access="public" returntype="any" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfreturn variables.parameters[arguments.name] />
	</cffunction>
	
	<cffunction name="setLog" access="public" returntype="void" output="false"
		hint="Uses the log factory to create a log.">
		<cfargument name="logFactory" type="MachII.logging.LogFactory" required="true" />
		<cfset variables.log = arguments.logFactory.getLog(getMetadata(this).name) />
	</cffunction>
	<cffunction name="getLog" access="public" returntype="MachII.logging.Log" output="false"
		hint="Gets the log.">
		<cfreturn variables.log />
	</cffunction>
	
	<cffunction name="setExpressionEvaluator" access="public" returntype="void" output="false">
		<cfargument name="expressionEvaluator" type="MachII.util.ExpressionEvaluator" required="true" />
		<cfset variables.expressionEvaluator = arguments.expressionEvaluator />
	</cffunction>
	<cffunction name="getExpressionEvaluator" access="public" returntype="MachII.util.ExpressionEvaluator" output="false">
		<cfreturn variables.expressionEvaluator />
	</cffunction>

	<cffunction name="setPropertyManager" access="public" returntype="void" output="false">
		<cfargument name="propertyManager" type="MachII.framework.PropertyManager" required="true" />
		<cfset variables.propertyManager = arguments.propertyManager />
	</cffunction>	
	<cffunction name="getPropertyManager" access="public" returntype="MachII.framework.PropertyManager" output="false">
		<cfreturn variables.propertyManager />
	</cffunction>

</cfcomponent>