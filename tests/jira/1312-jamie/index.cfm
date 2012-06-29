<cfscript>
	entities = entityLoad( 'Entity1312' );

	for ( entityToDelete in entities )
	{
		transaction
		{
			entityDelete( entityToDelete );
		}
	}

	transaction
	{
		foo1 = entityNew( 'Entity1312' );
		foo1.setID( '1' );
		foo1.setFoo( 'foo1' );
		entitySave( foo1 );
	}

	ormClearSession();

	foo2 = entityLoadByPK( 'Entity1312', '1' );

	if ( foo1.getFoo() != foo2.getFoo() )
	{
		writeDump( foo1 );
		writeDump( foo2 );
	}
</cfscript>