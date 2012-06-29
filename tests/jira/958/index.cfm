<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>


<cfscript> 
function testFunction(argument1='something' myannotation='something', string arg2 susi="sorglos") { 
	return 'something';
}
meta=getMetaData(testFunction);
valueEquals(meta.parameters[1].MYANNOTATION,'something'); 
valueEquals(meta.parameters[2].susi,'sorglos'); 
valueEquals(meta.parameters[2].name,'arg2'); 
valueEquals(meta.parameters[2].type,'string'); 

</cfscript>