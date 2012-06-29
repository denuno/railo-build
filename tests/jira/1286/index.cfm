<cfsetting showdebugoutput="no">
<cfset entity=Entitynew("Entity1286")>
<cfset entity.setTitle("Susi")>
<cfset cfc=new Entity1286()>
<cfset cfc.setTitle("Susanne")>
<cfset cfc2=new CFC1286()>



<cf_valueEquals left="#serializeJson(entity)#" right='{"A":"1","title":"Susi"}'>
<cf_valueEquals left="#serializeJson(cfc2)#" right='{"A":"1"}'>
<cf_valueEquals left="#serializeJson(cfc)#" right='{"A":"1","title":"Susanne"}'>
<cfset entitySave(entity)>
<cfset ormFlush()>
<cfset entity=entityLoad("Entity1286")>


<cf_valueEquals left="#serializeJson(entity[1])#" right='{"A":"1","id":1,"title":"Susi"}'>