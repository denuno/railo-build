
<cfset cfc=createObject('component','TestInvoke')>
<cf_valueEquals left="# cfc.a()#" right="i">
<cf_valueEquals left="# cfc.b()#" right="ioo2o">