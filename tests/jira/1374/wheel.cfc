<cfcomponent persistent="true" optimisticlock="none" table="wheel1374" entityname="wheel">

	<cfproperty name="id"
				fieldtype="id"
				type="numeric"
				ormtype="int"
				setter="false"
				hint="Id"
				generator="identity">

	<cfproperty name="car" cfc="car" fieldtype="many-to-one" inverse="true" fkcolumn="caridfk" type="struct">

	
</cfcomponent>