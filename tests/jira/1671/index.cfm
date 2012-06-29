<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>

<cfscript>
	bar = createObject("component", "Bar").init();
	foo = createObject("component", "Foo").init();

	valueEquals(listLast(getMetaData(bar).name,'.'),'Bar');
	valueEquals(listLast(getMetaData(foo).name,'.'),'Bar');

	valueEquals(listLast(getMetaData(new Bar()).name,'.'),'Bar');
	valueEquals(listLast(getMetaData(new Foo()).name,'.'),'Bar');
	
	// simple values
	valueEquals(new Foo(""),'');
	
	// return nothing
	valueEquals(listLast(getMetaData(new Foo("<nothing>")).name,'.'),'Foo');
</cfscript>



