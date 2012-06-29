<cfapplication name="context1246" sessionmanagement="yes">
<cfscript>
session[listLast(cgi.SCRIPT_NAME,"/") & ":start"]=true;
</cfscript>