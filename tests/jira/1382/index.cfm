<cfsetting showdebugoutput="no">


<cfset Variables.com = createObject("component", "CFC") />
<cfset Variables.result = Variables.com.test(arg1="test", arg2=2) />

<cf_valueEquals left="" right="">