<cfcomponent persistent="true" optimisticlock="none" table="car1374" entityname="car">

	<cfproperty name="id"
				fieldtype="id"
				type="numeric"
				ormtype="int"
				setter="false"
				hint="Id"
				generator="identity">


	<cfproperty name="wheel" cfc="wheel" fieldtype="one-to-many" fkcolumn="caridfk" lazy="true" cascade="all" type="array">
		
	<cffunction name="preInsert" access="public" returntype="void" output="false" hint="Bevor der Eintrag gespeichert wird">
						
		<cfreturn />
	</cffunction>
	
</cfcomponent>