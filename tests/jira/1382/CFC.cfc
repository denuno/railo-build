<cfcomponent>
	<cffunction name="test" output="false" returntype="boolean">
		<cfargument name="arg1" type="any" required="true" />
		<cfargument name="arg2" type="any" required="true" />
		<cfset var local = duplicate(Arguments) />
		<cfdump var="#Arguments#" />
		<cfdump var="#local#" />
		<cfabort />
		<cfreturn TRUE />
	</cffunction>
</cfcomponent>