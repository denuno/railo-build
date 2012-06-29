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
$Id: ConfigListener.cfc 1285 2009-01-21 06:19:46Z peterfarrell $

Created version: 1.0.0
Updated version: 1.0.0

Notes:
--->
<cfcomponent
	displayname="FrameworkListener"
	extends="MachII.framework.Listener"	
	output="false"
	hint="Basic interface for base framework structures.">

	<!---
	PROPERTIES
	--->
	<cfset variables.componentReloadAvailable = false />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Initializes the listener.">
		<cfif getAppManager().getPropertyManager().getVersion() GTE "1.8.0.0">
			<cfset setComponentReloadAvailable(true) />
		</cfif>
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="getModuleData" access="public" returntype="struct" output="false"
		hint="Gets the data for all the modules.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var modules = getAppManager().getModuleManager().getModules() />
		<cfset var moduleData = StructNew() />
		<cfset var dependencyInjectionEngineProperty = "" />
		<cfset var i = "" />
		
		<cfloop collection="#modules#" item="i">
			<cfset moduleData[modules[i].getModuleName()]["lastReloadDateTime"] = modules[i].getModuleAppManager().getAppLoader().getLastReloadDatetime() />
			<cfset moduleData[modules[i].getModuleName()]["shouldReloadConfig"] = modules[i].getModuleAppManager().getAppLoader().shouldReloadConfig() />
			<cfset moduleData[modules[i].getModuleName()]["appManager"] = modules[i].getModuleAppManager() />
			<cfset dependencyInjectionEngineProperty = getProperty("udfs").findPropertyByType("MachII.properties.ColdspringProperty", modules[i].getModuleAppManager().getPropertyManager()) />
			<!--- Only grab this data if this module has a dependency injection engine property --->
			<cfif IsObject(dependencyInjectionEngineProperty)>
				<cfset moduleData[modules[i].getModuleName()]["lastDependencyInjectionEngineReloadDateTime"] = dependencyInjectionEngineProperty.getLastReloadDatetime() />
				<cfset moduleData[modules[i].getModuleName()]["shouldReloadDependencyInjectionEngineConfig"] = dependencyInjectionEngineProperty.shouldReloadConfig() />
			</cfif>
		</cfloop>
		
		<cfreturn moduleData />
	</cffunction>
	
	<cffunction name="getBaseData" access="public" returntype="struct" output="false"
		hint="Gets the data for the base app.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var baseData = StructNew() />
		<cfset var dependencyInjectionEngineProperty = "" />
		
		<cfset baseData["lastReloadDateTime"] = getAppManager().getParent().getAppLoader().getLastReloadDatetime() />
		<cfset baseData["shouldReloadConfig"] = getAppManager().getParent().getAppLoader().shouldReloadBaseConfig() />
		<cfset baseData["appManager"] = getAppManager().getParent() />
		<cfset dependencyInjectionEngineProperty = getProperty("udfs").findPropertyByType("MachII.properties.ColdspringProperty", getAppManager().getParent().getPropertyManager()) />
		<cfif IsObject(dependencyInjectionEngineProperty)>
			<cfset baseData["lastDependencyInjectionEngineReloadDateTime"] = dependencyInjectionEngineProperty.getLastReloadDatetime() />
			<cfset baseData["shouldReloadDependencyInjectionEngineConfig"] = dependencyInjectionEngineProperty.shouldReloadConfig() />
		</cfif>
		
		<cfreturn baseData />
	</cffunction>
	
	<cffunction name="getBaseComponentData" access="public" returntype="struct" output="false"
		hint="Gets the component data for the base app.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfif isComponentReloadAvailable()>
			<cfreturn getComponentDataByAppManager(getAppManager().getParent()) />
		<cfelse>
			<cfreturn StructNew() />
		</cfif>
	</cffunction>
	
	<cffunction name="getModuleComponentData" access="public" returntype="struct" output="false"
		hint="Gets the component data for the base app.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var data = StructNew() />
		<cfset var modules = getAppManager().getModuleManager().getModules() />
		<cfset var i = "" />
		
		<cfif isComponentReloadAvailable()>
			<cfloop collection="#modules#" item="i">
				<cfset data[modules[i].getModuleName()] = getComponentDataByAppManager(modules[i].getModuleAppManager()) />
			</cfloop>
			
			<cfreturn data />
		<cfelse>
			<cfreturn StructNew() />
		</cfif>
	</cffunction>
	
	<cffunction name="reloadModule" access="public" returntype="void" output="false"
		hint="Reloads a module.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var moduleName = arguments.event.getArg("moduleName", "") />
		<cfset var tickStart = 0 />
		<cfset var tickEnd = 0 />
		<cfset var message = CreateObject("component", "MachIIDashboard.model.sys.Message").init("", "success") />
		
		<cfif getAppManager().getModuleManager().isModuleDefined(moduleName)>
			<cftry>
				<cfset tickStart = getTickcount() />
				<cfset getAppManager().getModuleManager().getModule(moduleName).reloadModuleConfig() />
				<cfset tickEnd = getTickcount() />
				<cfset message.setMessage("Reloaded module '#moduleName#' in #NumberFormat(tickEnd - tickStart)#ms.") />
				<cfcatch type="any">
					<cfset message.setMessage("Exception occurred during the reload of module named '#moduleName#'.") />
					<cfset message.setType("exception") />
					<cfset message.setCaughtException(cfcatch) />
				</cfcatch>
			</cftry>
			
			<cfset arguments.event.setArg("message", message) />
			<cfset getLog().info(message.getMessage(), message.getCaughtException()) />
		</cfif>
	</cffunction>
	
	<cffunction name="reloadBaseApp" access="public" returntype="void" output="false"
		hint="Reload the base app.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var tickStart = 0 />
		<cfset var tickEnd = 0 />
		<cfset var message = CreateObject("component", "MachIIDashboard.model.sys.Message").init("", "success") />
		
		<cftry>
			<cfset tickStart = getTickcount() />
			<cfset getAppManager().getParent().getAppLoader().reloadConfig() />
			<cfset tickEnd = getTickcount() />
			<cfset message.setMessage("Reloaded base application in #NumberFormat(tickEnd - tickStart)#ms.") />	
			<cfcatch type="any">
				<cfset message.setMessage("Exception occurred during the reload of the base application.") />
				<cfset message.setType("exception") />
				<cfset message.setCaughtException(cfcatch) />			
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset getLog().info(message.getMessage(), message.getCaughtException()) />
	</cffunction>
	
	<cffunction name="reloadAllChangedComponents" access="public" returntype="void" output="false"
		hints="Reloads all changed components.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var baseComponentData = getBaseComponentData(arguments.event) />
		<cfset var moduleComponentData = getModuleComponentData(arguments.event) />
		<cfset var manager = "" />
		<cfset var key = "" />
		<cfset var i = 0 />
		<cfset var temp = StructNew() />
		<cfset var message = CreateObject("component", "MachIIDashboard.model.sys.Message").init() />
		<cfset var type = "" />
		<cfset var name = "" />
		<cfset var module = "" />
		<cfset var count = 0 />
		<cfset var tickStart = getTickCount() />
		<cfset var tickEnd = 0 />
		
		<!--- Reload base components --->
		<cftry>
			<cfloop from="1" to="#ArrayLen(baseComponentData.listeners)#" index="i">
				<cfif baseComponentData.listeners[i].shouldReloadObject>
					<cfset type = "listener" />
					<cfset name = baseComponentData.listeners[i].name />
					<cfset module = "" />
					<cfset count = count + 1 />
					<cfset reloadListenerByModuleName(baseComponentData.listeners[i].name) />/
				</cfif>
			</cfloop>
			<cfloop from="1" to="#ArrayLen(baseComponentData.filters)#" index="i">
				<cfif baseComponentData.filters[i].shouldReloadObject>
					<cfset type = "listener" />
					<cfset name = baseComponentData.filters[i].name />
					<cfset module = "" />
					<cfset count = count + 1 />
					<cfset reloadFilterByModuleName(baseComponentData.filters[i].name) />
				</cfif>
			</cfloop>
			<cfloop from="1" to="#ArrayLen(baseComponentData.plugins)#" index="i">
				<cfif baseComponentData.plugins[i].shouldReloadObject>
					<cfset type = "listener" />
					<cfset name = baseComponentData.plugins[i].name />
					<cfset module = "" />
					<cfset reloadPluginByModuleName(baseComponentData.plugins[i].name) />
				</cfif>
			</cfloop>
			<cfloop from="1" to="#ArrayLen(baseComponentData.properties)#" index="i">
				<cfif baseComponentData.properties[i].shouldReloadObject>
					<cfset type = "listener" />
					<cfset name = baseComponentData.properties[i].name />
					<cfset module = "" />
					<cfset count = count + 1 />
					<cfset reloadPropertyByModuleName(baseComponentData.properties[i].name) />
				</cfif>
			</cfloop>
			
			<!--- Reload module components --->		
			<cfloop collection="#moduleComponentData#" item="key">
				<cfloop from="1" to="#ArrayLen(moduleComponentData[key].listeners)#" index="i">
					<cfif moduleComponentData[key].listeners[i].shouldReloadObject>
						<cfset type = "listener" />
						<cfset name = moduleComponentData[key].listeners[i].name />
						<cfset module = key />
						<cfset count = count + 1 />
						<cfset reloadListenerByModuleName(moduleComponentData[key].listeners[i].name, key) />
					</cfif>
				</cfloop>
				<cfloop from="1" to="#ArrayLen(moduleComponentData[key].filters)#" index="i">
					<cfif moduleComponentData[key].filters[i].shouldReloadObject>
						<cfset type = "filter" />
						<cfset name = moduleComponentData[key].filters[i].name />
						<cfset module = key />
						<cfset count = count + 1 />
						<cfset reloadFilterByModuleName(moduleComponentData[key].filters[i].name, key) />
					</cfif>
				</cfloop>
				<cfloop from="1" to="#ArrayLen(moduleComponentData[key].plugins)#" index="i">
					<cfif moduleComponentData[key].plugins[i].shouldReloadObject>
						<cfset type = "plugin" />
						<cfset name = moduleComponentData[key].plugins[i].name />
						<cfset module = key />
						<cfset count = count + 1 />
						<cfset reloadPluginByModuleName(moduleComponentData[key].plugins[i].name, key) />
					</cfif>
				</cfloop>
				<cfloop from="1" to="#ArrayLen(moduleComponentData[key].properties)#" index="i">
					<cfif moduleComponentData[key].properties[i].shouldReloadObject>
						<cfset type = "property" />
						<cfset name = moduleComponentData[key].properties[i].name />
						<cfset module = key />
						<cfset count = count + 1 />
						<cfset reloadPropertyByModuleName(moduleComponentData[key].properties[i].name, key) />
					</cfif>
				</cfloop>
			</cfloop>
			
			<cfset tickEnd = getTickCount() />
			<cfset message.setMessage("Reloaded #count# changed components in base and all modules in #NumberFormat(tickEnd - tickStart)#ms.") />
			
			<cfcatch type="any">
				<cfset message.setMessage("Exception occurred during the reload of #type# named '#name#' in module '#module#'.") />
				<cfset message.setType("exception") />
				<cfset message.setCaughtException(cfcatch) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset getLog().info(message.getMessage(), message.getCaughtException()) />
	</cffunction>
	
	<cffunction name="reloadListener" access="public" returntype="void" output="false"
		hint="Reloads a listener.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var listenerName = arguments.event.getArg("listenerName") />
		<cfset var moduleName = arguments.event.getArg("moduleName", "") />
		<cfset var message = CreateObject("component", "MachIIDashboard.model.sys.Message").init("Reloaded listener named '#listenerName#' in module '#moduleName#'.", "success") />

		<cftry>
			<cfif Len(moduleName)>
				<cfset reloadListenerByModuleName(listenerName, moduleName) />
			<cfelse>
				<cfset reloadListenerByModuleName(listenerName) />
			</cfif>
			<cfcatch type="any">
				<cfset message.setMessage("Exception occurred during the reload of listener named '#listenerName#' in module '#moduleName#'.") />
				<cfset message.setType("exception") />
				<cfset message.setCaughtException(cfcatch) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset getLog().info(message.getMessage(), message.getCaughtException()) />
	</cffunction>
	
	<cffunction name="reloadFilter" access="public" returntype="void" output="false"
		hint="Reloads a filter.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var filterName = arguments.event.getArg("filterName") />
		<cfset var moduleName = arguments.event.getArg("moduleName", "") />
		<cfset var message = CreateObject("component", "MachIIDashboard.model.sys.Message").init("Reloaded event-filter named '#filterName#' in module '#moduleName#'.", "success") />

		<cftry>
			<cfif Len(moduleName)>
				<cfset reloadFilterByModuleName(filterName, moduleName) />
			<cfelse>
				<cfset reloadFilterByModuleName(filterName) />
			</cfif>
			<cfcatch type="any">
				<cfset message.setMessage("Exception occurred during the reload of event-filter named '#filterName#' in module '#moduleName#'.") />
				<cfset message.setType("exception") />
				<cfset message.setCaughtException(cfcatch) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset getLog().info(message.getMessage(), message.getCaughtException()) />
	</cffunction>
	
	<cffunction name="reloadPlugin" access="public" returntype="void" output="false"
		hint="Reloads a plugin.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var pluginName = arguments.event.getArg("pluginName") />
		<cfset var moduleName = arguments.event.getArg("moduleName") />
		<cfset var message = CreateObject("component", "MachIIDashboard.model.sys.Message").init("Reloaded plugin named '#pluginName#' in module '#moduleName#'.", "success") />

		<cftry>
			<cfif Len(moduleName)>
				<cfset reloadPluginByModuleName(pluginName, moduleName) />
			<cfelse>
				<cfset reloadPluginByModuleName(pluginName) />
			</cfif>
			<cfcatch type="any">
				<cfset message.setMessage("Exception occurred during the reload of plugin named '#pluginName#' in module '#moduleName#'.") />
				<cfset message.setType("exception") />
				<cfset message.setCaughtException(cfcatch) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset getLog().info(message.getMessage(), message.getCaughtException()) />
	</cffunction>
	
	<cffunction name="reloadProperty" access="public" returntype="void" output="false"
		hint="Reloads a property.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var propertyName = arguments.event.getArg("propertyName") />
		<cfset var moduleName = arguments.event.getArg("moduleName") />
		<cfset var message = CreateObject("component", "MachIIDashboard.model.sys.Message").init("Reloaded property named '#propertyName#' in module '#moduleName#'.", "success") />

		<cftry>
			<cfif Len(moduleName)>
				<cfset reloadPropertyByModuleName(propertyName, moduleName) />
			<cfelse>
				<cfset reloadPropertyByModuleName(propertyName) />
			</cfif>
			<cfcatch type="any">
				<cfset message.setMessage("Exception occurred during the reload of property named '#propertyName#' in module '#moduleName#'.") />
				<cfset message.setType("exception") />
				<cfset message.setCaughtException(cfcatch) />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset getLog().info(message.getMessage(), message.getCaughtException()) />
	</cffunction>
	
	<cffunction name="reloadModuleDependencyInjectionEngine" access="public" returntype="void" output="false"
		hint="Reloads dependency injection engine in a module by module name.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var moduleName = arguments.event.getArg("moduleName", "") />
		<cfset var log = getLog() />
		<cfset var tickStart = 0 />
		<cfset var tickEnd = 0 />
		<cfset var message = CreateObject("component", "MachIIDashboard.model.sys.Message").init("", "success") />
		
		<cfif getAppManager().getModuleManager().isModuleDefined(moduleName)>
			<cftry>
				<cfset tickStart = getTickcount() />
				<cfset getProperty("udfs").findPropertyByType("MachII.properties.ColdspringProperty", getAppManager().getModuleManager().getModule(moduleName).getModuleAppManager().getPropertyManager()).configure() />
				<cfset tickEnd = getTickcount() />
				<cfset message.setMessage("Reloaded dependency injection engine for module '#moduleName#' in #NumberFormat(tickEnd - tickStart)#ms.") />
				<cfcatch type="any">
					<cfset message.setMessage("Exception occurred during the reload of denpendency injection engine in module '#moduleName#'.") />\
					<cfset message.setType("exception") />
					<cfset message.setCaughtException(cfcatch) />
				</cfcatch>
			</cftry>
			
			<cfset arguments.event.setArg("message", message) />
			<cfset getLog().info(message.getMessage(), message.getCaughtException()) />
		</cfif>
	</cffunction>
	
	<cffunction name="reloadBaseAppDependencyInjectionEngine" access="public" returntype="void" output="false"
		hint="Reloads dependency injection engine across the entire application.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var modules = getAppManager().getModuleManager().getModules() />
		<cfset var log = getLog() />
		<cfset var tickStart = getTickcount() />
		<cfset var tickEnd = 0 />
		<cfset var key = "" />
		<cfset var message = CreateObject("component", "MachIIDashboard.model.sys.Message").init("", "success") />
		
		<cftry>	
			<cfset getProperty("udfs").findPropertyByType("MachII.properties.ColdspringProperty", getAppManager().getParent().getPropertyManager()).configure() />
		
			<cfloop collection="#modules#" item="key">
				<!--- Don't reload the CS for the dashboard since it will just reload the base --->
				<cfif getAppManager().getModuleName() NEQ key>
					<cfset getProperty("udfs").findPropertyByType("MachII.properties.ColdspringProperty", modules[key].getModuleAppManager().getPropertyManager()).configure() />
				</cfif>
			</cfloop>
			
			<cfset tickEnd = getTickcount() />
			<cfset message.setMessage("Reloaded dependency injection engine in #tickEnd - tickStart#ms.") />
			
			<cfcatch type="any">
				<cfset message.setCaughtException(cfcatch) />
				<cfset message.setType("exception") />
					
				<cfif NOT Len(key)>
					<cfset message.setMessage("Exception occurred during the reload of denpendency injection engine in base application.") />	
				<cfelse>
					<cfset message.setMessage("Exception occurred during the reload of denpendency injection engine in module '#key#'.") />
				</cfif>
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset getLog().info(message.getMessage(), message.getCaughtException()) />
	</cffunction>

	<!---
	PROTECTED FUNCTIONS
	--->
	<cffunction name="getComponentDataByAppManager" access="private" returntype="struct" output="false"
		hint="Gets the component data from the passed appManager.">
		<cfargument name="moduleAppManager" type="MachII.framework.AppManager" required="true" />
		
		<cfset var data = StructNew() />
		<cfset var objectNames = "" />
		<cfset var objectProxy = "" />
		<cfset var temp = StructNew() />
		<cfset var i = 0 />
		
		<!--- Listeners --->
		<cfset objectNames = moduleAppManager.getListenerManager().getListenerNames() />
		<cfset ArraySort(objectNames, "textnocase", "asc") />
		
		<cfset data.listeners = ArrayNew(1) />
		
		<cfloop from="1" to="#ArrayLen(objectNames)#" index="i">
			<cfset objectProxy = moduleAppManager.getListenerManager().getListener(objectNames[i]).getProxy() />
			
			<cfset temp = StructNew() />
			
			<cfset temp.name = objectNames[i] />
			<cfset temp.shouldReloadObject = objectProxy.shouldReloadObject() />
			
			<cfset ArrayAppend(data.listeners, temp) />
		</cfloop>
		
		<!--- Plugins --->
		<cfset objectNames = moduleAppManager.getPluginManager().getPluginNames() />
		<cfset ArraySort(objectNames, "textnocase", "asc") />
		
		<cfset data.plugins = ArrayNew(1) />
		
		<cfloop from="1" to="#ArrayLen(objectNames)#" index="i">
			<cfset objectProxy = moduleAppManager.getPluginManager().getPlugin(objectNames[i]).getProxy() />
			
			<cfset temp = StructNew() />
			
			<cfset temp.name = objectNames[i] />
			<cfset temp.shouldReloadObject = objectProxy.shouldReloadObject() />
			
			<cfset ArrayAppend(data.plugins, temp) />
		</cfloop>
		
		<!--- Filters --->
		<cfset objectNames = moduleAppManager.getFilterManager().getFilterNames() />
		<cfset ArraySort(objectNames, "textnocase", "asc") />
		
		<cfset data.filters = ArrayNew(1) />
		
		<cfloop from="1" to="#ArrayLen(objectNames)#" index="i">
			<cfset objectProxy = moduleAppManager.getFilterManager().getFilter(objectNames[i]).getProxy() />
			
			<cfset temp = StructNew() />
			
			<cfset temp.name = objectNames[i] />
			<cfset temp.shouldReloadObject = objectProxy.shouldReloadObject() />
			
			<cfset ArrayAppend(data.filters, temp) />
		</cfloop>
		
		<!--- Configurable Properties --->
		<cfset objectNames = moduleAppManager.getPropertyManager().getConfigurablePropertyNames() />
		<cfset ArraySort(objectNames, "textnocase", "asc") />
		
		<cfset data.properties = ArrayNew(1) />
		
		<cfloop from="1" to="#ArrayLen(objectNames)#" index="i">
			<cfset objectProxy = moduleAppManager.getPropertyManager().getProperty(objectNames[i]).getProxy() />
			
			<cfset temp = StructNew() />
			
			<cfset temp.name = objectNames[i] />
			<cfset temp.shouldReloadObject = objectProxy.shouldReloadObject() />
			
			<cfset ArrayAppend(data.properties, temp) />
		</cfloop>
		
		<cfreturn data />
	</cffunction>
	
	<cffunction name="reloadListenerByModuleName" access="private" returntype="void" output="false"
		hint="Reloads a listener by module name.">
		<cfargument name="listenerName" type="string" required="true" />
		<cfargument name="moduleName" type="string" required="false"
			hint="Not passing a module name indicates the 'base' application." />
		
		<cfset var listenerManager = "" />
		
		<cfif StructKeyExists(arguments, "moduleName")>
			<cfset listenerManager = getAppManager().getModuleManager().getModule(moduleName).getModuleAppManager().getListenerManager() />
		<cfelse>
			<cfset listenerManager = getAppManager().getParent().getListenerManager() />
		</cfif>

		<cfset listenerManager.reloadListener(arguments.listenerName) />
	</cffunction>
	
	<cffunction name="reloadFilterByModuleName" access="private" returntype="void" output="false"
		hint="Reloads a filter by module name.">
		<cfargument name="filterName" type="string" required="true" />
		<cfargument name="moduleName" type="string" required="false"
			hint="Not passing a module name indicates the 'base' application." />
		
		<cfset var filterManager = "" />
		
		<cfif StructKeyExists(arguments, "moduleName")>
			<cfset filterManager = getAppManager().getModuleManager().getModule(moduleName).getModuleAppManager().getFilterManager() />
		<cfelse>
			<cfset filterManager = getAppManager().getParent().getFilterManager() />
		</cfif>

		<cfset filterManager.reloadFilter(arguments.filterName) />
	</cffunction>
	
	<cffunction name="reloadPluginByModuleName" access="private" returntype="void" output="false"
		hint="Reloads a plugin by module name.">
		<cfargument name="pluginName" type="string" required="true" />
		<cfargument name="moduleName" type="string" required="false"
			hint="Not passing a module name indicates the 'base' application." />
		
		<cfset var pluginManager = "" />
		
		<cfif StructKeyExists(arguments, "moduleName")>
			<cfset pluginManager = getAppManager().getModuleManager().getModule(moduleName).getModuleAppManager().getPluginManager() />
		<cfelse>
			<cfset pluginManager = getAppManager().getParent().getPluginManager() />
		</cfif>

		<cfset pluginManager.reloadPlugin(arguments.pluginName) />
	</cffunction>
	
	<cffunction name="reloadPropertyByModuleName" access="private" returntype="void" output="false"
		hint="Reloads a property by module name.">
		<cfargument name="propertyName" type="string" required="true" />
		<cfargument name="moduleName" type="string" required="false"
			hint="Not passing a module name indicates the 'base' application." />
		
		<cfset var propertyManager = "" />
		
		<cfif StructKeyExists(arguments, "moduleName")>
			<cfset propertyManager = getAppManager().getModuleManager().getModule(moduleName).getModuleAppManager().getPropertyManager() />
		<cfelse>
			<cfset propertyManager = getAppManager().getParent().getPropertyManager() />
		</cfif>

		<cfset propertyManager.reloadProperty(arguments.propertyName) />
	</cffunction>
	
	<!---
	ACCESSORS
	--->
	<cffunction name="setComponentReloadAvailable" access="private" returntype="void" output="false">
		<cfargument name="componentReloadAvailable" type="boolean" required="true" />
		<cfset variables.componentReloadAvailable = arguments.componentReloadAvailable />
	</cffunction>
	<cffunction name="isComponentReloadAvailable" access="public" returntype="boolean" output="false">
		<cfreturn variables.componentReloadAvailable />
	</cffunction>

</cfcomponent>