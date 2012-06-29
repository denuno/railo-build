<!--- index.cfm --->
<cfscript>
collection= entityNew("collection981");
item= entityNew("item981");
item.seta(1);
collection.addItem981(item);

writedump(collection);
writedump(item);

EntitySave(collection);
ormFlush();

collection=entityLoad('collection981');
item=entityLoad('item981');


writedump(collection);
writedump(item);


</cfscript>
