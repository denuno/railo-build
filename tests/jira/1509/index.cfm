<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>




<cfscript>
test="";
a1="\,,(";
a2="\,,";

// this line works even though the above strings are the same as the string below.
test=replacelist(test, a1,a2);

// this line dies with "Java heap space" - you must comment this out for the script to execute successfully.
test=replacelist(test, "\,,(",",,_");
</cfscript>







<cf_valueEquals left="" right="">