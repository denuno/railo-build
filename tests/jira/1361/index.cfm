<cfsetting showdebugoutput="no">

<cfset test=expandPath("test.cfm")>
<cffile action="write" file="#test#" output="-#now()#">

<cfset names="">
<cfloop from="1" to="100" index="i"><cfset names&=",test"&i>
	<cfthread name="test#i#">
    	<cfinclude template="test.cfm">
	</cfthread>
</cfloop>


<cfthread action="join" name="#names#">


<cfloop collection="#cfthread#" item="t">
	<cfif cfthread[t].status EQ "TERMINATED">
    	<cfdump var="#cfthread[t]#">
    </cfif>
</cfloop>


<cf_valueEquals left="" right="">