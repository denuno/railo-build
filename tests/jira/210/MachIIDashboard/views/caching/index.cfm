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
$Id: index.cfm 942 2008-08-01 18:36:58Z peterfarrell $

Created version: 1.0.0
Updated version: 1.0.0

Notes:
--->
<cfimport prefix="dashboard" taglib="/MachIIDashboard/customtags" />
<cfset variables.cacheStrategies = event.getArg("cacheStrategies") />
</cfsilent>

<cfoutput>

<dashboard:displayMessage />

<h1>Caching</h1>

<cfif StructCount(variables.cacheStrategies) GT 0>
<ul class="pageNavTabs">
	<li class="green">
		<a href="#BuildUrl("caching.enableDisableAll", "mode=enable")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@accept.png")#" width="16" height="16" alt="Enabled" />
			&nbsp;Enable All
		</a>
	</li> 
	<li class="red">
		<a href="#BuildUrl("caching.enableDisableAll", "mode=disable")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@stop.png")#" width="16" height="16" alt="Disable" />
			&nbsp;Disable All
		</a>
	</li>
	<li>
		<a href="#BuildUrl("caching.reapAll")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@database_refresh.png")#" width="16" height="16" alt="Reap All" />
			&nbsp;Reap All
		</a>
	</li>
	<li>
		<a href="#BuildUrl("caching.flushAll")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@database_delete.png")#" width="16" height="16" alt="Flush All" />
			&nbsp;Flush All
		</a>
	</li>
	<li>
		<a href="#BuildUrl("caching.index")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@arrow_rotate_clockwise.png")#" width="16" height="16" alt="Flush All" />
			&nbsp;Refresh Stats
		</a>
	</li>
</ul>

<cfloop collection="#variables.cacheStrategies#" item="module">
	<cfset strategies = variables.cacheStrategies[module] />
<cfif StructCount(variables.strategies) GT 0>
	<h2 style="margin:1em 0 1em 0;">#module#</h2>
	<table>
	<tr>
		<th style="width:35%;"><h3>Name / Configuration</h3></th>
		<th style="width:50%;"><h3>Stats</h3></th>
		<th style="width:15%;"><h3>Options</h3></th>
	</tr>
	<cfset count = 0 />
	<cfloop collection="#strategies#" item="strategyName">
		<cfset count = count + 1>
		<cfset strategy = cacheStrategies[module][strategyName] />
		<cfset configData = strategy.getConfigurationData() />
		<cfset cacheStats = strategy.getCacheStats() />
		<cfset customStats = cacheStats.getExtraStats() />
		<tr <cfif count MOD 2>class="shade"</cfif>>
			<cfset strategyType = strategy.getStrategyType() />
			<td>
				<h4>#strategyName#</h4>
				<p class="small">
					<cfif listGetAt(strategyType, 1, ".") eq "MachII">
						<a href="#getProperty("udfs").getCFCDocUrl(strategyType)#" target="_blank">
							<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@link_go.png")#" width="16" height="16" alt="Link" />
							#strategy.getStrategyTypeName()# (#strategyType#)
						</a>
					<cfelse>
						#strategy.getStrategyTypeName()# (#strategyType#)
					</cfif>
				</p>
				
				<cfif StructCount(configData)>
					<hr />
					<table class="small">
					<cfloop collection="#variables.configData#" item="propName">
						<cfif NOT listFindNoCase("type,scopeKey", propName)>
							<tr>
								<td style="width:35%;"><h4>#propName#</h4></td>
								<td style="width:65%;">
								<cfset propValue = variables.configData[propName] />
								<cfif IsSimpleValue(propValue)>
									<p>#propValue#</p>
								<cfelse>
									<p><em>[complex value]</em></p>
								</cfif>
								</td>							
							</tr>
						</cfif>
					</cfloop>
					</table>
				</cfif>
				<hr />
				<table class="small">
					<tr>
						<td style="width:35%;"><h4>Hit Radio</h4></td>
						<td style="width:65%;"><p>#getProperty("udfs").decimalRound(cacheStats.getCacheHitRatio() * 100, 2)#%</p></td>
					</tr>
					<tr>
						<td><h4>Hits</h4></td>
						<td><p>#cacheStats.getCacheHits()#</p></td>
					</tr>
					<tr>
						<td><h4>Misses</h4></td>
						<td><p>#cacheStats.getCacheMisses()#</p></td>
					</tr>
					<tr>
						<td><h4>Active Elements</h4></td>
						<td><p>#cacheStats.getActiveElements()#</p></td>
					</tr>
					<tr>
						<td><h4>Total Elements</h4></td>
						<td><p>#cacheStats.getTotalElements()#</p></td>
					</tr>
					<tr>
						<td><h4>Evictions</h4></td>
						<td><p>#cacheStats.getEvictions()#</p></td>
					</tr>
				</table>

				<cfif StructCount(customStats)>
					<hr />
					<table class="small">
						<cfloop collection="#customStats#" item="customStatName">
							<tr>
								<td style="width:35%;"><h4>#customStatName#</h4></td>
								<td style="width:65%;"><p>#customStats[customStatName]#</p></td>
							</tr>
						</cfloop>
					</table>
				</cfif>
			</td>
			<td>
				<cfif count MOD 2>
					<cfset backgroundColor ="##F5F5F5" />
				<cfelse>
					<cfset backgroundColor ="##FFFFFF" />
				</cfif>
				
				<p><cfchart format="png" 
					backgroundColor="#backgroundColor#"
					chartWidth="450"
					chartHeight="300"
					show3D="true" 
					tipstyle="none" 
					fontsize="10" 
					title="Stats Active for #getProperty("udfs").datetimeDifferenceString(cacheStats.getStatsActiveSince())#">
					<cfchartseries type="bar" 
						colorList="green,red,blue,yellow,aqua"
						paintstyle="light">
						<cfchartdata item="Hits" value="#cacheStats.getCacheHits()#" />
						<cfchartdata item="Misses" value="#cacheStats.getCacheMisses()#" />
						<cfchartdata item="Active Elements" value="#cacheStats.getActiveElements()#" />
						<cfchartdata item="Total Elements" value="#cacheStats.getTotalElements()#" />
						<cfchartdata item="Evictions" value="#cacheStats.getEvictions()#" />
					</cfchartseries>
				</cfchart></p>			
			</td>
			<td>
				<ul class="none">
				<cfif strategy.isCacheEnabled()>
					<li class="green">
						<a href="#BuildUrl("caching.enableDisableCacheStrategy", "moduleName=#module#|strategyName=#strategyName#|mode=disable")#" title="Click to Disable">
							<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@accept.png")#" width="16" height="16" alt="Enabled" />
							&nbsp;Enabled
						</a>
					</li>
				<cfelse>
					<li class="red">
						<a href="#BuildUrl("caching.enableDisableCacheStrategy", "moduleName=#module#|strategyName=#strategyName#|mode=enable")#" title="Click to Enable">
							<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@stop.png")#" width="16" height="16" alt="Disable" />
							&nbsp;Disabled
						</a>
					</li>
				</cfif>
					<li>
						<a href="#BuildUrl("caching.reapCacheStrategy", "moduleName=#module#|strategyName=#strategyName#")#">
							<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@database_refresh.png")#" width="16" height="16" alt="Reap" />
							&nbsp;Reap
						</a>
					</li>
					<li>
						<a href="#BuildUrl("caching.flushCacheStrategy", "moduleName=#module#|strategyName=#strategyName#")#">
							<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@database_delete.png")#" width="16" height="16" alt="Flush" />
							&nbsp;Flush
						</a>
					</li>
				</ul>
			</td>
		</tr>
	</cfloop>
	</table>
</cfif>
</cfloop>
<cfelse>
<h4>There are no cache strategies defined for this application.</h4>
</cfif>
</cfoutput>