
component entityname="SlatwallAttributeValue" table="SlatwallAttributeValue1365" persistent="true" output="false" accessors="true" discriminatorcolumn="attributeValueType" extends="BaseEntity" {
	
	// Persistant Properties
	property name="attributeValueID" ormtype="string" length="32" fieldtype="id" generator="uuid" unsavedvalue="" default="";
	property name="attributeValue" ormtype="string" length="4000";
	
	
}
