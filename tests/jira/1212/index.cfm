<!--- index.cfm --->
<cfscript>
item= entityNew("item1212");
item.seta(1);


EntitySave(item);
ormFlush();

item=entityLoad('item1212');

item = EntityLoad('item1212', {}, 'a desc'); 
writedump(item);


</cfscript>
