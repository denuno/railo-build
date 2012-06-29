<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>
<cfscript>
meta = getComponentMetadata("MethodBeforeAdvice");

valueEquals(listLast(meta.fullname,'.'),'MethodBeforeAdvice');
valueEquals(listLast(meta.extends.BeforeAdvice.fullname,'.'),'BeforeAdvice');
valueEquals(listLast(meta.extends.BeforeAdvice.extends.Advice.fullname,'.'),'Advice');


meta = getComponentMetadata("test");
valueEquals(listLast(meta.fullname,'.'),'Test');
valueEquals(listLast(meta.IMPLEMENTS.MethodBeforeAdvice.fullname,'.'),'MethodBeforeAdvice');
valueEquals(listLast(meta.IMPLEMENTS.MethodBeforeAdvice.extends.BeforeAdvice.fullname,'.'),'BeforeAdvice');
valueEquals(listLast(meta.IMPLEMENTS.MethodBeforeAdvice.extends.BeforeAdvice.extends.Advice.fullname,'.'),'Advice');



</cfscript>






