<cfsetting showdebugoutput="no">


<cfset keywords="ALL,AND,ANY,AS,AVG,BETWEEN,BOTH,BY,CASE,CAST,CHECK,COALESCE,CONSTRAINT,CONVERT,COUNT,CURRENT_DATE,CURRENT_TIME,CURRENT_TIMESTAMP,CURRENT_USER,DISTINCT,ELSE,END,END-EXEC,EXCEPT,EXISTS,EXTRACT,FOR,FOREIGN,FROM,GROUP,HAVING,IN,INNER,INTERSECT,INTO,IS,JOIN,LEADING,LIKE,MAX,MIN,NEXT,NOT,NULL,NULLIF,ON,OR,ORDER,OUTER,POSITION,PRIMARY,SELECT,SET,SOME,SUBSTRING,SUM,THEN,TO,TRAILING,TRIM,UNION,UNIQUE,VALUES,WHEN,WHERE,FALSE,TRUE">

<cfloop index="keyword" list="#keywords#" >
<cfscript>

xCol="count";
_col = keyword;


qry1 = QueryNew('#xCol#,Name,Type');
QueryAddRow(qry1);
QuerySetCell(qry1, xCol, 10);
QuerySetCell(qry1, 'Name', 'A');
QuerySetCell(qry1, 'Type', 'T1');

QueryAddRow(qry1);
QuerySetCell(qry1, xCol, 20);
QuerySetCell(qry1, 'Name', 'B');
QuerySetCell(qry1, 'Type', 'T1');

QueryAddRow(qry1);
QuerySetCell(qry1, xCol, 30);
QuerySetCell(qry1, 'Name', 'C');
QuerySetCell(qry1, 'Type', 'T2');

QueryAddRow(qry1);
QuerySetCell(qry1, xCol, 20);
QuerySetCell(qry1, 'Name', 'D');
QuerySetCell(qry1, 'Type', 'T3');

QueryAddRow(qry1);
QuerySetCell(qry1, xCol, 50);
QuerySetCell(qry1, 'Name', 'E');
QuerySetCell(qry1, 'Type', 'T2');
</cfscript>

<cfdump var="#qry1#" label="#xCol#">

<cfquery name="qry2" dbtype="query">
SELECT sum(#_col#) as #_col#, Type
FROM qry1
GROUP BY Type
ORDER BY Type desc
</cfquery>

<cfdump var="#qry2#" label="#xCol#">
</cfloop>

<cf_valueEquals left="" right="">