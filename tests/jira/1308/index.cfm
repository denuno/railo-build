<cfsetting showdebugoutput="no">
<cfscript>

	class1 = new MyClass();	
	class2 = new MyClass().deserialize(class1.serialize());
	class3 = Duplicate(class2);
	class3.getField1() ;
	
	class4 = new MySubClass();	
	class5 = new MySubClass().deserialize(class4.serialize());
	class6 = Duplicate(class5);
	class6.getField1() ;
	class6.susi() ;
</cfscript>

<cf_valueEquals left="#listSort(structKeyList(class3),'text')#" right="DESERIALIZE,FIELD1,GETFIELD1,INIT,SERIALIZE,SETFIELD1">
<cf_valueEquals left="#listSort(structKeyList(class6),'text')#" right="DESERIALIZE,FIELD1,GETFIELD1,INIT,SERIALIZE,SETFIELD1,SUSI">
