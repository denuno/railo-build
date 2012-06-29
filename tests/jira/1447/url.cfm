<cfsetting showdebugoutput="no">
<cfset key=structKeyList(url)>
<cfoutput>#key#=#url[key]#</cfoutput>