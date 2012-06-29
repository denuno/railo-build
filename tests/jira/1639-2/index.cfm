<cfset book = entityNew("Book") />
	<cfset book.setBookName("Test Book Name: #now()#") /><cfset d=now()>
	<cfset entitySave(book) />
	<cfset ormFlush() />
    
	<cf_valueEquals left="#book.getbookAuto()#" right="Book Auto Set: #d#">
	<cf_valueEquals left="#book.getbookName()#" right="Test Book Name: #d#">    
    
    <cfquery name="q"> 
SELECT * FROM Book1665
</cfquery> 
	<cf_valueEquals left="#q.bookAuto#" right="Book Auto Set: #d#">
	<cf_valueEquals left="#q.bookName#" right="Test Book Name: #d#">  
