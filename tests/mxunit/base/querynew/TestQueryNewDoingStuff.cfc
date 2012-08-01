<cfcomponent extends="mxunit.framework.TestCase">

	<cffunction name="testJira570" returntype="void" access="public">
		<!--- A --->
		<cfset qry=queryNew('a')>
		<cfset QueryAddRow(qry)>
		<cfset QuerySetCell(qry,"a",CreateDateTime(2009,11,1,1,1,1))>

		<cfquery dbtype="query" name="qry2">
			    SELECT
			        *
			    FROM
			        qry
			    WHERE
			        a BETWEEN {ts '2009-10-01 00:00:00'} AND {ts '2009-12-31 23:59:00'}
		</cfquery>
		<cfset assertEquals("#qry2.recordcount#","1")>

		<cfquery dbtype="query" name="qry2">
			    SELECT
			        *
			    FROM
			        qry
			    WHERE
			        a BETWEEN {ts '2009-11-01 00:00:00'} AND {ts '2009-11-01 23:59:00'}
		</cfquery>
		<cfset assertEquals("#qry2.recordcount#","1")>

		<cfquery dbtype="query" name="qry2">

			    SELECT
			        *
			    FROM
			        qry
			    WHERE
			        a BETWEEN {ts '2009-11-02 00:00:00'} AND {ts '2009-12-31 23:59:00'}
		</cfquery>
		<cfset assertEquals("#qry2.recordcount#","0")>

		<cfquery dbtype="query" name="qry2">

			    SELECT
			        *
			    FROM
			        qry
			    WHERE
			        a BETWEEN {d '2009-10-01'} AND {d '2009-12-31'}
		</cfquery>
		<cfset assertEquals("#qry2.recordcount#","1")>
		<!--- B --->
		<cfset qry=queryNew('a')>
		<cfset QueryAddRow(qry)>
		<cfset QuerySetCell(qry,"a","Hello")>

		<cfquery dbtype="query" name="qry2">

			    SELECT
			        *
			    FROM
			        qry
			    WHERE
			        CAST(UPPER(a) AS VARCHAR) LIKE
  			<cfqueryparam cfsqltype="cf_sql_varchar" value="%ELL%">
		</cfquery>
		<cfset assertEquals("#qry2.recordcount#","1")>
	</cffunction>

</cfcomponent>
