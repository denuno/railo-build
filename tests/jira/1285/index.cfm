<cfsetting showdebugoutput="no">

<cfset data = {}>
<cfsavecontent variable="data.CONTENT">x</cfsavecontent>
<cf_valueEquals left="#structKeyList(data)#" right="CONTENT" cs="true">

<cfset data = {}>
<cfsavecontent variable="data.content">x</cfsavecontent>
<cf_valueEquals left="#structKeyList(data)#" right="content" cs="true">

<cfset data = {}>
<cfsavecontent variable="data.ConTenT">x</cfsavecontent>
<cf_valueEquals left="#structKeyList(data)#" right="ConTenT" cs="true">

<cfset data = {}>
<cfset setVariable("data.CONTENT",1)>
<cf_valueEquals left="#structKeyList(data)#" right="CONTENT" cs="true">

<cfset data = {}>
<cfset setVariable("data.content",1)>
<cf_valueEquals left="#structKeyList(data)#" right="content" cs="true">

<cfset data = {}>
<cfset setVariable("data.ConTenT",1)>
<cf_valueEquals left="#structKeyList(data)#" right="ConTenT" cs="true">


<cfdump var="#queryNew("a","nvarchar")#">

