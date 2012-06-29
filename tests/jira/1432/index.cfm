<cfsetting showdebugoutput="no">




<cfsetting requesttimeout="100">
<cfset names="">
<cfloop from="1" to="10" index="i">
	<cfset name="t"&i>
    <cfset names=ListAppend(names,name)>
    <cfthread name="#name#">
		<cflock name="id" timeout="1">
        	<cfset sleep(10)>
        </cflock>
 	</cfthread>
 </cfloop>
 
 <cfthread action="join" name="#names#">
 <cfloop collection="#cfthread#" item="key">
 	<cfif cfthread[key].status EQ "TERMINATED"><cfdump var="#cfthread[key]#"></cfif>
 </cfloop>
 

<cf_valueEquals left="" right="">