<cfcomponent persistent="true">
    <cfproperty name="itemid" fieldtype="id" generator="increment">
    <cfproperty name="a">

    <cfproperty name="collection" fieldtype="many-to-one" fkcolumn="collectionid" cfc="Collection981" missingRowIgnored="true">
</cfcomponent>