<cfscript>
	singleton1 = createObject( 'component', 'app.duplicate.Singleton' );
	singleton1.setFoo( 'singleton1-foo' );

	singleton2 = createObject( 'component', 'app.duplicate.Singleton' );
	singleton2.setFoo( 'singleton2-foo' );

	transient1 = createObject( 'component', 'app.duplicate.Transient' );
	transient1.setSingletonInThis( singleton1 );
	transient1.setSingletonInVariables( singleton2 );

	transient2 = createObject( 'component', 'app.duplicate.Transient' ).init( singleton1, singleton2 );
	transient2.setSingletonInThis( singleton1 );
	transient2.setSingletonInVariables( singleton2 );

	transient3 = duplicate( transient1 );

	if ( transient1.getSingletonInThis().getFoo() != 'singleton1-foo' )
	{
		writeOutput( 'BEFORE singleton state change, transient1.getSingletonInThis().getFoo(): #transient1.getSingletonInThis().getFoo()#<br />' );
	}

	if ( transient1.getSingletonInVariables().getFoo() != 'singleton2-foo' )
	{
		writeOutput( 'BEFORE singleton state change, transient1.getSingletonInVariables().getFoo(): #transient1.getSingletonInVariables().getFoo()#<br />' );
	}

	if ( transient2.getSingletonInThis().getFoo() != 'singleton1-foo' )
	{
		writeOutput( 'BEFORE singleton state change, transient2.getSingletonInThis().getFoo(): #transient2.getSingletonInThis().getFoo()#<br />' );
	}

	if ( transient2.getSingletonInVariables().getFoo() != 'singleton2-foo' )
	{
		writeOutput( 'BEFORE singleton state change, transient2.getSingletonInVariables().getFoo(): #transient2.getSingletonInVariables().getFoo()#<br />' );
	}

	if ( transient3.getSingletonInThis().getFoo() != 'singleton1-foo' )
	{
		writeOutput( 'BEFORE singleton state change, transient3.getSingletonInThis().getFoo(): #transient3.getSingletonInThis().getFoo()#<br />' );
	}

	if ( transient3.getSingletonInVariables().getFoo() != 'singleton2-foo' )
	{
		writeOutput( 'BEFORE singleton state change, transient3.getSingletonInVariables().getFoo(): #transient3.getSingletonInVariables().getFoo()#<br />' );
	}

	singleton1.setFoo( 'singleton1-foo_CHANGED' );
	singleton2.setFoo( 'singleton2-foo_CHANGED' );

	if ( transient1.getSingletonInThis().getFoo() != 'singleton1-foo_CHANGED' )
	{
		writeOutput( 'AFTER singleton state change, transient1.getSingletonInThis().getFoo(): #transient1.getSingletonInThis().getFoo()#<br />' );
	}

	if ( transient1.getSingletonInVariables().getFoo() != 'singleton2-foo_CHANGED' )
	{
		writeOutput( 'AFTER singleton state change, transient1.getSingletonInVariables().getFoo(): #transient1.getSingletonInVariables().getFoo()#<br />' );
	}

	if ( transient2.getSingletonInThis().getFoo() != 'singleton1-foo_CHANGED' )
	{
		writeOutput( 'AFTER singleton state change, transient2.getSingletonInThis().getFoo(): #transient2.getSingletonInThis().getFoo()#<br />' );
	}

	if ( transient2.getSingletonInVariables().getFoo() != 'singleton2-foo_CHANGED' )
	{
		writeOutput( 'AFTER singleton state change, transient2.getSingletonInVariables().getFoo(): #transient2.getSingletonInVariables().getFoo()#<br />' );
	}

	if ( transient3.getSingletonInThis().getFoo() != 'singleton1-foo' )
	{
		writeOutput( 'AFTER singleton state change, transient3.getSingletonInThis().getFoo(): #transient3.getSingletonInThis().getFoo()#<br />' );
	}

	if ( transient3.getSingletonInVariables().getFoo() != 'singleton2-foo' )
	{
		writeOutput( 'AFTER singleton state change, transient3.getSingletonInVariables().getFoo(): #transient3.getSingletonInVariables().getFoo()#<br />' );
	}
</cfscript>
