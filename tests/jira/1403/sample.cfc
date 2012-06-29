<cfcomponent displayname="sample" output="false"> 
	<cffunction name="init" output="true" access="public"> 
		<cfreturn this> 
	</cffunction> 
	
    <cffunction name="getDateTime" returntype="string" access="public"> 
		<cfreturn now()> 
	</cffunction> 
</cfcomponent> 