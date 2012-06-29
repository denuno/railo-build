<cfcomponent persistent="true" table="user1465_2" entityname="user">

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
	
	
</cfcomponent>