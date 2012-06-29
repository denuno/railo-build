<cfcomponent displayname="Application" output="true" hint="Handle the application.">
 <cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 0, 0, 1 ) />


<cffunction name="onRequest" returntype="void" access="public" output="true">
	<cfargument name="targetpage" type="any" required="true">

	
	
	<cfscript>
	variables.Foo="Hello Railo :)";
	variables.Clone=Duplicate(variables);

	</cfscript>
	
	<cfdump var="#variables#">

	
	
</cffunction>

</cfcomponent>