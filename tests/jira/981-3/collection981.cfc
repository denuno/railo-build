<cfcomponent persistent="true">
    <cfproperty name="collectionid" fieldtype="id" generator="increment">
    
    <cfproperty name="item981s" fieldtype="one-to-many" cfc="Item981" singularname="item981" fkcolumn="collectionid" inverse="true" cascade="all-delete-orphan" >
</cfcomponent>