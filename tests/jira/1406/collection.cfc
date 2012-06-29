<cfcomponent persistent="true" table="collection1407">
    <cfproperty name="collectionid" fieldtype="id" generator="increment">
    
    <cfproperty name="items" fieldtype="one-to-many" cfc="Item" singularname="item" fkcolumn="collectionid" inverse="true" cascade="all-delete-orphan" >
</cfcomponent>