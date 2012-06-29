<cfsetting showdebugoutput="no">

<cfscript>
q=queryNew("a,b,c");
QueryColumnExists(q,"");



</cfscript>


<cf_valueEquals left="#StructKeyExists(q,"")#" right="false">
<cfif server.ColdFusion.ProductName EQ "Railo">
<cf_valueEquals left="#QueryColumnExists(q,"")#" right="false">
</cfif>