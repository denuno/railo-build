<cfsetting showdebugoutput="no">

<!--- cfmodule must throw missing include exception --->
<cftry>
	<cfmodule template="file-doesnt-exist.cfm">
	<cfcatch>
    	<cf_valueEquals left="#cfcatch.type#" right="MissingInclude">
	</cfcatch>
</cftry>

<!--- cfinclude must throw missing include exception --->
<cftry>
	<cfinclude template="file-doesnt-exist.cfm">
	<cfcatch>
    	<cf_valueEquals left="#cfcatch.type#" right="MissingInclude">
	</cfcatch>
</cftry>

<!--- MissingInclude must extend Template --->
<cfset type="">
<cftry>
	<cfinclude template="file-doesnt-exist.cfm">
	<cfcatch type="Template"> 
    	<cfset type="Template">
	</cfcatch>
</cftry>
<cf_valueEquals left="#type#" right="Template">

<!--- cferror must throw missing include exception --->
<cftry>
	<cferror type="exception" exception="any" template="file-doesnt-exist.cfm">
	<cfcatch>
    	<cf_valueEquals left="#cfcatch.type#" right="MissingInclude">
	</cfcatch>
</cftry>