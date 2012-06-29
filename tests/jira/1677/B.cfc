<cfcomponent extends="A">
<cffunction name="write" access="public" returntype="any" output="yes">
<!--- <cfreturn super.write()> Works --->
<cfreturn redirect(super.write)> <!--- Unable to render embedded object: File (--- Infinite Loop) not found. --->
</cffunction>

<cffunction name="redirect" access="private" returntype="any" output="no">
<cfargument name="F" required="yes" hint="callback function">
<cfreturn F()>
</cffunction>
</cfcomponent>