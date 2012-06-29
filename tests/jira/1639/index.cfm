<cfset book = entityNew("Book") />
	<cfset book.setBookName("Test Book Name: #now()#") />
	<cfset entitySave(book) />
	<cfset ormFlush() />
    
	<cf_valueEquals left="#book.getbookAuto()#" right="Book Auto Set: #now()#">
	<cf_valueEquals left="#book.getbookName()#" right="Test Book Name: #now()#">    