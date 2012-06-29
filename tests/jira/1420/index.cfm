<cfsetting showdebugoutput="no">

<cfloop from="1" to="10" index="i">
<cffile action="touch" file="_MenuInclude.cfm">
<cfinclude template="_MenuInclude.cfm">
</cfloop>