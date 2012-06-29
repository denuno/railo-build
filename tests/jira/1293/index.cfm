<cfsetting showdebugoutput="no">


<cfset str="28 Mar 2011 06:29:35+01:00">
<cf_valueEquals left="#dateFormat(parseDateTime(str),"yyyy-mm-dd","UTC")#" right="2011-03-28">
<cf_valueEquals left="#timeFormat(parseDateTime(str),"hh:mm:ss","UTC")#" right="07:29:35">
<cfset str="28 Mar 2011 06:29:35-01:00">
<cf_valueEquals left="#dateFormat(parseDateTime(str),"yyyy-mm-dd","UTC")#" right="2011-03-28">
<cf_valueEquals left="#timeFormat(parseDateTime(str),"hh:mm:ss","UTC")#" right="05:29:35">

<cfset str="28 Mar 2011 06:29:35+1:00">
<cf_valueEquals left="#dateFormat(parseDateTime(str),"yyyy-mm-dd","UTC")#" right="2011-03-28">
<cf_valueEquals left="#timeFormat(parseDateTime(str),"hh:mm:ss","UTC")#" right="07:29:35">
<cfset str="28 Mar 2011 06:29:35-1:00">
<cf_valueEquals left="#dateFormat(parseDateTime(str),"yyyy-mm-dd","UTC")#" right="2011-03-28">
<cf_valueEquals left="#timeFormat(parseDateTime(str),"hh:mm:ss","UTC")#" right="05:29:35">

<cfset str="28 Mar 2011 06:29:35+01">
<cf_valueEquals left="#dateFormat(parseDateTime(str),"yyyy-mm-dd","UTC")#" right="2011-03-28">
<cf_valueEquals left="#timeFormat(parseDateTime(str),"hh:mm:ss","UTC")#" right="07:29:35">
<cfset str="28 Mar 2011 06:29:35-01">
<cf_valueEquals left="#dateFormat(parseDateTime(str),"yyyy-mm-dd","UTC")#" right="2011-03-28">
<cf_valueEquals left="#timeFormat(parseDateTime(str),"hh:mm:ss","UTC")#" right="05:29:35">

<cfset str="28 Mar 2011 06:29:35+1">
<cf_valueEquals left="#dateFormat(parseDateTime(str),"yyyy-mm-dd","UTC")#" right="2011-03-28">
<cf_valueEquals left="#timeFormat(parseDateTime(str),"hh:mm:ss","UTC")#" right="07:29:35">
<cfset str="28 Mar 2011 06:29:35-1">
<cf_valueEquals left="#dateFormat(parseDateTime(str),"yyyy-mm-dd","UTC")#" right="2011-03-28">
<cf_valueEquals left="#timeFormat(parseDateTime(str),"hh:mm:ss","UTC")#" right="05:29:35">

<cfset str="28 Mar 2011 06:29:35+0100">
<cf_valueEquals left="#dateFormat(parseDateTime(str),"yyyy-mm-dd","UTC")#" right="2011-03-28">
<cf_valueEquals left="#timeFormat(parseDateTime(str),"hh:mm:ss","UTC")#" right="07:29:35">
<cfset str="28 Mar 2011 06:29:35-0100">
<cf_valueEquals left="#dateFormat(parseDateTime(str),"yyyy-mm-dd","UTC")#" right="2011-03-28">
<cf_valueEquals left="#timeFormat(parseDateTime(str),"hh:mm:ss","UTC")#" right="05:29:35">

<cfset str="28 Mar 2011 06:29:35+100">
<cf_valueEquals left="#dateFormat(parseDateTime(str),"yyyy-mm-dd","UTC")#" right="2011-03-28">
<cf_valueEquals left="#timeFormat(parseDateTime(str),"hh:mm:ss","UTC")#" right="07:29:35">
<cfset str="28 Mar 2011 06:29:35-100">
<cf_valueEquals left="#dateFormat(parseDateTime(str),"yyyy-mm-dd","UTC")#" right="2011-03-28">
<cf_valueEquals left="#timeFormat(parseDateTime(str),"hh:mm:ss","UTC")#" right="05:29:35">