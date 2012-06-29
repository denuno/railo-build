<cf_valueEquals left="#caller.local.a#" right="AA">

<cfset caller.local.a="AAA">
<cfset caller.local.b="BBB">
<cfset setVariable("caller.local.c","CCC")>

<cf_valueEquals left="#caller.local.a#" right="AAA">
<cf_valueEquals left="#caller.local.b#" right="BBB">
<cf_valueEquals left="#caller.local.c#" right="CCC">