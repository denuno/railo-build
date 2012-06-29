<cfcomponent>

<!--- Test Method --->
<cffunction name="testRemote" access="remote" returnFormat="json" returntype="any">

<!--- Initiating Variable --->
<cfset local.returnVar = structNew() />
<cfset local.returnVar.value = "susi" />

<!--- Returning --->
<cfreturn local.returnVar />
</cffunction>

</cfcomponent>