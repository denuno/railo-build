<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>
<cf_valueEquals left="" right="">


	<!--- This just ensures that there is at least 1 author in the DB --->
	<cfset author = entityNew("Author") />
    <cfset author.setauthorFirstName("Susi")>
	<cfset entitySave(author) />
    <cfset ormFlush()>
	
    
	<cfset book = entityNew("Book") />
	<cfset book.setBookName("Book 1") />
	<cfset book.setDefaultAuthor() />
	
	<cfset entitySave(book) />
	<cfset ormFlush() />
	