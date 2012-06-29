<cfcomponent output="false">

	
	<cffunction name="test">
		<cfset  CreateObject("component", "resources.Test")>
		<cfset  CreateObject("component", "resources3.Test3")>
		<cfset  CreateObject("component", "resources2.Test2")>
	</cffunction>
</cfcomponent>