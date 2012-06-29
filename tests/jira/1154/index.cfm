<cfsetting showdebugoutput="no">

<!--- Collection setup --->
<cfcollection action = "list" name="collectionLookUp" />
<cfif NOT ListFindNoCase(ValueList(collectionLookUp.name), "c1154")>
	<cfcollection
		action="create"
		collection="c1154"
		path = "#GetTempDirectory()#/testCustom" />
</cfif>

<cfindex collection = "c1154" action = "update" type = "file" key = "suchmaschtest.cfm"/>

<cfsearch name="search" collection="c1154" criteria="*" >
<cf_valueEquals left="#search.recordcount#" right="1">
<cf_valueEquals left="#search.title#" right="Titel">



<cfdump var="#search#">

<cfindex collection = "c1154" action = "delete" type = "file" key = "suchmaschtest.cfm"/>


<cfsearch name="search" collection="c1154" criteria="*" >
<cf_valueEquals left="#search.recordcount#" right="0">
