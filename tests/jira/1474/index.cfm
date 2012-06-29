<cfsetting showdebugoutput="no">

<cftry>
	<cfset test = createObject('component', 'test1')>
    there must be a exception in the line above
	<cfcatch>
        <cf_valueEquals left="#cfcatch.type#" right="Template">
    </cfcatch>
</cftry>

<cftry>
	<cfset test = createObject('component', 'test2')>
    there must be a exception in the line above
	<cfcatch>
        <cf_valueEquals left="#cfcatch.type#" right="Template">
    </cfcatch>
</cftry>

<cfsilent>
<cfset test = createObject('component', 'test3')>
</cfsilent>