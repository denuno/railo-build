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
<cfset variables.loggers = event.getArg("loggers") />
</cfsilent>
<cfoutput>
<dashboard:displayMessage />

<h1>Logging</h1>

<cfif StructCount(variables.loggers) GT 0>
<ul class="pageNavTabs">
 	<li class="green">
		<a href="#BuildUrl("logging.enableDisableAll", "mode=enable")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@accept.png")#" width="16" height="16" alt="Enabled" />
			&nbsp;Enable All
		</a>
	</li>
	<li class="red">
		<a href="#BuildUrl("logging.enableDisableAll", "mode=disable")#">
			<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@stop.png")#" width="16" height="16" alt="Disabled" />
			&nbsp;Disable All
		</a>
	</li>
</ul>


<cfloop collection="#variables.loggers#" item="module">
	<h2 style="margin:1em 0 1em 0;">#module#</h2>
	<table>
		<tr>
			<th style="width:70%;"><h3>Name / Configuration</h3></th>
			<th style="width:15%;"><h3>Level</h3></th>
			<th style="width:15%;"><h3>Status</h3></th>
		</tr>
	<cfset count = 0 />
	<cfloop collection="#variables.loggers[module]#" item="loggerName">
		<cfset logger = variables.loggers[module][loggerName] />
		<cfset configData = logger.getConfigurationData() />
		<cfset count = count + 1 />
		<tr <cfif count MOD 2>class="shade"</cfif>>
			<cfset loggerType = logger.getLoggerType() />
			<td>
				<h4>#loggerName#</h4>
				<p class="small">
				<cfif listGetAt(loggerType, 1, ".") eq "MachII">
					<a href="#getProperty("udfs").getCFCDocUrl(loggerType)#" target="_blank">
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@link_go.png")#" width="16" height="16" alt="Link" />
						#logger.getLoggerTypeName()# (#loggerType#)
					</a>
				<cfelse>
					#logger.getLoggerTypeName()# (#loggerType#)
				</cfif>
				</p>
				
				<cfif StructCount(configData)>
					<hr />
					<table class="small">
					<cfloop collection="#configData#" item="propName">
						<cfif NOT listFindNoCase("type,generatedScopeKey,adapter", propName)>
							<tr>
								<td style="width:35%;"><h4>#propName#</h4></td>
								<td style="width:65%;">
								<cfset propValue = configdata[propName] />
								<cfif IsSimpleValue(propValue)>
									<cfif Len(propValue)>
										<p>#propValue#</p>
									<cfelse>
										<p>&nbsp;</p>
									</cfif>
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
			<cfif logger.getLogAdapter().isFilterDefined()>
				<cfset filter = logger.getLogAdapter().getFilter() />
				<cfset filterType = filter.getFilterType() />
				<h4>Filter</h4>
				<p class="small">
				<cfif listGetAt(filterType, 1, ".") eq "MachII">
					<a href="#getProperty("udfs").getCFCDocUrl(filterType)#" target="_blank">
						<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@link_go.png")#" width="16" height="16" alt="Link" /> 
						#filter.getFilterTypeName()# (#filterType#)
					</a>
				<cfelse>
					#filter.getFilterTypeName()# (#filterType#)
				</cfif>
				</p>
				
				<cfset filterCriteria = filter.getFilterCriteria() />
				<hr />
				<cfif IsArray(filterCriteria) AND ArrayLen(filterCriteria)>
					<ul class="small">
					<cfloop from="1" to="#ArrayLen(filterCriteria)#" index="i">
						<li>#filterCriteria[i]#</li>
					</cfloop>
					</ul>
				<cfelseif IsStruct(filterCriteria) AND StructCount(filterCriteria)>
					<table class="small">
					<cfloop collection="#filterCriteria#" item="i">
						<tr>
							<td style="width:35%;"><h4>#i#</h4></td>
							<td style="width:65%;"><p>#filterCriteria[i]#</p></td>
						</tr>
					</cfloop>
					</table>
				<cfelse>
					<p class="small"><em>No criteria defined for this filter</em></p>
				</cfif>
			<cfelse>
				<p class="small"><em>No filter defined for this logger</em></p>
			</cfif>
			</td>
			<cfset variables.level = logger.getLoggingLevel() />
			<td>
				<form action="#BuildUrl("logging.changeLoggingLevel")#"
					method="post"
					id="change_level_#module#_#loggerName#">
					<input type="hidden" name="moduleName" value="#module#" />
					<input type="hidden" name="loggerName" value="#loggerName#" />
				<p>
					<select name="level" style="width:8em;" onchange="document.getElementById('change_level_#module#_#loggerName#').submit();">
						<option value="all"  
								<cfif variables.level EQ "all">selected="selected"</cfif>>All</option>
						<option value="trace" class="green"  
								<cfif variables.level EQ "trace">selected="selected"</cfif>>Trace</option>
						<option value="debug" class="green"  
								<cfif variables.level EQ "debug">selected="selected"</cfif>>Debug</option>
						<option value="info"  
								<cfif variables.level EQ "info">selected="selected"</cfif>>Info</option>
						<option value="warn"  
								<cfif variables.level EQ "warn">selected="selected"</cfif>>Warn</option>
						<option value="error" class="red"  
								<cfif variables.level EQ "error">selected="selected"</cfif>>Error</option>
						<option value="fatal" class="red"  
								<cfif variables.level EQ "fatal">selected="selected"</cfif>>Fatal</option>
						<option value="off"  
								<cfif variables.level EQ "off">selected="selected"</cfif>>Off</option>
					</select>
				</p>
				</form>
			</td>
			<td>
				<ul class="none">
				<cfif logger.isLoggingEnabled()>
					<li class="green">
						<a href="#BuildUrl("logging.enableDisableLogger", "moduleName=#module#|loggerName=#loggerName#|mode=disable")#" title="Click to Disable">
							<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@accept.png")#" width="16" height="16" alt="Enabled" />
							&nbsp;Enabled
						</a>
					</li>
				<cfelse>
					<li class="red">
						<a href="#BuildUrl("logging.enableDisableLogger", "moduleName=#module#|loggerName=#loggerName#|mode=enable")#" title="Click to Enable">
							<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@stop.png")#" width="16" height="16" alt="Disabled" />
							&nbsp;Disabled
						</a>
					</li>
				</cfif>
				</ul>				
			</td>
		</tr>	
	</cfloop>
	</table>
</cfloop>
<cfelse>
<h4>There are no loggers defined for this application.</h4>
</cfif>
</cfoutput>