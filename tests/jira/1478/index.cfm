<cfsetting showdebugoutput="no">


<cfloop from="1" to="2" index="i">
<cfthread action="run" name="T#i#"></cfthread>
</cfloop>
<cfthread action="join"/>

