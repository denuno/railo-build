<cfcomponent><cfscript>

	function init()
	{
		return this;
	}

	function getSingletonInThis() { return this.singletonInThis; }
	function setSingletonInThis( singletonInThis ) { this.singletonInThis = arguments.singletonInThis; }

	function getSingletonInVariables() { return variables.singletonInVariables; }
	function setSingletonInVariables( singletonInVariables ) { variables.singletonInVariables = arguments.singletonInVariables; }

</cfscript></cfcomponent>
