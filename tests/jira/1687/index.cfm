<cfsetting showdebugoutput="no" requesttimeout="1000">


<!--- name --->
<cflock name="test" timeout="5" type="exclusive">
<cfset variables.myVar = 0>
</cflock>

<cfloop from="1" to="2" index="i">
<cfthread name="test1687#i#" action="run" >
<cfloop from="1" to="500000" index="count2"><cflock name="test" timeout="50" type="exclusive"><cfset variables.myVar++></cflock></cfloop>
</cfthread>
</cfloop>
<cfthread action="join" />

<cflock name="test" timeout="5" type="readonly">
<cf_valueEquals left="#variables.myVar#" right="1000000">
</cflock>

<!--- request --->
<cflock scope="request" timeout="5" type="exclusive">
<cfset variables.myVar = 0>
</cflock>

<cfloop from="1" to="2" index="i">
<cfthread name="request1687#i#" action="run" >
<cfloop from="1" to="500000" index="count2"><cflock scope="request" timeout="50" type="exclusive"><cfset variables.myVar++></cflock></cfloop>
</cfthread>
</cfloop>
<cfthread action="join" />

<cflock scope="request" timeout="5" type="readonly">
<cf_valueEquals left="#variables.myVar#" right="1000000">
</cflock>


<!--- application --->
<cflock scope="application" timeout="5" type="exclusive">
<cfset variables.myVar = 0>
</cflock>

<cfloop from="1" to="2" index="i">
<cfthread name="application1687#i#" action="run" >
<cfloop from="1" to="500000" index="count2"><cflock scope="application" timeout="50" type="exclusive"><cfset variables.myVar++></cflock></cfloop>
</cfthread>
</cfloop>
<cfthread action="join" />

<cflock scope="application" timeout="5" type="readonly">
<cf_valueEquals left="#variables.myVar#" right="1000000">
</cflock>


