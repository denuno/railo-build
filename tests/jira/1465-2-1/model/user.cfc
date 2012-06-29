<cfcomponent persistent="true" table="user1465" entityname="user">

	<cfproperty name="id"
				fieldtype="id"
				type="numeric"
				ormtype="int"
				generator="identity">
				
	<cfproperty name="name"
				type="string">	
	
	<cfproperty name="datecreated"
				fieldtype="column"
				type="date"
				ormtype="timestamp"
				setter="true">
	
	<cfproperty name="dateupdated"
				fieldtype="column"
				type="date"
				ormtype="timestamp"
				setter="true">

	<cfproperty name="group" fieldtype="many-to-one" cfc="group" fkcolumn="groupId" inverse="true" type="struct">
	
	
	<cffunction name="preInsert" access="public" returntype="void" output="false" hint="Bevor der Eintrag gespeichert wird">
		
		<cfset this.setDateCreated(Now())>
		
		<cfreturn />
	</cffunction>
	
	  
	<cffunction name="preUpdate" access="public"  returntype="void" output="false" hint="Bevor der Eintrag aktuallisiert wird">
		<cfargument name="oldData" type="struct" />
		
		<!--- Comment out this line and everything works like expected --->
		<cfset this.setDateUpdated(Now())>
		
		<cfreturn />
	</cffunction>
	
	
</cfcomponent>