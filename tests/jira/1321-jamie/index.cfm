<cfscript>
	entities = entityLoad( 'Entity1321' );

	for ( entityToDelete in entities )
	{
		transaction
		{
			entityDelete( entityToDelete );
		}
	}

	ormClearSession();

	transaction
	{
		foo1 = entityNew( 'Entity1321' );
		foo1.setID( '1' );
		foo1.setFoo( 'foo1' );
		entitySave( foo1 );
	}

	transaction
	{
		foo2 = entityNew( 'Entity1321' );
		foo2.setID( '2' );
		foo2.setFoo( 'foo2' );
		entitySave( foo2 );
	}

	ormClearSession();
	
	entities1 = entityLoad( 'Entity1321', {}, 'foo' );
	entities2 = entityLoad( 'Entity1321', {}, 'FOO' );
</cfscript>

<cf_valueEquals left="#arrayLen( entities1 )#" right="#arrayLen( entities2 )#">
