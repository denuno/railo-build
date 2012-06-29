<cfsetting showdebugoutput="no">


<cffile action="write" addnewline="yes" charset="utf-8" file="small.js" output="abc" fixnewline="no" />
<cffile action="readbinary" file="small.js" charset="utf-8" variable="smallFile" />
<cfcontent type="text/plain" content="#smallFile#" />

