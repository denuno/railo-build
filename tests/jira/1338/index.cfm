<cfsetting showdebugoutput="no">

<cfscript>
e=entityNew('E1338');
r1=entityNew('R1338');
r2=entityNew('R1338');


e.addR1(r1);
e.addR2(r2);
r1.setE(e);
r2.setE(e);
entitySave(e);
entitySave(r1);
entitySave(r2);
ormFlush();


e=entityLoad('E1338');




writeDump(e);



</cfscript>




<cf_valueEquals left="" right="">