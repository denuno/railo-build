<cfcomponent entityname="User" persistent="true" output="false">

	<cfproperty name="id" fieldtype="id" ormtype="integer" generator="native" />
	<cfproperty name="firstName" />
	<cfproperty name="lastName" />

</cfcomponent>
