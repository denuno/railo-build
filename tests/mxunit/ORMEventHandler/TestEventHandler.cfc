component name="TestEventHandler" extends="mxunit.framework.TestCase" {

	/* TODO: Implement Tests */
	public void function testEventHandler()  {
		foo = new Foo();
		foo.setId( 1 );
		foo.setFoo( 'one' );
		entitySave( foo );
		ormFlush();

		foo.setFoo( 'two' );
		entitySave( foo );
		ormFlush();

		ormClearSession();

		foo = entityLoad( 'Foo', 1, true );

		writeOutput( '#foo.getId()# #foo.getFoo()# <br />' );
		entityDelete( foo );
	}

}