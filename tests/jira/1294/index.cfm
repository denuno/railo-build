<cfsetting showdebugoutput="no">
<cfset date=CreateDateTime(2000,1,2,3,4,5,0,"UTC")>
<cfset setTimeZone("UTC")>
<cf_valueEquals left="#datepart('h', date)#" right="3">
<cfset setTimeZone("CET")>
<cf_valueEquals left="#datepart('h', date)#" right="4">

<cf_valueEquals left="#datepart('h', date, 'australia/Perth')#" right="11">
<cf_valueEquals left="#datepart('h', date, 'europe/amsterdam')#" right="4">
<cf_valueEquals left="#datepart('h', date, 'america/new_york')#" right="22">
