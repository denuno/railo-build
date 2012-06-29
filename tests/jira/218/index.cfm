<cfsetting showdebugoutput="no">

<cfset q = queryNew("c") />

<cfset structKeyExists(q, "c")>


<cf_valueEquals left="#structKeyExists(q, "c")#" right="#true#">
<cf_valueEquals left="#isDefined("q.c")#" right="#true#">