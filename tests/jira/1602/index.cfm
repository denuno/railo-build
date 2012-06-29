<cfscript>
	param name="url.entity" default="EntityB";

	id = createUUID();

	transaction
	{
		newEntity = entityNew( url.entity );
		newEntity.setID( id );
		newEntity.setFoo( '39.803139' );
		entitySave( newEntity );
	}

	ormClearSession();

	isDirtyBeforeLoad = ormGetSession().isDirty();

	loadedEntity = entityLoadByPK( url.entity, id );

	isDirtyAfterLoad = ormGetSession().isDirty();
</cfscript>

<cf_valueEquals left="#isDirtyBeforeLoad#" right="#isDirtyAfterLoad#" />
