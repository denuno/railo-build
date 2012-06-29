<cfsetting showdebugoutput="no">
<cfset headers=GetHTTPRequestData().headers>
<cfoutput>#headers.aaa#=#headers[headers.aaa]#</cfoutput>