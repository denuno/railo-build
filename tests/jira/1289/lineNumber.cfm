<cfset test = {}>
<cfset test['node1'] = "line 2">
<cfset test['node2'] = "line 3">
<cfset test['node3'] = "line 4">

<cfset test['good'] = goodMethod()>
<cfset test['error'] = genError()>

<cfdump var="#test#" label="line: 7" abort>

<!--- === genError ============================= --->
<cffunction name = "genError"
access = "public"
returntype = "numeric"
output = "no">

<cfset var y = 50>
<cfset var x = y/0>

<cfreturn x>
</cffunction>

<!--- === goodMethod ============================= --->
<cffunction name = "goodMethod"
access = "public"
returntype = "numeric"
output = "no">

<cfset var y = 50>
<cfset var x = y * 2>

<cfreturn x>
</cffunction>