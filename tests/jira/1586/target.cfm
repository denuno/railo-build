<cfsetting showdebugoutput="no">



<cfloop from="1" to="#arrayLen(request.data)#" index="i">
	<cf_valueEquals left="#form["str#i#"]#" right="#request.data[i]#">
</cfloop>
