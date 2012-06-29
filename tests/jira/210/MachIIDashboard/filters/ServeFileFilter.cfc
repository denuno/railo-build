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
$Id: ServeFileFilter.cfc 1308 2009-01-27 21:13:45Z peterfarrell $

Created version: 1.0.0
Updated version: 1.0.0

Notes:
--->
<cfcomponent
	displayname="ServeFileFilter" 
	extends="MachII.framework.EventFilter"
	output="false" 
	hint="Serves file via cfcontent">
	
	<!---
	PROPERTIES
	--->
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the filter.">
		<cfset setBasePath(ExpandPath(getParameter("basePath"))) />
		<cfset setContentTypes(getParameter("contentTypes")) />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="filterEvent" access="public" returntype="boolean" output="true"
		hint="Filters the event.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="paramArgs" type="struct" required="true" />
		
		<!--- We use "@" for "/"  due to the possibility of SES URLs --->
		<cfset var path = Replace(arguments.event.getArg("path"), "@", "/", "all") />
		<cfset var contentType = getContentTypeByFilePath(path) />
		
		<cfif contentType EQ "text/css">
			<cfsetting enablecfoutputonly="true" />
			<cfcontent reset="true" type="#contentType#" />
			<cfoutput><cfinclude template="#getParameter("basePath")##Replace(path, ".css", ".cfm", "all")#" /></cfoutput>
		<cfelseif contentType NEQ "unknown">
			<cfcontent file="#getBasePath()##path#" type="#contentType#" />
		<cfelse>
			<cfabort showerror="Invalid file." />
		</cfif>
		
		<cfreturn false />
	</cffunction>
	
	<!---
	PROTECTED FUNCTIONS
	--->
	<cffunction name="getContentTypeByFilePath" access="private" returntype="string" output="false"
		hint="Gets the content type by the file path.">
		<cfargument name="path" type="string" required="true" />
		
		<cfset var extension = ListLast(arguments.path, ".") />
		<cfset var contentTypes = getContentTypes() />
		<cfset var result = "unknown" />
		
		<cfif StructKeyExists(contentTypes, extension)>
			<cfset result = contentTypes[extension] />
		</cfif>
		
		<cfreturn result />
	</cffunction>
	
	<!---
	ACCESSORS
	--->

	<cffunction name="setBasePath" access="public" returntype="void" output="false">
		<cfargument name="basePath" type="string" required="true" />
		<cfset variables.basePath = arguments.basePath />
	</cffunction>
	<cffunction name="getBasePath" access="public" returntype="string" output="false">
		<cfreturn variables.basePath />
	</cffunction>

	<cffunction name="setContentTypes" access="public" returntype="void" output="false">
		<cfargument name="contentTypes" type="struct" required="true" />
		<cfset variables.contentTypes = arguments.contentTypes />
	</cffunction>
	<cffunction name="getContentTypes" access="public" returntype="struct" output="false">
		<cfreturn variables.contentTypes />
	</cffunction>

</cfcomponent>