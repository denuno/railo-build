<cfsetting showdebugoutput="no">

<cfinclude template="createEntity.cfm">
<cfset base="http://#cgi.HTTP_HOST##GetDirectoryFromPath(cgi.SCRIPT_NAME)#">



<cffunction name="test">

	<cfhttp url="#base#call.cfm">
        <cfhttpparam type="cookie" name="CFID" value="#session.CFID#">
        <cfhttpparam type="cookie" name="CFToken" value="#session.CFToken#">
    </cfhttp>
</cffunction>





<cfscript>

// delete existing entities
	entities = entityLoad( 'Cart' );
	for ( entityToDelete in entities ) {
		transaction {
			entityDelete( entityToDelete );
		}
	}
	entities = entityLoad( 'CartItem' );
	for ( entityToDelete in entities ) {
		transaction {
			entityDelete( entityToDelete );
		}
	}
	ormFlush();


	entity=getEntities(2);
	test();

	entitySave(entity);
	entitySave( session.entity );
	ormFlush();

</cfscript>


<cf_valueEquals left="" right="">