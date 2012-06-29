<cfcomponent output="false" extends="TestSuper">
	<cffunction name="test" access="public" returntype="any" output="true">
		<cfset sct.current=1>
        <cfset super.test()>
        
        <cfdump var="#sct#" label="Test">
	</cffunction>
	
</cfcomponent>
