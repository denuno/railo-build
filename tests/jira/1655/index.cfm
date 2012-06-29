<cfsetting showdebugoutput="no">

<cffunction name="publicFunction" hint="I am public" access="public" returntype="string" output="false">
	<cfreturn "public" />
</cffunction>

<cffunction name="privateFunction" hint="I am private" access="private" returntype="string" output="false">
	<cfreturn "private" />
</cffunction>


<cffunction name="test">
	<cfargument name="cfc" type="component">
    <cf_valueEquals left="#structKeyExists(cfc,"publicFunction")#" right="true">
	<cf_valueEquals left="#structKeyExists(cfc,"privateFunction")#" right="true">
</cffunction>



<cfscript>
	foo = new Foo();
	foo.publicFunction = publicFunction;
	foo.privateFunction = privateFunction;
	
	test(foo);
	test(duplicate(foo));
	

</cfscript>


<cf_valueEquals left="" right="">