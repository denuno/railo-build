<cfcomponent hint="" output="false">

<!------------------------------------------- PUBLIC ------------------------------------------->

<cffunction name="init" hint="Constructor" access="public" returntype="any" output="false">
	<cfargument name="returnValue" default="#createObject("component", "Bar").init()#">
	<cfif not IsSimpleValue(returnValue) or returnValue NEQ "<nothing>">
    	<cfreturn returnValue>
    </cfif>
    
    
</cffunction>

<!------------------------------------------- PACKAGE ------------------------------------------->

<!------------------------------------------- PRIVATE ------------------------------------------->

</cfcomponent>