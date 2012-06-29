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
$Id: EventBeanCommand.cfc 774 2008-05-11 04:00:35Z peterfarrell $

Created version: 1.0.6
Updated version: 1.5.0

Notes:
--->
<cfcomponent 
	displayname="EventBeanCommand" 
	extends="MachII.framework.Command"
	output="false"
	hint="An Command for creating and populating a bean in the current event.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.beanName = "" />
	<cfset variables.beanType = "" />
	<cfset variables.beanFields = "" />
	<cfset variables.reinit = "" />
	<cfset variables.beanUtil = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="EventBeanCommand" output="false"
		hint="Used by the framework for initialization.">
		<cfargument name="beanName" type="string" required="true" />
		<cfargument name="beanType" type="string" required="true" />
		<cfargument name="beanFields" type="string" required="true" />
		<cfargument name="reinit" type="boolean" required="true" />
		<cfargument name="beanUtil" type="MachII.util.BeanUtil" required="true" />
		
		<cfset setBeanName(arguments.beanName) />
		<cfset setBeanType(arguments.beanType) />
		<cfset setBeanFields(arguments.beanFields) />
		<cfset setReinit(arguments.reinit) />
		<cfset setBeanUtil(arguments.beanUtil) />
		
		<cfreturn this />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="execute" access="public" returntype="boolean" output="false"
		hint="Executes the command.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		
		<cfset var bean = "" />
		<cfset var log = getLog() />
		
		<!--- If reinit is FALSE, get the bean from the event --->
		<cfif NOT getReinit() AND arguments.event.isArgDefined(getBeanName())>
			<cfif log.isDebugEnabled()>
				<cfset log.debug("Event-bean '#getBeanName()#' already in event. Repopulated with data.") />
			</cfif>
			
			<cfset bean = arguments.event.getArg(getBeanName()) />
			
			<cfif isBeanFieldsDefined()>
				<cfset getBeanUtil().setBeanFields(bean, getBeanFields(), arguments.event.getArgs()) />
			<cfelse>
				<cfset getBeanUtil().setBeanAutoFields(bean, arguments.event.getArgs()) />
			</cfif>
		<cfelse>
			<cfif log.isDebugEnabled()>
				<cfset log.debug("Event-bean '#getBeanName()#' created and populated with data.") />
			</cfif>

			<cfif isBeanFieldsDefined()>
				<cfset bean = getBeanUtil().createBean(getBeanType()) />
				<cfset getBeanUtil().setBeanFields(bean, getBeanFields(), arguments.event.getArgs()) />
			<cfelse>
				<cfset bean = getBeanUtil().createBean(getBeanType(), arguments.event.getArgs()) />
			</cfif>			

			<cfset arguments.event.setArg(getBeanName(), bean, getBeanType()) />
		</cfif>
		
		<cfreturn true />
	</cffunction>
	
	<!---
	ACCESSORS
	--->
	<cffunction name="setBeanName" access="private" returntype="void" output="false">
		<cfargument name="beanName" type="string" required="true" />
		<cfset variables.beanName = arguments.beanName />
	</cffunction>
	<cffunction name="getBeanName" access="private" returntype="string" output="false">
		<cfreturn variables.beanName />
	</cffunction>
	
	<cffunction name="setBeanType" access="private" returntype="void" output="false">
		<cfargument name="beanType" type="string" required="true" />
		<cfset variables.beanType = arguments.beanType />
	</cffunction>
	<cffunction name="getBeanType" access="private" returntype="string" output="false">
		<cfreturn variables.beanType />
	</cffunction>
	
	<cffunction name="setBeanFields" access="private" returntype="void" output="false">
		<cfargument name="beanFields" type="string" required="true" />
		<cfset variables.beanFields = arguments.beanFields />
	</cffunction>
	<cffunction name="getBeanFields" access="private" returntype="string" output="false">
		<cfreturn variables.beanFields />
	</cffunction>
	<cffunction name="isBeanFieldsDefined" access="public" returntype="boolean" output="false">
		<cfreturn Len(variables.beanFields) />
	</cffunction>
	
	<cffunction name="setReinit" access="private" returntype="void" output="false">
		<cfargument name="reinit" type="boolean" required="true" />
		<cfset variables.reinit = arguments.reinit />
	</cffunction>
	<cffunction name="getReinit" access="private" returntype="boolean" output="false">
		<cfreturn variables.reinit />
	</cffunction>
	
	<cffunction name="setBeanUtil" access="private" returntype="void" output="false">
		<cfargument name="beanUtil" type="MachII.util.BeanUtil" required="true" />
		<cfset variables.beanUtil = arguments.beanUtil />
	</cffunction>
	<cffunction name="getBeanUtil" access="private" returntype="MachII.util.BeanUtil" output="false">
		<cfreturn variables.beanUtil />
	</cffunction>

</cfcomponent>