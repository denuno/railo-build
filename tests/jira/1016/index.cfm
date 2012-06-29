<cfscript>
ormReload();

// remove previous entites
entities=entityLoad("Foo1016");
size=arrayLen(entities);
for(i=1;i<=size;i++){
	entityDelete(entities[i]);
}
ormFlush();


id=createUUID();
transaction {
	foo = entityNew("Foo1016");//new Foo1016();
	foo.setId(id );
	foo.setFoo( id);

	entitySave( foo );
}
entity=entityLoadByPK("Foo1016",id);


</cfscript>


<cfquery datasource="#request.datasource#" name="foos">
	select * from Foo1016 where id='#id#'
</cfquery>


<cf_valueEquals left="#entity.getId()#" right="#id#">
<cf_valueEquals left="#foos.recordcount#" right="1">
<cf_valueEquals left="#foos.id#" right="#id#">