<cfscript>
component persistent="true" accessors="true" table="Book1665" {

	property name="bookID" ormtype="int" fieldtype="id" unsavedvalue="0" generator="increment";
	property name="bookName" ormtype="string";
	property name="bookAuto" ormtype="string";
	
	public void function preInsert() {
		setBookAuto( "Book Auto Set: #now()#" );
	}
	
} 
</cfscript>