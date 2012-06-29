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
$Id: ListenerManager.cfc 1096 2008-10-13 18:47:43Z peterfarrell $

Created version: 1.0.0
Updated version: 1.6.0

Notes:
--->
<cfcomponent 
	displayname="ListenerManager"
	output="false"
	hint="Manages registered Listeners for the framework instance.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.listeners = StructNew() />
	<cfset variables.defaultInvoker = "" />
	<cfset variables.appManager = "" />
	<cfset variables.parentListenerManager = "" />
	<cfset variables.utils = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="ListenerManager" output="false"
		hint="Initialization function called by the framework.">
		<cfargument name="appManager" type="MachII.framework.AppManager" required="true" />
		<cfargument name="parentListenerManager" type="any" required="false" default=""
			hint="Optional argument for a parent listener manager. If there isn't one default to empty string." />	
		
		<cfset setAppManager(arguments.appManager) />
		<cfset variables.utils = getAppManager().getUtils() />
		
		<cfif IsObject(arguments.parentListenerManager)>
			<cfset setParent(arguments.parentListenerManager) />
		</cfif>
		
		<!--- Instantiate the default invoker (invokers are stateless) --->
		<cfset variables.defaultInvoker = CreateObject("component", "MachII.framework.invokers.EventInvoker").init() />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="loadXml" access="public" returntype="void" output="false"
		hint="Loads xml into the manager.">
		<cfargument name="configXML" type="string" required="true" />
		<cfargument name="override" type="boolean" required="false" default="false" />
		
		<cfset var listenerNodes = ArrayNew(1) />
		<cfset var listenerParams = "" />
		<cfset var listenerName = "" />
		<cfset var listenerType = "" />
		<cfset var listener = "" />
		
		<cfset var paramNodes = ArrayNew(1) />
		<cfset var paramName = "" />
		<cfset var paramValue = "" />
		
		<cfset var invokerType = "" />
		<cfset var invoker = "" />
		<cfset var instantiatedInvokers = StructNew() />

		<cfset var hasParent = IsObject(getParent()) />
		<cfset var mapping = "" />
		<cfset var i = 0 />
		<cfset var j = 0 />

		<!--- Search for listeners --->
		<cfif NOT arguments.override>
			<cfset listenerNodes = XMLSearch(arguments.configXML, "mach-ii/listeners/listener") />
		<cfelse>
			<cfset listenerNodes = XMLSearch(arguments.configXML, ".//listeners/listener") />
		</cfif>
		
		<!--- Setup up each Listener --->
		<cfloop from="1" to="#ArrayLen(listenerNodes)#" index="i">
			<cfset listenerName = listenerNodes[i].xmlAttributes["name"] />
			
			<!--- Override XML for Modules --->
			<cfif hasParent AND arguments.override AND StructKeyExists(listenerNodes[i].xmlAttributes, "overrideAction")>
				<cfif listenerNodes[i].xmlAttributes["overrideAction"] EQ "useParent">
					<cfset removeListener(listenerName) />
				<cfelseif listenerNodes[i].xmlAttributes["overrideAction"] EQ "addFromParent">
					<!--- Check for a mapping --->
					<cfif StructKeyExists(listenerNodes[i].xmlAttributes, "mapping")>
						<cfset mapping = listenerNodes[i].xmlAttributes["mapping"] />
					<cfelse>
						<cfset mapping = listenerName />
					</cfif>
					
					<!--- Check if parent has event handler with the mapping name --->
					<cfif NOT getParent().isListenerDefined(mapping)>
						<cfthrow type="MachII.framework.overrideListenerNotDefined"
							message="An listener named '#mapping#' cannot be found in the parent listener manager for the override named '#listenerName#' in module '#getAppManager().getModuleName()#'." />
					</cfif>
					
					<cfset addListener(listenerName, getParent().getListener(mapping), arguments.override) />
				</cfif>
			<!--- General XML setup --->
			<cfelse>
				<cfset listenerType = listenerNodes[i].xmlAttributes["type"] />
			
				<!--- Get the Listener's parameters --->
				<cfset listenerParams = StructNew() />
				
				<!--- Parse all the parameters --->
				<cfif StructKeyExists(listenerNodes[i], "parameters")>
					<cfset paramNodes = listenerNodes[i].parameters.xmlChildren />
					<cfloop from="1" to="#ArrayLen(paramNodes)#" index="j">
						<cfset paramName = paramNodes[j].xmlAttributes["name"] />						
						<cftry>
							<cfset paramValue = variables.utils.recurseComplexValues(paramNodes[j]) />
							<cfcatch type="any">
								<cfthrow type="MachII.framework.InvalidParameterXml"
									message="Xml parsing error for the parameter named '#paramName#' for listener '#listenerName#' in module '#getAppManager().getModuleName()#'." />
							</cfcatch>
						</cftry>
						<cfset listenerParams[paramName] = paramValue />
					</cfloop>
				</cfif>
			
				<!--- Setup the Listener --->
				<cftry>
					<!--- Do not method chain the init() on the instantiation
						or objects that have their init() overridden will
						cause the variable the object is assigned to will 
						be deleted if init() returns void --->
					<cfset listener = CreateObject("component", listenerType) />
					<cfset listener.init(getAppManager(), listenerParams) />
					
					<cfcatch type="expression">
						<cfthrow type="MachII.framework.ListenerSyntaxException"
							message="Mach-II could not register a listener with type of '#listenerType#' for the listener named '#listenerName#' in module named '#getAppManager().getModuleName()#'. #cfcatch.message#"
							detail="#cfcatch.detail#" />
					</cfcatch>
					<cfcatch type="any">
						<cfif StructKeyExists(cfcatch, "missingFileName")>
							<cfthrow type="MachII.framework.CannotFindListener"
								message="Cannot find a listener CFC with type of '#listenerType#' for the listener named '#listenerName#' in module named '#getAppManager().getModuleName()#'."
								detail="Please check that this listener exists and that there is not a misconfiguration in the XML configuration file." />
						<cfelse>
							<cfrethrow />
						</cfif>						
					</cfcatch>
				</cftry>
	
				<!--- Use declared invoker from config file --->
				<cfif StructKeyExists(listenerNodes[i], "invoker")>
					<cfset invokerType = listenerNodes[i].invoker.xmlAttributes["type"] />

					<!--- Uses the flyweight pattern to reduce the number of instantiations of invokers --->
					<cfif NOT StructKeyExists(instantiatedInvokers, Hash(invokerType))>
						<cftry>	
							<cfset instantiatedInvokers[Hash(invokerType)] = CreateObject("component", invokerType).init() />
	
							<cfcatch type="any">
								<cfif StructKeyExists(cfcatch, "missingFileName")>
									<cfthrow type="MachII.framework.CannotFindInvoker"
										message="Cannot find an listener invoker CFC with type of '#invokerType#' for the listener named '#listenerName#' in module named '#getAppManager().getModuleName()#'."
										detail="Please check that the invoker exists for this listener and that there is not a misconfiguration in the XML configuration file." />
								<cfelse>
									<cfrethrow />
								</cfif>
							</cfcatch>
						</cftry>
					</cfif>
					
					<cfset invoker = instantiatedInvokers[Hash(invokerType)] />
					
				<!--- Use defaultInvoker --->
				<cfelse>
					<cfset invoker = defaultInvoker />
				</cfif>
	
				<!--- Continue setup on the Listener --->
				<cfset listener.setInvoker(invoker) />
				<!--- Add the Listener to the manager --->
				<cfset addListener(listenerName, listener, arguments.override) />
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="configure" access="public" returntype="void"
		hint="Configures each of the registered listeners and its' invoker.">

		<cfset var logFactory = getAppManager().getLogFactory() />
		<cfset var aListener = 0 />
		<cfset var i = 0 />
		
		<!--- Loop through the listeners configure --->
		<cfloop collection="#variables.listeners#" item="i">
			<cfset aListener = variables.listeners[i] />
			<cfset aListener.setLog(logFactory) />
			<cfset aListener.configure() />
		</cfloop>
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getListener" access="public" returntype="MachII.framework.Listener" output="false"
		hint="Gets a listener with the specified name.">
		<cfargument name="listenerName" type="string" required="true" />
		
		<cfif isListenerDefined(arguments.listenerName)>
			<cfreturn variables.listeners[arguments.listenerName] />
		<cfelseif IsObject(getParent()) AND getParent().isListenerDefined(arguments.listenerName)>
			<cfreturn getParent().getListener(arguments.listenerName) />
		<cfelse>
			<cfthrow type="MachII.framework.ListenerNotDefined" 
				message="Listener with name '#arguments.listenerName#' is not defined. Available Listeners: '#ArrayToList(getListenerNames())#'" />
		</cfif>
	</cffunction>
	
	<cffunction name="addListener" access="public" returntype="void" output="false"
		hint="Registers a listener with the specified name.">
		<cfargument name="listenerName" type="string" required="true" />
		<cfargument name="listener" type="MachII.framework.Listener" required="true" />
		<cfargument name="overrideCheck" type="boolean" required="false" default="false" />
		
		<cfif NOT arguments.overrideCheck AND isListenerDefined(arguments.listenerName)>
			<cfthrow type="MachII.framework.ListenerAlreadyDefined"
				message="A Listener with name '#arguments.listenerName#' is already registered." />
		<cfelse>
			<cfset variables.listeners[arguments.listenerName] = arguments.listener />
		</cfif>
	</cffunction>
	
	<cffunction name="removeListener" access="public" returntype="void" output="false"
		hint="Removes a listener. Does NOT remove from a parent.">
		<cfargument name="listenerName" type="string" required="true" />
		<cfset StructDelete(variables.listeners, arguments.listenerName, false) />
	</cffunction>
	
	<cffunction name="isListenerDefined" access="public" returntype="boolean" output="false"
		hint="Returns true if a listener is registered with the specified name. Does NOT check parent.">
		<cfargument name="listenerName" type="string" required="true" />
		<cfreturn StructKeyExists(variables.listeners, arguments.listenerName) />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS - UTILS
	--->
	<cffunction name="getListenerNames" access="public" returntype="array" output="false"
		hint="Returns an array of listener names.">
		<cfreturn StructKeyArray(variables.listeners) />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setAppManager" access="public" returntype="void" output="false"
		hint="Returns the AppManager instance this ListenerManager belongs to.">
		<cfargument name="appManager" type="MachII.framework.AppManager" required="true" />
		<cfset variables.appManager = arguments.appManager />
	</cffunction>
	<cffunction name="getAppManager" access="public" returntype="MachII.framework.AppManager" output="false"
		hint="Sets the AppManager instance this ListenerManager belongs to.">
		<cfreturn variables.appManager />
	</cffunction>
	
	<cffunction name="setParent" access="public" returntype="void" output="false"
		hint="Returns the parent ListenerManager instance this ListenerManager belongs to.">
		<cfargument name="parentListenerManager" type="MachII.framework.ListenerManager" required="true" />
		<cfset variables.parentListenerManager = arguments.parentListenerManager />
	</cffunction>
	<cffunction name="getParent" access="public" returntype="any" output="false"
		hint="Sets the parent ListenerManager instance this ListenerManager belongs to. It will return empty string if no parent is defined.">
		<cfreturn variables.parentListenerManager />
	</cffunction>
	
</cfcomponent>