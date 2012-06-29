<cfcomponent >

	
	<cffunction name="preInsert" access="public" returntype="void" output="false" hint="Bevor der Eintrag gespeichert wird">
    	<cfargument name="cfc" required="yes" type="component">
		<cfset arguments.cfc.setDateCreated(Now())>
		
		<cfreturn />
	</cffunction>
	
	  
	<cffunction name="preUpdate" access="public"  returntype="void" output="false" hint="Bevor der Eintrag aktuallisiert wird">
		<cfargument name="cfc" required="yes" type="component">
		<cfargument name="oldData" type="struct" />
		<cfset arguments.cfc.setDateUpdated(Now())>
		
		<cfreturn />
	</cffunction>
	
	
</cfcomponent>