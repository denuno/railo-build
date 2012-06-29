<cfscript>
component persistent="true" table="Bookmark1269" {

	property name="id" column="bookmarkId" fieldtype="id" generator="identity";	
	property name="tags" fieldtype="many-to-many" type="array" CFC="Tag" linktable="BookmarkTag"  persistent='true';	
	

}
</cfscript>