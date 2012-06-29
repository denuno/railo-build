<cfcomponent persistent="true" output="false" entityname="User" table="Users1511">
<cfproperty name="id" column="id" fieldtype="id" generator="native" ormtype="integer" update="false" insert="false" />
<cfproperty name="Company" column="company_id" notnull="true" fieldtype="many-to-one" fkcolumn="company_id" ormtype="integer" cfc="Company"/>
</cfcomponent>