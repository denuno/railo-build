<cfsetting enablecfoutputonly="true">
<cfif thistag.ExecutionMode IS "start">
	<cfscript>
		tagList = getBaseTagList();
	</cfscript>
<cfelse>
	<cfscript>
	thistag.generatedContent = tagList;
	</cfscript>
</cfif>
<cfsetting enablecfoutputonly="false">