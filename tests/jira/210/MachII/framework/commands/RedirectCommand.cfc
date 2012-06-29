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
$Id: RedirectCommand.cfc 1124 2008-10-26 22:59:28Z peterfarrell $

Created version: 1.1.0
Updated version: 1.5.0

Notes:
--->
<cfcomponent 
	displayname="RedirectCommand" 
	extends="MachII.framework.Command"
	output="false"
	hint="An Command for redirecting.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.eventName = "" />
	<cfset variables.eventParameter = "" />
	<cfset variables.redirectPersistParameter = "" />
	<cfset variables.moduleName = "" />
	<cfset variables.url = "" />
	<cfset variables.args = "" />
	<cfset variables.persist = "" />
	<cfset variables.persistArgs = "" />
	<cfset variables.persistArgsIgnore = "" />
	<cfset variables.statusType = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="RedirectCommand" output="false"
		hint="Used by the framework for initialization.">
		<cfargument name="eventName" type="string" required="true" />
		<cfargument name="eventParameter" type="string" required="true" />
		<cfargument name="redirectPersistParameter" type="string" required="true" />
		<cfargument name="moduleName" type="string" required="false" default="" />
		<cfargument name="url" type="string" required="false" default="" />
		<cfargument name="args" type="string" required="false" default="" />
		<cfargument name="persist" type="boolean" required="false" default="false" />
		<cfargument name="persistArgs" type="string" required="false" default="" />
		<cfargument name="statusType" type="string" required="false" default="temporary" />
		<cfargument name="persistArgsIgnore" type="string" required="false" default="" />
		
		<cfset setEventName(arguments.eventName) />
		<cfset setEventParameter(arguments.eventParameter) />
		<cfset setRedirectPersistParameter(arguments.redirectPersistParameter) />
		<cfset setModuleName(arguments.moduleName) />
		<cfset setUrl(arguments.url) />
		<cfset setArgs(arguments.args) />
		<cfset setPersist(arguments.persist) />
		<cfset setPersistArgs(arguments.persistArgs) />
		<cfset setStatusType(arguments.statusType) />
		<cfset setPersistArgsIgnore(arguments.persistArgsIgnore) />
		
		<!--- Add the persistId parameter to the url args if persist is required --->
		<cfif getPersist()>
			<cfset setArgs(ListAppend(getArgs(), getRedirectPersistParameter())) />
		</cfif>
		
		<cfreturn this />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="execute" access="public" returntype="boolean" output="false"
		hint="Executes the command.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />

		<cfset var redirectUrl = "" />
		<cfset var statusType = getStatusType() />
		<cfset var log = getLog() />

		<!--- Persist if directed --->
		<cfif getPersist()>
			<cfset savePersistEventData(arguments.event, arguments.eventContext) />
		</cfif>
		
		<!--- Make the url --->
		<cfset redirectUrl = makeRedirectUrl(arguments.event, arguments.eventContext) />
		
		<!--- Clear the event queue since we do not want to Application.cfc/cfm error
			handling to catch a cfabort --->
		<cfset arguments.eventContext.clearEventQueue() />

		<cfif log.isInfoEnabled()>
			<cfset log.info("Redirecting to url '#redirectUrl#' with '#statusType#' status code (persist='#getPersist()#').") />
		</cfif>

		<!--- Redirect based on the HTTP status type --->
		<cfif statusType EQ "permanent">
			<cfheader statuscode="301" statustext="Moved Permanently" />
			<cfheader name="Location" value="#redirectUrl#" />
			<!--- cflocation automatically calls abort so we have to do it manually --->
			<cfabort />
		<cfelseif statusType EQ "prg">
			<cfheader statuscode="303" statustext="See Other" />
			<cfheader name="Location" value="#redirectUrl#" />
			<!--- cflocation automatically calls abort so we have to do it manually --->
			<cfabort />
		<cfelse>
			<!--- Default condition for 302 (temporary) --->
			<cflocation url="#redirectUrl#" addtoken="no" />
		</cfif>
		
		<!--- Return false to stop the processeing of any remaning commands.
			Since we have cleared the event queue, the request will stop 
			gracefully. Otherwise, the onError()/cferror handlers we be called
			thus causing potential problems. --->
		<cfreturn false />
	</cffunction>
	
	<!---
	PROTECTED FUNCTIONS
	--->
	<cffunction name="makeRedirectUrl" access="private" returntype="string" output="false"
		hint="Assembles the redirect url.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		
		<cfset var redirectUrl = "" />
		<cfset var params = StructNew() />
		<cfset var args = getArgs() />
		<cfset var i = "" />
		
		<!--- Build params --->
		<cfloop list="#args#" index="i" delimiters=",">
			<cfif arguments.event.isArgDefined(i) AND IsSimpleValue(arguments.event.getArg(i))>
				<cfset params[i] = arguments.event.getArg(i) />
			</cfif>
		</cfloop>
		
		<cfset redirectUrl = arguments.eventContext.getAppManager().getRequestManager().buildUrl(getModuleName(), getEventName(), params, getUrl()) />
		
		<cfreturn redirectUrl />
	</cffunction>
	
	<cffunction name="savePersistEventData" access="private" returntype="void" output="false"
		hint="Saves persisted event data and returns the persistId.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		
		<cfset var args = StructNew() />
		<cfset var persistArgs = getPersistArgs() />
		<cfset var persistArgsIgnore = getPersistArgsIgnore() />
		<cfset var persistId = "" />
		<cfset var i = "" />
		
		<!--- Build params --->
		<cfif NOT ListLen(persistArgs)>
			<cfset args = arguments.event.getArgs() />
			<!--- Remove the persist args to ignore --->
			<cfloop list="#persistArgsIgnore#" index="i" delimiters=",">
				<cfset StructDelete(args, i, FALSE) />
			</cfloop>
		<cfelse>
			<cfloop list="#persistArgs#" index="i" delimiters=",">
				<cfif arguments.event.isArgDefined(i)>
					<cfset args[i] = arguments.event.getArg(i) />
				</cfif>
			</cfloop>
		</cfif>

		<!--- Delete the event name from the args if it exists so a redirect loop doesn't occur --->
		<cfset StructDelete(args, getEventParameter(), FALSE) />
		
		<!--- Save the data --->
		<cfset persistId = arguments.eventContext.getAppManager().getRequestManager().savePersistEventData(args) />
		<cfset arguments.event.setArg(getRedirectPersistParameter(), persistId) />
	</cffunction>
	
	<!---
	ACCESSORS
	--->
	<cffunction name="setEventName" access="private" returntype="void" output="false">
		<cfargument name="eventName" type="string" required="true" />
		<cfset variables.eventName = arguments.eventName />
	</cffunction>
	<cffunction name="getEventName" access="private" returntype="string" output="false">
		<cfreturn variables.eventName />
	</cffunction>
	
	<cffunction name="setEventParameter" access="private" returntype="void" output="false">
		<cfargument name="eventParameter" type="string" required="true" />
		<cfset variables.eventParameter = arguments.eventParameter />
	</cffunction>
	<cffunction name="getEventParameter" access="private" returntype="string" output="false">
		<cfreturn variables.eventParameter />
	</cffunction>
	
	<cffunction name="setRedirectPersistParameter" access="private" returntype="void" output="false">
		<cfargument name="redirectPersistParameter" type="string" required="true" />
		<cfset variables.redirectPersistParameter = arguments.redirectPersistParameter />
	</cffunction>
	<cffunction name="getRedirectPersistParameter" access="private" returntype="string" output="false">
		<cfreturn variables.redirectPersistParameter />
	</cffunction>

	<cffunction name="setModuleName" access="private" returntype="void" output="false">
		<cfargument name="moduleName" type="string" required="true" />
		<cfset variables.moduleName = arguments.moduleName />
	</cffunction>
	<cffunction name="getModuleName" access="private" returntype="string" output="false">
		<cfreturn variables.moduleName />
	</cffunction>

	<cffunction name="setUrl" access="private" returntype="void" output="false">
		<cfargument name="url" type="string" required="true" />
		<cfset variables.url = arguments.url />
	</cffunction>
	<cffunction name="getUrl" access="private" returntype="string" output="false">
		<cfreturn variables.url />
	</cffunction>
	
	<cffunction name="setArgs" access="private" returntype="void" output="false">
		<cfargument name="args" type="string" required="true" />
		<cfset variables.args = arguments.args />
	</cffunction>
	<cffunction name="getArgs" access="private" returntype="string" output="false">
		<cfreturn variables.args />
	</cffunction>
	
	<cffunction name="setPersist" access="private" returntype="void" output="false">
		<cfargument name="persist" type="boolean" required="true" />
		<cfset variables.persist = arguments.persist />
	</cffunction>
	<cffunction name="getPersist" access="private" returntype="boolean" output="false">
		<cfreturn variables.persist />
	</cffunction>
	
	<cffunction name="setPersistArgs" access="private" returntype="void" output="false">
		<cfargument name="persistArgs" type="string" required="true" />
		<cfset variables.persistArgs = arguments.persistArgs />
	</cffunction>
	<cffunction name="getPersistArgs" access="private" returntype="string" output="false">
		<cfreturn variables.persistArgs />
	</cffunction>
	
	<cffunction name="setPersistArgsIgnore" access="private" returntype="void" output="false">
		<cfargument name="persistArgsIgnore" type="string" required="true" />
		<cfset variables.persistArgsIgnore = arguments.persistArgsIgnore />
	</cffunction>
	<cffunction name="getPersistArgsIgnore" access="private" returntype="string" output="false">
		<cfreturn variables.persistArgsIgnore />
	</cffunction>
	
	<cffunction name="setStatusType" access="private" returntype="void" output="false">
		<cfargument name="statusType" type="string" required="true" />
		<cfset variables.statusType = arguments.statusType />
	</cffunction>
	<cffunction name="getStatusType" access="private" returntype="string" output="false">
		<cfreturn variables.statusType />
	</cffunction>

</cfcomponent>