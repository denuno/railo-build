<cfscript>
	entities = entityLoad( 'Entity1312' );

	for(entityToDelete in entities){
		transaction {
			entityDelete( entityToDelete );
		}
	}

	transaction {
		foo1 = entityNew( 'Entity1312' );
		foo1.setID( '1' );
		foo1.setFoo( 'foo1' );
		entitySave( foo1 );
	}
	ormClearSession();
	
	foo2 = entityLoadByPK( 'Entity1312', '1' );
	

</cfscript>

<cf_valueEquals left="#foo2.getId()#" right="1">
<cf_valueEquals left="#foo2.getFoo()#" right="foo1">



<cfdbinfo type="columns" name="Entity" table="E1312" datasource="railo_mirror" pattern="id">
<cf_valueEquals left="#Entity.type_name#" right="VARCHAR">

<cfdbinfo type="columns" name="Entity" table="E1312" datasource="railo_mirror" pattern="foo">
<cf_valueEquals left="#Entity.type_name#" right="CHAR">
