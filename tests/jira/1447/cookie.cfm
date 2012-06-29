<cfsetting showdebugoutput="no">
<cfset key=StructKeyList(cookie)>
<cfset key=ListDeleteAt(key,ListFindNoCase(key,"cfid"))>
<cfset key=ListDeleteAt(key,ListFindNoCase(key,"cftoken"))>

<cfoutput>#key#=#cookie[key]#</cfoutput>