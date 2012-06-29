<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>

<cffunction name="sliceTestQuery" output="no">
	<cfargument name="collection" required="yes" type="query">
	<cfloop query="collection">
		<cfif collection.name EQ "testQuery">
            <cfreturn querySlice(collection, collection.currentrow,1)>
        </cfif>
</cfloop>

</cffunction>






<!--- Collection setup --->
<cfcollection action = "list" name="collectionLookUp" />
<cfif NOT ListFindNoCase(ValueList(collectionLookUp.name), "testQuery")>
	<cftry><cfcollection
		action="create"
		collection="testQuery"
		path = "#GetTempDirectory()#/testQuery" />
        <cfcatch></cfcatch>
        </cftry>
</cfif>

<!--- Let's add some records to our collection --->
<cfscript>
	q1 = QueryNew("id,body");
	QueryAddRow(q1);
	QuerySetCell(q1, "id", "a");
	QuerySetCell(q1, "body", "some text for body 1");
	QueryAddRow(q1);
	QuerySetCell(q1, "id", 2);
	QuerySetCell(q1, "body", "some text for body 2");
	
	q2 = QueryNew("id,body");
	QueryAddRow(q2);
	QuerySetCell(q2, "id", 3);
	QuerySetCell(q2, "body", "body 3 text");
	
	q3 = QueryNew("id");
	QueryAddRow(q3);
	QuerySetCell(q3, "id", "a");
	
	
	
</cfscript>
<!--- Here comes Bug 1, I expect Railo to accept here type="query" but it throws: invalid value for attribute type [query]
Will use now type="custom" --->
<cfindex collection = "testQuery" action="update" type="custom" title = "Query 1" key="id" body="id,body" query="q1"/>
<cfindex collection = "testQuery" action="update" type="custom" title = "Query 2" key="id" body="id,body" query="q2" />

<cfif server.ColdFusion.ProductName EQ "Railo">
<cfcollection action = "list" name="collection">
<cfset row=sliceTestQuery(collection)>
<cf_valueEquals left="#row.doccount#" right="3">
</cfif>
<cfsearch name="search" collection="testQuery" criteria="b*" >
<cf_valueEquals left="#search.recordcount#" right="3">


<!--- Ok, now let's delete one key --->
<cfindex collection="testQuery" action="delete" type="custom" key="id" query="q3" />
<cfif server.ColdFusion.ProductName EQ "Railo">
<cfcollection action = "list" name="collection">
<cfset row=sliceTestQuery(collection)>
<cf_valueEquals left="#row.doccount#" right="2">
</cfif>
<cfsearch name="search" collection="testQuery" criteria="b*" >
<cf_valueEquals left="#search.recordcount#" right="2">



<!--- Ok, now let's delete the second of q1 --->
<cfindex collection="testQuery" action="delete" type="custom" key="id" query="q1" />
<cfif server.ColdFusion.ProductName EQ "Railo">
<cfcollection action = "list" name="collection">
<cfset row=sliceTestQuery(collection)>
<cf_valueEquals left="#row.doccount#" right="1">
</cfif>
<cfsearch name="search" collection="testQuery" criteria="b*" >
<cf_valueEquals left="#search.recordcount#" right="1">






<cf_valueEquals left="" right="">