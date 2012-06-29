<cfprocessingdirective pageEncoding="utf-8" />
<cfsetting showdebugoutput="no">

<!--- Collection setup --->
<cfcollection action = "list" name="collectionLookUp" />
<cfif NOT ListFindNoCase(ValueList(collectionLookUp.name), "testFile")>
	<cftry><cfcollection
		action="create"
		collection="testFile"
		path = "#GetTempDirectory()#/testFile" /><cfcatch></cfcatch></cftry>
</cfif>

<!--- Let's add some records to our collection --->
<cfset l1 = "http://www.yandex.ru/" />
<cfset l2 = "http://www.lenta.ru/" />
<cfindex collection = "testFile" action = "update" type = "file" key = "#l1#" URLpath = "#l1#" extensions = ".*" />
<cfindex collection = "testFile" action = "update" type = "file" key = "#l2#" URLpath = "#l2#" extensions = ".*" />

<cfcollection action = "list" name="collection">

<cfsearch name="search" collection="testFile" criteria="*" >
<cf_valueEquals left="#search.recordcount#" right="2">

<!--- Ok, now let's delete one key --->
<cfindex collection = "testFile" action = "delete" type = "file" key = "#l1#" />

<cfcollection action = "list" name="collection">
<cfsearch name="search" collection="testFile" criteria="*" >
<cf_valueEquals left="#search.recordcount#" right="1">

<cfsearch 
	name = 'result'
	collection = 'testFile'
	contextPassages = '1'
	criteria = '*' />
	