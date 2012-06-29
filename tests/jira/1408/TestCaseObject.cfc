<cfcomponent>

<!--- Test Method --->
<cffunction name="testMethod" access="public">
<cf_test_case returnVariable="local.returnMe" />
<cfreturn local.returnMe />
</cffunction>

</cfcomponent>