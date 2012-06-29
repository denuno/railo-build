<cfsetting showdebugoutput="no" requesttimeout="10000">

<cfset ds="railo_mirror">
<!--- Create User --->
<cftry>
	<cfquery datasource="#ds#">
        select * from User1127
    </cfquery>
    <cfcatch>
    <cfquery datasource="#ds#">
        CREATE TABLE User1127 (
            id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
            data VARCHAR(100)
        )
    </cfquery>
    </cfcatch>
</cftry>


<cfset attr.type="columns">
<cfset attr.datasource="#ds#">
<cfset attr.name="data">
<cfset attr.table="User1127">
<cfset attr.pattern="id">
<cfdbinfo  attributeCollection="#attr#">