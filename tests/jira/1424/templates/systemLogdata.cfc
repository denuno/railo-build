<cfcomponent persistent="true" table="system_logdata_orm" entityname="systemLogdata">

	<cfproperty name="id"
				fieldtype="id"
				type="numeric"
				ormtype="int"
				hint="just a test-field">
				
	<cfproperty name="active"
				type="numeric"
				ormtype="int"
				hint="just a test-field">
	
	<!---
	<cfproperty name="active2"
				type="numeric"
				ormtype="int"
				hint="just a test-field">
	--->

</cfcomponent>