<cfcomponent><cfscript>

	function init()
	{
		return this;
	}

	function getFoo() { return variables.foo; }
	function setFoo( foo ) { variables.foo = arguments.foo; }

</cfscript></cfcomponent>
