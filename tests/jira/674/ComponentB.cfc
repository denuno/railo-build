<cfcomponent> 

<cfset variables.name = "brett" /> 

<cffunction name="dumpName"> 

<cfdump var="#variables.name#" /><cfabort> 

</cffunction> 

</cfcomponent> 