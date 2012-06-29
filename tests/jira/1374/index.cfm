<cfsetting showdebugoutput="no">
<cfscript>
local.wheel = entityNew('wheel');
entitySave(local.wheel);	
ormFlush();
writeDump(entityLoad('wheel'));

local.car = entityNew('car');
entitySave(local.car);	
ormFlush();
writeDump(entityLoad('car'));

</cfscript>

<cf_valueEquals left="" right="">