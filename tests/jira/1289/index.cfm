<cftry>
	<cfinclude template="lineNumber.cfm">
	<cfcatch>
		<cf_valueEquals left="#arrayLen(cfcatch.TagContext)#" right="3">
		<cf_valueEquals left="#cfcatch.TagContext[1].line#" right="18">
		<cf_valueEquals left="#cfcatch.TagContext[2].line#" right="7">
		<cf_valueEquals left="#cfcatch.TagContext[3].line#" right="3">
    </cfcatch>
</cftry>
