<cfsilent>
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
$Id: index.cfm 1285 2009-01-21 06:19:46Z peterfarrell $

Created version: 1.0.0
Updated version: 1.0.0

Notes:
--->
<cfimport prefix="dashboard" taglib="/MachIIDashboard/customtags" />
<cfset variables.modules = event.getArg("moduleData") />
<cfset variables.moduleOrder = StructKeyArray(variables.modules) />
<cfset ArraySort(variables.moduleOrder, "textnocase", "asc") />
<cfset variables.base = event.getArg("baseData") />
</cfsilent>
<cfoutput>

<dashboard:displayMessage />

<h1>Configuration File Status</h1>

<ul class="pageNavTabs">
	<li>
		<a href="#buildUrl("config.reloadBaseApp")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@database_refresh.png")#" width="16" height="16" alt="Reload" />
			&nbsp;Reload All Mach-II Config Files
		</a>
	</li>
<cfif StructKeyExists(variables.base, "lastDependencyInjectionEngineReloadDateTime")>
	<li>
		<a href="#buildUrl("config.reloadBaseAppDependencyInjectionEngine")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@database_refresh.png")#" width="16" height="16" alt="Reload" />
			&nbsp;Reload All Dependency Injection Engine Config Files
		</a>
	</li>
</cfif>
	<li>
		<a href="#BuildUrl("config.index")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@arrow_rotate_clockwise.png")#" width="16" height="16" alt="Flush All" />
			&nbsp;Refresh Stats
		</a>
	</li>
</ul>

<table>
	<tr>
		<th style="width:33.3%;"><h3>Module</h3></th>
		<th style="width:33.3%;"><h3>Mach-II</h3></th>
		<th style="width:33.3%;"><h3>Dependency Injection Engine</h3></th>
	</tr>
	<tr>
		<td>
			<h4>Base</h4>
			<p class="small">
				<a href="#BuildUrlToModule("", variables.base.appManager.getPropertyManager().getProperty("defaultEvent"))#">
					<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@link_go.png")#" width="16" height="16" alt="Link" />
					go to default event
				</a>
			</p>
		</td>
		<td>
			<p>
				<a href="#buildUrl("config.reloadBaseApp")#">
				<cfif variables.base.shouldReloadConfig>
					<span class="red">
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
						&nbsp;reloaded #getProperty("udfs").datetimeDifferenceString(variables.base.lastReloadDateTime)# ago
					</span>
				<cfelse>
					<span class="green">
					<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
					&nbsp;OK
					</span>
				</cfif>
				</a>
			</p>
		</td>
	<cfif StructKeyExists(variables.base, "lastDependencyInjectionEngineReloadDateTime")>
		<td>
			<p>
				<a href="#buildUrl("config.reloadBaseAppDependencyInjectionEngine")#">
					<cfif variables.base.shouldReloadDependencyInjectionEngineConfig>
						<span class="red">
							<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
							&nbsp;reloaded #getProperty("udfs").datetimeDifferenceString(variables.base.lastDependencyInjectionEngineReloadDateTime)# ago
						</span>
					<cfelse>
						<span class="green">
							<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
							&nbsp;OK
						</span>
					</cfif>
				</a>
			</p>
		</td>
	<cfelse>
		<td>
			<p>n/a</p>
		</td>
	</cfif>
	</tr>
<cfloop from="1" to="#ArrayLen(variables.moduleOrder)#" index="i">
	<tr <cfif i MOD 2>class="shade"</cfif>>
		<td>
			<h4>#UCase(Left(variables.moduleOrder[i], 1))##Right(variables.moduleOrder[i], Len(variables.moduleOrder[i]) -1)#</h4>
		<cfif getAppManager().getModuleName() NEQ variables.moduleOrder[i]>
			<p class="small">
				<a href="#BuildUrlToModule(variables.moduleOrder[i], variables.modules[variables.moduleOrder[i]].appManager.getPropertyManager().getProperty("defaultEvent"))#">
					<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@link_go.png")#" width="16" height="16" alt="Link" />
					go to default event
				</a>
			</p>
		<cfelse>
			<p>&nbsp;</p>
		</cfif>
		</td>
		<td>
			<p>
				<a href="#buildUrl("config.reloadModule", "moduleName=#variables.moduleOrder[i]#")#">
				<cfif variables.modules[variables.moduleOrder[i]].shouldReloadConfig>
					<span class="red">
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
						&nbsp;reloaded #getProperty("udfs").datetimeDifferenceString(variables.modules[variables.moduleOrder[i]].lastReloadDateTime)# ago
					</span>
				<cfelse>
					<span class="green">
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
						&nbsp;OK
					</span>
				</cfif>
				</a>
			</p>
		</td>
	<cfif StructKeyExists(variables.modules[variables.moduleOrder[i]], "lastDependencyInjectionEngineReloadDateTime")>
		<td>
			<p>
				<a href="#buildUrl("config.reloadModuleDependencyInjectionEngine", "moduleName=#variables.moduleOrder[i]#")#">
					<cfif variables.modules[variables.moduleOrder[i]].shouldReloadDependencyInjectionEngineConfig>
						<span class="red">
							<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
							&nbsp;reloaded #getProperty("udfs").datetimeDifferenceString(variables.modules[variables.moduleOrder[i]].lastDependencyInjectionEngineReloadDateTime)# ago
						</span>
					<cfelse>
						<span class="green">
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
						&nbsp;OK
						</span>
					</cfif>
				</a>
			</p>
		</td>
	<cfelse>
		<td>
			<p>n/a</p>
		</td>
	</cfif>
	</tr>
</cfloop>
</table>

<h1>Component Status</h1>
<cfif event.getArg("componentReloadAvailable")>
<ul class="pageNavTabs">
	<li>
		<a href="#buildUrl("config.reloadAllChangedComponents")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@database_refresh.png")#" width="16" height="16" alt="Reload" />
			&nbsp;Reload All Changed Components
		</a>
	</li>
	<li>
		<a href="#BuildUrl("config.index")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@arrow_rotate_clockwise.png")#" width="16" height="16" alt="Flush All" />
			&nbsp;Refresh Stats
		</a>
	</li>
</ul>

<cfset variables.baseComponentData = event.getArg("baseComponentData") />

<h2 style="margin:1em 0 1em 0;">Base</h2>
<table>
	<tr>
		<th style="width:25%;"><h3>Listeners (#ArrayLen(variables.baseComponentData.listeners)#)</h3></th>
		<th style="width:25%;"><h3>Event-Filters (#ArrayLen(variables.baseComponentData.filters)#)</h3></th>
		<th style="width:25%;"><h3>Plugins (#ArrayLen(variables.baseComponentData.plugins)#)</h3></th>
		<th style="width:25%;"><h3>Configurable Properties (#ArrayLen(variables.baseComponentData.properties)#)</h3></th>
	</tr>
	<tr>
		<td style="padding:0;">
			<cfloop from="1" to="#ArrayLen(variables.baseComponentData.listeners)#" index="i">
			<table>
				<tr <cfif i MOD 2>class="shade"</cfif>>
					<td>
						<p><a href="#buildUrl("config.reloadListener", "listenerName=#variables.baseComponentData.listeners[i].name#")#">
						<cfif variables.baseComponentData.listeners[i].shouldReloadObject>
							<span class="red">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
								&nbsp;#variables.baseComponentData.listeners[i].name#
							</span>
						<cfelse>
							<span class="green">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
								&nbsp;#variables.baseComponentData.listeners[i].name#
							</span>
						</cfif>
						</a></p>
					</td>
				</tr>
			</table>
			</cfloop>
		</td>
		<td style="padding:0;">
			<cfloop from="1" to="#ArrayLen(variables.baseComponentData.filters)#" index="i">
			<table>
				<tr <cfif i MOD 2>class="shade"</cfif>>
					<td>
						<p><a href="#buildUrl("config.reloadFilter", "filterName=#variables.baseComponentData.filters[i].name#")#">
						<cfif variables.baseComponentData.filters[i].shouldReloadObject>
							<span class="red">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
								&nbsp;#variables.baseComponentData.filters[i].name#
							</span>
						<cfelse>
							<span class="green">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
								&nbsp;#variables.baseComponentData.filters[i].name#
							</span>
						</cfif>
						</a></p>
					</td>
				</tr>
			</table>
			</cfloop>
		</td>
		<td style="padding:0;">
			<cfloop from="1" to="#ArrayLen(variables.baseComponentData.plugins)#" index="i">
			<table>
				<tr <cfif i MOD 2>class="shade"</cfif>>
					<td>
						<p><a href="#buildUrl("config.reloadPlugin", "pluginName=#variables.baseComponentData.plugins[i].name#")#">
						<cfif variables.baseComponentData.plugins[i].shouldReloadObject>
							<span class="red">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
								&nbsp;#variables.baseComponentData.plugins[i].name#
							</span>
						<cfelse>
							<span class="green">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
								&nbsp;#variables.baseComponentData.plugins[i].name#
							</span>
						</cfif>
						</a></p>
					</td>
				</tr>
			</table>
			</cfloop>
		</td>
		<td style="padding:0;">
			<cfloop from="1" to="#ArrayLen(variables.baseComponentData.properties)#" index="i">
			<table>
				<tr <cfif i MOD 2>class="shade"</cfif>>
					<td>
						<p><a href="#buildUrl("config.reloadProperty", "propertyName=#variables.baseComponentData.properties[i].name#")#">
						<cfif variables.baseComponentData.properties[i].shouldReloadObject>
							<span class="red">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
								&nbsp;#variables.baseComponentData.properties[i].name#
							</span>
						<cfelse>
							<span class="green">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
								&nbsp;#variables.baseComponentData.properties[i].name#
							</span>
						</cfif>
						</a></p>
					</td>
				</tr>
			</table>
			</cfloop>
		</td>
	</tr>
</table>

<cfset variables.moduleComponentData = event.getArg("moduleComponentData") />

<cfloop from="1" to="#ArrayLen(variables.moduleOrder)#" index="j">
<h2 style="margin:1em 0 1em 0;">#UCase(Left(variables.moduleOrder[j], 1))##Right(variables.moduleOrder[j], Len(variables.moduleOrder[j]) -1)#</h2>
<table>
	<tr>
		<th style="width:25%;"><h3>Listeners (#ArrayLen(variables.moduleComponentData[variables.moduleOrder[j]].listeners)#)</h3></th>
		<th style="width:25%;"><h3>Event-Filters (#ArrayLen(variables.moduleComponentData[variables.moduleOrder[j]].filters)#)</h3></th>
		<th style="width:25%;"><h3>Plugins (#ArrayLen(variables.moduleComponentData[variables.moduleOrder[j]].plugins)#)</h3></th>
		<th style="width:25%;"><h3>Configurable Properties (#ArrayLen(variables.moduleComponentData[variables.moduleOrder[j]].properties)#)</h3></th>
	</tr>
	<tr>
		<td style="padding:0;">
			<cfloop from="1" to="#ArrayLen(variables.moduleComponentData[variables.moduleOrder[j]].listeners)#" index="i">
			<table>
				<tr <cfif i MOD 2>class="shade"</cfif>>
					<td>
						<p><a href="#buildUrl("config.reloadListener", "listenerName=#variables.moduleComponentData[variables.moduleOrder[j]].listeners[i].name#|moduleName=#variables.moduleOrder[j]#")#">
						<cfif variables.moduleComponentData[variables.moduleOrder[j]].listeners[i].shouldReloadObject>
							<span class="red">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
								&nbsp;#variables.moduleComponentData[variables.moduleOrder[j]].listeners[i].name#
							</span>
						<cfelse>
							<span class="green">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
								&nbsp;#variables.moduleComponentData[variables.moduleOrder[j]].listeners[i].name#
							</span>
						</cfif>
						</a></p>
					</td>
				</tr>
			</table>
			</cfloop>
		</td>
		<td style="padding:0;">
			<cfloop from="1" to="#ArrayLen(variables.moduleComponentData[variables.moduleOrder[j]].filters)#" index="i">
			<table>
				<tr <cfif i MOD 2>class="shade"</cfif>>
					<td>
						<p><a href="#buildUrl("config.reloadFilter", "filterName=#variables.moduleComponentData[variables.moduleOrder[j]].filters[i].name#|moduleName=#variables.moduleOrder[j]#")#">
						<cfif variables.moduleComponentData[variables.moduleOrder[j]].filters[i].shouldReloadObject>
							<span class="red">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
								&nbsp;#variables.moduleComponentData[variables.moduleOrder[j]].filters[i].name#
							</span>
						<cfelse>
							<span class="green">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
								&nbsp;#variables.moduleComponentData[variables.moduleOrder[j]].filters[i].name#
							</span>
						</cfif>
						</a></p>
					</td>
				</tr>
			</table>
			</cfloop>
		</td>
		<td style="padding:0;">
			<cfloop from="1" to="#ArrayLen(variables.moduleComponentData[variables.moduleOrder[j]].plugins)#" index="i">
			<table>
				<tr <cfif i MOD 2>class="shade"</cfif>>
					<td>
						<p><a href="#buildUrl("config.reloadPlugin", "pluginName=#variables.moduleComponentData[variables.moduleOrder[j]].plugins[i].name#|moduleName=#variables.moduleOrder[j]#")#">
						<cfif variables.moduleComponentData[variables.moduleOrder[j]].plugins[i].shouldReloadObject>
							<span class="red">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
								&nbsp;#variables.moduleComponentData[variables.moduleOrder[j]].plugins[i].name#
							</span>
						<cfelse>
							<span class="green">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
								&nbsp;#variables.moduleComponentData[variables.moduleOrder[j]].plugins[i].name#
							</span>
						</cfif>
						</a></p>
					</td>
				</tr>
			</table>
			</cfloop>
		</td>
		<td style="padding:0;">
			<cfloop from="1" to="#ArrayLen(variables.moduleComponentData[variables.moduleOrder[j]].properties)#" index="i">
			<table>
				<tr <cfif i MOD 2>class="shade"</cfif>>
					<td>
						<p><a href="#buildUrl("config.reloadProperty", "propertyName=#variables.moduleComponentData[variables.moduleOrder[j]].properties[i].name#|moduleName=#variables.moduleOrder[j]#")#">
						<cfif variables.moduleComponentData[variables.moduleOrder[j]].properties[i].shouldReloadObject>
							<span class="red">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#" width="16" height="16" alt="Reload" />
								&nbsp;#variables.moduleComponentData[variables.moduleOrder[j]].properties[i].name#
							</span>
						<cfelse>
							<span class="green">
								<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#" width="16" height="16" alt="OK" />
								&nbsp;#variables.moduleComponentData[variables.moduleOrder[j]].properties[i].name#
							</span>
						</cfif>
						</a></p>
					</td>
				</tr>
			</table>
			</cfloop>
		</td>
	</tr>
</table>
</cfloop>
<cfelse>
<div class="error">
	<p>Individual reloading of components is not available on this version of Mach-II. Use Mach-II 1.8.0 or higher to enable this feature.</p>
</div>
</cfif>
</cfoutput>