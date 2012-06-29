<cfsetting showdebugoutput="no">

<!--- Collection setup --->
<cfcollection action = "list" name="collectionLookUp" />
<cfif NOT ListFindNoCase(ValueList(collectionLookUp.name), "testCustom")>
	<cfcollection
		action="create"
		collection="testCustom"
		path = "#GetTempDirectory()#/testCustom" />
</cfif>

<!--- Let's add some records to our collection --->
<cfindex collection = "testCustom" action="update" type="custom" title="Custom 1" key="key1" body="some body 1 text" />
<cfindex collection = "testCustom" action="update" type="custom" title="Query 2" key="key2" body="text for body 2"  />

<cfcollection action = "list" name="collection">
<cfsearch name="search" collection="testCustom" criteria="*" >
<cf_valueEquals left="#search.recordcount#" right="2">

<cfindex collection="testCustom" action="delete" type="custom" key="key1" />

<cfcollection action = "list" name="collection">
<cfsearch name="search" collection="testCustom" criteria="*" >
<cf_valueEquals left="#search.recordcount#" right="1">
<cf_valueEquals left="#search.key#" right="key2">
