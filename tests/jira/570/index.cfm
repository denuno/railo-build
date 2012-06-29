<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>



<!--- A --->
<cfset qry=queryNew('a')>
<cfset QueryAddRow(qry)>
<cfset QuerySetCell(qry,"a",CreateDateTime(2009,11,1,1,1,1))>



<cfquery dbtype="query" name="qry2">
select * from qry
where a BETWEEN {ts '2009-10-01 00:00:00'} AND {ts '2009-12-31 23:59:00'}
</cfquery>
<cf_valueEquals left="#qry2.recordcount#" right="1">

<cfquery dbtype="query" name="qry2">
select * from qry
where a BETWEEN {ts '2009-11-01 00:00:00'} AND {ts '2009-11-01 23:59:00'}
</cfquery>
<cf_valueEquals left="#qry2.recordcount#" right="1">


<cfquery dbtype="query" name="qry2">
select * from qry
where a BETWEEN {ts '2009-11-02 00:00:00'} AND {ts '2009-12-31 23:59:00'}
</cfquery>
<cf_valueEquals left="#qry2.recordcount#" right="0">



<cfquery dbtype="query" name="qry2">
select * from qry
where a BETWEEN {d '2009-10-01'} AND {d '2009-12-31'}
</cfquery>
<cf_valueEquals left="#qry2.recordcount#" right="1">


<!--- B --->
<cfset qry=queryNew('a')>
<cfset QueryAddRow(qry)>
<cfset QuerySetCell(qry,"a","Hello")>


<cfquery dbtype="query" name="qry2">
select * from qry
where CAST(UPPER(a) as VARCHAR) LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%ELL%">
</cfquery>
<cf_valueEquals left="#qry2.recordcount#" right="1">