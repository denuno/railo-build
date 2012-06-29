<cfsetting showdebugoutput="no">

<cfimport taglib="./" prefix="ext" />
<cfsavecontent variable="content">
<cfoutput>
	<ext:inc/>
</cfoutput>
</cfsavecontent>
<cf_valueEquals left="#trim(content)#" right="CFINCLUDE,CF_INC,CFOUTPUT,CFSAVECONTENT">