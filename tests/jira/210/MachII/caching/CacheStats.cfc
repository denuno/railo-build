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
Author: Kurt Wiersma (kurt@mach-ii.com)
$Id: CacheStats.cfc 1153 2008-11-14 22:10:18Z peterfarrell $

Created version: 1.6.0
Updated version: 1.6.0

Notes:
Stats on a particular cache's performance may be tracked by a Mach-II provided CFC 
that exposes several metrics. One potential use of these metrics is to display them 
inside a dashboard that can be monitored while the application is running. The metrics 
tracked by Mach-II are as follows:
 
* Cache hits
* Cache misses
* Cache active element count
* Cache total element count
* Cache evictions - number of elements that the cache removed to make room for new elements 
--->
<cfcomponent
	displayname="CacheStats"
	output="false"
	hint="Holds cache stats for a concrete strategy.">

	<!---
	PROPERTIES
	--->
	<cfset variables.extraStats = structNew() />
	<cfset variables.cacheHits = 0 />
	<cfset variables.cacheMisses = 0 />
	<cfset variables.activeElements = 0 />
	<cfset variables.totalElements = 0 />
	<cfset variables.evictions = 0 />
	<cfset variables.statsActiveSince = Now() />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="CacheStats" output="false"
		hint="Initializes the stats.">
		<cfreturn this />
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->	
	<cffunction name="reset" access="public" returntype="void" output="false"
		hint="Resets all the standard caching stats.">
		<cfset setCacheHits(0) />
		<cfset setCacheMisses(0) />
		<cfset setEvictions(0) />
		<cfset setTotalElements(0) />
		<cfset setActiveElements(0) />
		<cfset setStatsActiveSince(Now()) />
	</cffunction>

	<cffunction name="setExtraStat" access="public" returntype="void" output="false"
		hint="Sets an extra stats value by stat name.">
		<cfargument name="statName" type="string" required="true" />
		<cfargument name="statValue" type="any" required="true" />
		<cfset variables.extraStats[statName] = statValue />
	</cffunction>
	<cffunction name="getExtraStats" access="public" returntype="struct" output="false"
		hint="Gets the extra stats which must be a key of this struct.">
		<cfreturn variables.extraStats />
	</cffunction>
	
	<cffunction name="getCacheHitRatio" access="public" returntype="numeric" output="false"
		hint="Gets the hit ratio (decimal) which is (hits / total accesses) where total accesses is hits + misses.">
		
		<cfset var hits = getCacheHits() />
		<cfset var totalAccesses = hits + getCacheMisses() />
		
		<!--- Ensure that we are not dividing anything with a 0 --->
		<cfif hits AND totalAccesses>
			<cfreturn hits / totalAccesses />
		<cfelse>
			<cfreturn 0 />
		</cfif>
	</cffunction>
	
	<!---
	ACCESSORS
	--->
	<cffunction name="incrementCacheHits" access="public" returntype="void" output="false"
		hint="Increments the number of hits by the default of 1 or by the amount passed.">
		<cfargument name="amount" type="numeric" required="false" default="1" />
		<cfset variables.cacheHits = variables.cacheHits + arguments.amount />
	</cffunction>
	<cffunction name="setCacheHits" access="public" returntype="void" output="false">
		<cfargument name="cacheHits" type="numeric" required="true" />
		<cfset variables.cacheHits = arguments.cacheHits />
	</cffunction>
	<cffunction name="getCacheHits" access="public" returntype="numeric" output="false">
		<cfreturn variables.cacheHits />
	</cffunction>

	<cffunction name="incrementCacheMisses" access="public" returntype="void" output="false">
		<cfargument name="amount" type="numeric" required="false" default="1" />
		<cfset variables.cacheMisses = variables.cacheMisses + arguments.amount />
	</cffunction>
	<cffunction name="decrementCacheMisses" access="public" returntype="void" output="false">
		<cfargument name="amount" type="numeric" required="false" default="1" />
		<cfset variables.cacheMisses = variables.cacheMisses - arguments.amount />
	</cffunction>
	<cffunction name="setCacheMisses" access="public" returntype="void" output="false">
		<cfargument name="cacheMisses" type="numeric" required="true" />
		<cfset variables.cacheMisses = arguments.cacheMisses />
	</cffunction>
	<cffunction name="getCacheMisses" access="public" returntype="numeric" output="false">
		<cfreturn variables.cacheMisses />
	</cffunction>
	
	<cffunction name="incrementEvictions" access="public" returntype="void" output="false">
		<cfargument name="amount" type="numeric" required="false" default="1" />
		<cfset variables.evictions = variables.evictions + arguments.amount />
	</cffunction>
	<cffunction name="setEvictions" access="public" returntype="void" output="false">
		<cfargument name="evictions" type="numeric" required="true" />
		<cfset variables.evictions = arguments.evictions />
	</cffunction>
	<cffunction name="getEvictions" access="public" returntype="numeric" output="false">
		<cfreturn variables.evictions />
	</cffunction>
	
	<cffunction name="incrementTotalElements" access="public" returntype="void" output="false">
		<cfargument name="amount" type="numeric" required="false" default="1" />
		<cfset variables.totalElements = variables.totalElements + arguments.amount />
	</cffunction>
	<cffunction name="decrementTotalElements" access="public" returntype="void" output="false">
		<cfargument name="amount" type="numeric" required="false" default="1" />
		<cfset variables.totalElements = variables.totalElements - arguments.amount />
	</cffunction>
	<cffunction name="setTotalElements" access="public" returntype="void" output="false">
		<cfargument name="totalElements" type="numeric" required="true" />
		<cfset variables.totalElements = arguments.totalElements />
	</cffunction>
	<cffunction name="getTotalElements" access="public" returntype="numeric" output="false">
		<cfreturn variables.totalElements />
	</cffunction>
	
	<cffunction name="incrementActiveElements" access="public" returntype="void" output="false">
		<cfargument name="amount" type="numeric" required="false" default="1" />
		<cfset variables.activeElements = variables.activeElements + arguments.amount />
	</cffunction>
	<cffunction name="decrementActiveElements" access="public" returntype="void" output="false">
		<cfargument name="amount" type="numeric" required="false" default="1" />
		<cfset variables.activeElements = variables.activeElements - arguments.amount />
	</cffunction>
	<cffunction name="setActiveElements" access="public" returntype="void" output="false">
		<cfargument name="activeElements" type="numeric" required="true" />
		<cfset variables.activeElements = arguments.activeElements />
	</cffunction>
	<cffunction name="getActiveElements" access="public" returntype="numeric" output="false">
		<cfreturn variables.activeElements />
	</cffunction>
	
	<cffunction name="setStatsActiveSince" access="public" returntype="void" output="false">
		<cfargument name="statsActiveSince" type="date" required="true" />
		<cfset variables.statsActiveSince = arguments.statsActiveSince />
	</cffunction>
	<cffunction name="getStatsActiveSince" access="public" returntype="date" output="false">
		<cfreturn variables.statsActiveSince />
	</cffunction>

</cfcomponent>