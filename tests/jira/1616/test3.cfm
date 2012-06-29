<cfsetting showdebugoutput="no">


<cffile action="write" addnewline="yes" charset="utf-8" file="small.js" output="abc" fixnewline="no" />
<cfcontent type="text/plain" file="#ExpandPath("small.js")#" reset="yes" />

