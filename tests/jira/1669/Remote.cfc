<cfcomponent hint="" output="false">

<!------------------------------------------- PUBLIC ------------------------------------------->

<cffunction name="sayHello" hint="" access="remote" returntype="string" output="true">
	<cfargument name="str" hint="" type="string" required="no">

	<cfscript>
		var hello = createObject("component", "Hello").init();
		return hello.sayHello(argumentCollection=arguments);
	</cfscript>
</cffunction>

<!------------------------------------------- PACKAGE ------------------------------------------->

<!------------------------------------------- PRIVATE ------------------------------------------->

</cfcomponent>