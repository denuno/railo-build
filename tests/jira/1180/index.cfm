<cfsetting showdebugoutput="no">

<cfset name="c1180">

<cfcollection action = "list" name="collectionLookUp" />
<cfif NOT ListFindNoCase(ValueList(collectionLookUp.name), name)>
	<cfcollection
		action="create"
		collection="#name#"
		path = "#GetTempDirectory()#/#name#" />
</cfif>

<cfindex action="purge" collection="#name#">
<cfscript>

	i=1;
	testQuery = queryNew('key,body,title,something');
	queryAddRow(testQuery);
	querySetCell(testQuery, 'key', i);
	querySetCell(testQuery, 'body', 'Testing: ' & i);
	querySetCell(testQuery, 'title', 'Testing' & i);
	querySetCell(testQuery, 'something', 'http://localhost/my/url/' & i);
		
		
	i=2;
	testQuery2 = queryNew('key,body,title,something');
	queryAddRow(testQuery2);
	querySetCell(testQuery2, 'key', i);
	querySetCell(testQuery2, 'body', 'Testing: ' & i);
	querySetCell(testQuery2, 'title', 'Testing' & i);
	querySetCell(testQuery2, 'something', 'http://localhost/my/url/' & i);
		
		
		
		
		
</cfscript>

<cfindex action="update" collection="#name#" type="custom" query="testQuery" key="key" body="body" title="title" urlPath="something">
<cfindex action="update" collection="#name#" type="custom" query="testQuery2" key="key" body="body" title="title" urlPath="omething">
<cfsearch collection="#name#" criteria="*" name="results">

<cfloop query="results">
	<cfif results.title EQ "Testing1">
    	<cf_valueEquals left="#results.url#" right="http://localhost/my/url/1">
    <cfelse>
    	<cf_valueEquals left="#results.url#" right="omething">
    </cfif>
</cfloop>