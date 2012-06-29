<cfscript>
session[listLast(cgi.SCRIPT_NAME,"/") & ":end"]=true;
</cfscript>