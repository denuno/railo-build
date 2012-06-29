<cfcomponent persistent="true" table="group1465_2" entityname="group">

	<cfproperty name="id"
				type="numeric">	
	
	<cfproperty name="name"
				type="string">
				
	<cfproperty name="datecreated"
				fieldtype="column"
				type="date"
				ormtype="timestamp"
				setter="true"
				hint="Erstellungsdatum des Datensatz">
	
	<cfproperty name="dateupdated"
				fieldtype="column"
				type="date"
				ormtype="timestamp"
				setter="true"
				hint="Änderungsdatum des Datensatz">

	<cfproperty name="usercreated"
				fieldtype="column"
				type="string"
				ormtype="string"
				setter="true"
				hint="Welcher User hat den Datensatz erstellt">
	
	<cfproperty name="userupdated"
				fieldtype="column"
				type="string"
				ormtype="string"
				setter="true"
				hint="Welcher User hat den Datensatz geändert">

	<cfproperty name="active"
				fieldtype="column"
				type="numeric"
				ormtype="int"
				setter="true"
				hint="Ist der Datensatz aktiv">							

	<cfproperty name="user" fieldtype="one-to-many" cfc="user" cascade="all">


</cfcomponent>