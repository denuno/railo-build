<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
	<cfargument name="msg" required="false" default="">
	<cf_valueEquals left="#left#" right="#right#" message="#msg#">
</cffunction>

<cfscript>

test=new Test();
test.valueEquals=valueEquals;
test.cfargumentTypeBooleanWithDefaultShouldSerializeCorrectly();
</cfscript>


