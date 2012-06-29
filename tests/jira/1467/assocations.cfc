component persistent='true' table="laundry4assocations" { 
	property name="ID" fieldtype="id" generator="uuid" length=32;
	property name="Parent" fieldtype="many-to-one" cfc="things" fkcolumn="ParentID" mappedby="ID" notnull=true;
	property name="Child" fieldtype="many-to-one" cfc="things" fkcolumn="ChildID" mappedby="ID" notnull=true;
} 