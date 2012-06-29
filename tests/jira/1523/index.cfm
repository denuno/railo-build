<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>

<cfscript>
	// test with simple values
	transient = createObject( 'component', 'Transient' );
	transient.setSingletonInThis( "a" );
	transient.setSingletonInVariables( "a" );
	
	clone=duplicate(transient);
	
	transient.setSingletonInThis( "b" );
	transient.setSingletonInVariables( "b" );
	
	valueEquals(transient.getSingletonInThis(),"b");
	valueEquals(transient.getSingletonInVariables(),"b");
	
	valueEquals(clone.getSingletonInThis(),"a");
	valueEquals(clone.getSingletonInVariables(),"a");
	
	
	
	// test with complex values
	singleton1 = createObject( 'component', 'Singleton' );
	singleton1.setFoo( 'singleton1-foo' );

	singleton2 = createObject( 'component', 'Singleton' );
	singleton2.setFoo( 'singleton2-foo' );

	transient1 = createObject( 'component', 'Transient' );
	transient1.setSingletonInThis( singleton1 );
	transient1.setSingletonInVariables( singleton2 );

	transient2 = createObject( 'component', 'Transient' ).init( singleton1, singleton2 );
	transient2.setSingletonInThis( singleton1 );
	transient2.setSingletonInVariables( singleton2 );

	transient3 = duplicate( transient1 );
	
	
	// before changing foo
	valueEquals(transient1.getSingletonInThis().getFoo(),'singleton1-foo');
	valueEquals(transient1.getSingletonInVariables().getFoo(),'singleton2-foo');
	
	valueEquals(transient2.getSingletonInThis().getFoo(),'singleton1-foo');
	valueEquals(transient2.getSingletonInVariables().getFoo(),'singleton2-foo');
	
	valueEquals(transient3.getSingletonInThis().getFoo(),'singleton1-foo');
	valueEquals(transient3.getSingletonInVariables().getFoo(),'singleton2-foo');
	
	// change singelton
	singleton1.setFoo( 'singleton1-foo_CHANGED' );
	singleton2.setFoo( 'singleton2-foo_CHANGED' );

	
	// after changing foo
	valueEquals(transient1.getSingletonInThis().getFoo(),'singleton1-foo_CHANGED');
	valueEquals(transient1.getSingletonInVariables().getFoo(),'singleton2-foo_CHANGED');
	
	valueEquals(transient2.getSingletonInThis().getFoo(),'singleton1-foo_CHANGED');
	valueEquals(transient2.getSingletonInVariables().getFoo(),'singleton2-foo_CHANGED');
	
	valueEquals(transient3.getSingletonInThis().getFoo(),'singleton1-foo');
	valueEquals(transient3.getSingletonInVariables().getFoo(),'singleton2-foo');
	
</cfscript>
