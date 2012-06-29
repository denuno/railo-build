<cfcomponent persistent="true" output="false" entityname="Company" table="Company1511">
<cfproperty name="id" column="id" fieldtype="id" generator="native" ormtype="integer" update="false" insert="false" />
<cfproperty name="Users" singularname="User" fieldtype="one-to-many" cfc="User" type="array" cascade="all" inverse="true" />
</cfcomponent>