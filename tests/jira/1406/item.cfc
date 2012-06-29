<cfcomponent persistent="true" table="item1407">
    <cfproperty name="itemid" fieldtype="id" generator="increment">
    <cfproperty name="a">
 
    <cfproperty name="collection" fieldtype="many-to-one" lazy="true" fkcolumn="collectionid" cfc="Collection" missingRowIgnored="true">
</cfcomponent>