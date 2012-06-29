<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>

<cfscript>
dz=entityNew("DeliveryZone");
dz.setTitle("Thun");


country = entityNew("Country");
country.setCode("ch");
country.setDeliveryZone(dz);

entitySave(dz);
entitySave(country);
ormFlush();
	

foo = ORMExecuteQuery( "from DeliveryZone" );
id=foo[1].getDeliveryZoneID();


bar = ORMExecuteQuery( "from Country c where c.DeliveryZone.deliveryzoneid = #id#" );

bar = ORMExecuteQuery( "from Country c where c.DeliveryZone.deliveryzoneid = ?", [id] );

bar = ORMExecuteQuery( "from Country c where c.DeliveryZone.deliveryzoneid = :zoo", {zoo:id} );

bar = ORMExecuteQuery( "from Country c where c.DeliveryZone = :zoo", {zoo:foo[1]} );

//writedump(bar);


</cfscript>
	



<cf_valueEquals left="" right="">