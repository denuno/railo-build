component displayname="Account Attribute Value" entityname="SlatwallAccountAttributeValue" table="SlatwallAttributeValue1365" output="false" persistent="true" accessors="true" extends="AttributeValue" discriminatorValue="Account" {
	
	property name="attributeValueID" ormtype="string" length="32" fieldtype="id" generator="uuid" unsavedvalue="" default="";
	property name="attributeValueType" insert="false" update="false";
	
}