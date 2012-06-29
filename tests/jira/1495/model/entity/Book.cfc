component entityName="Book" persistent="true" accessors="true" extends="BookBase" table="book1495" {

	property name="bookID" filedtype="id" generator="uuid";
	property name="bookName";
	
	property name="author" fieldtype="many-to-one" fkcolumn="authorID" cfc="Author";
	
	
	
	/******* Association management methods for bidirectional relationships **************/
	
	// Author (many-to-one)
	public void function setAuthor(required Author author) {
	   variables.author = arguments.author;
	   if(getBookID() == "" || !arguments.author.hasBook(this)) {
	       arrayAppend(arguments.author.getBooks(),this);
	   }
	}
	
	public void function removeAuthor(required Author author) {
       var index = arrayFind(arguments.author.getBooks(),this);
       if(index > 0) {
           arrayDeleteAt(arguments.author.getBooks(),index);
       }    
       structDelete(variables,"author");
    }
    
    /*
    public void function setDefaultAuthor() {
    	super.setDefaultAuthor();
    }
	*/
    
    
}