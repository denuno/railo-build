<cfcomponent>
	<cffunction name="getMockStructFalse" access="public" output="false" returntype="string">
		<cfargument name="key" type="boolean" default="false"/>
		<cfreturn serializeJson(arguments.key)/>
	</cffunction>

	<cffunction name="getMockStructTrue" access="public" output="false" returntype="string">
		<cfargument name="key" type="boolean" default="true"/>
		<cfreturn serializeJson(arguments.key)/>
	</cffunction>

	<cffunction name="getMockStructPoundFalsePound" access="public" output="false" returntype="string">
		<cfargument name="key" type="boolean" default="#false#"/>
		<cfreturn serializeJson(arguments.key)/>
	</cffunction>

	<cffunction name="getMockStructPoundTruePound" access="public" output="false" returntype="string">
		<cfargument name="key" type="boolean" default="#true#"/>
		<cfreturn serializeJson(arguments.key)/>
	</cffunction>
</cfcomponent>