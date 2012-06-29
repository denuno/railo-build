<cfscript>
	user = entityNew( 'User' );
	user.setFirstName( 'Bob' );
	user.setLastName( 'Dylan' );
	entitySave( user );

	user2 = entityNew( 'User' );
	user2.setFirstName( 'Bob' );
	user2.setLastName( 'Marley' );
	entitySave( user2 );

	dump( entityLoad( 'User', { 'firstName' = 'Bob' } ) );
</cfscript>
