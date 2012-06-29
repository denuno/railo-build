<cfsetting showdebugoutput="no">


<cfthread action="run" name="test">
<cfset sleep(100)>
</cfthread>

<cfthread action="join">
<cfset threadJoin()>
