component entityName="Author" persistent="true" accessors="true" table="author1495" {

	property name="authorID" filedtype="id" generator="uuid";
	property name="authorFirstName";
	property name="authorLastName";
	
	property name="books" singularname="book" cfc="Book" fieldtype="one-to-many" inverse="true" cascade="all-delete-orphan";
	
	public any function init() {
		if(isNull(variables.books)) {
			variables.books = [];
		}
		return this;
	}
	
	/******* Association management methods for bidirectional relationships **************/
	
	// Books (one-to-many)
	public void function addBook(required Book book) {
	   arguments.book.setAuthor(this);
	}
	
	public void function removeBook(required Book book) {
	   arguments.book.removeAuthor(this);
	}
	
	
}