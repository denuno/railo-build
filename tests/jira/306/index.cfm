<cfsetting showdebugoutput="no" requesttimeout="10000">

<cfset ds="railo_mirror">
<!--- Create User --->
<cftry>
	<cfquery datasource="#ds#">
        select * from User306
    </cfquery>
    <cfcatch>
    <cfquery datasource="#ds#">
        CREATE TABLE User306 (
            id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
            data VARCHAR(100) 
        )TYPE=innodb;
    </cfquery>
    </cfcatch>
</cftry>


<!--- Create Order --->
<cftry>
	<cfquery datasource="#ds#">
        select * from Order306
    </cfquery>
    <cfcatch>
    <cfquery datasource="#ds#">
        CREATE TABLE Order306 (
            id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
            data VARCHAR(100) , 
            User_id INT , 
            
            Foreign Key (User_id) references User306(id)
        )TYPE=innodb;
    </cfquery>
    </cfcatch>
</cftry>


<cfquery datasource="#ds#" name="user">
    select * from User306
</cfquery>
<cfquery datasource="#ds#" name="order">
    select * from Order306
</cfquery>




<cfdbinfo type="columns" datasource="#ds#" name="data" table="Order306" pattern="User_id">
<cf_valueEquals left="#data.COLUMN_NAME#" right="User_id">
<cf_valueEquals left="#data.COLUMN_SIZE#" right="10">
<cf_valueEquals left="#data.DECIMAL_DIGITS#" right="0">
<cf_valueEquals left="#data.IS_FOREIGNKEY#" right="#true#">
<cf_valueEquals left="#data.IS_NULLABLE#" right="#true#">
<cf_valueEquals left="#data.IS_PRIMARYKEY#" right="#false#">
<cf_valueEquals left="#data.ORDINAL_POSITION#" right="3">
<cf_valueEquals left="#data.REFERENCED_PRIMARYKEY#" right="id">
<cf_valueEquals left="#data.REFERENCED_PRIMARYKEY_TABLE#" right="User306">
<cf_valueEquals left="#data.REMARKS#" right="">
<cf_valueEquals left="#data.TYPE_NAME#" right="INT">


<cfdbinfo type="columns" datasource="#ds#" name="data" table="Order306" pattern="id">
<cf_valueEquals left="#data.COLUMN_NAME#" right="id">
<cf_valueEquals left="#data.COLUMN_SIZE#" right="10">
<cf_valueEquals left="#data.DECIMAL_DIGITS#" right="0">
<cf_valueEquals left="#data.IS_FOREIGNKEY#" right="#false#">
<cf_valueEquals left="#data.IS_NULLABLE#" right="#false#">
<cf_valueEquals left="#data.IS_PRIMARYKEY#" right="#true#">
<cf_valueEquals left="#data.ORDINAL_POSITION#" right="1">
<cf_valueEquals left="#data.REFERENCED_PRIMARYKEY#" right="N/A">
<cf_valueEquals left="#data.REFERENCED_PRIMARYKEY_TABLE#" right="N/A">
<cf_valueEquals left="#data.REMARKS#" right="">
<cf_valueEquals left="#data.TYPE_NAME#" right="INT">

<cfdbinfo type="columns" datasource="#ds#" name="data" table="Order306" pattern="data">
<cf_valueEquals left="#data.COLUMN_NAME#" right="data">
<cf_valueEquals left="#data.COLUMN_SIZE#" right="100">
<cf_valueEquals left="#data.DECIMAL_DIGITS#" right="0">
<cf_valueEquals left="#data.IS_FOREIGNKEY#" right="#false#">
<cf_valueEquals left="#data.IS_NULLABLE#" right="#true#">
<cf_valueEquals left="#data.IS_PRIMARYKEY#" right="#false#">
<cf_valueEquals left="#data.ORDINAL_POSITION#" right="2">
<cf_valueEquals left="#data.REFERENCED_PRIMARYKEY#" right="N/A">
<cf_valueEquals left="#data.REFERENCED_PRIMARYKEY_TABLE#" right="N/A">
<cf_valueEquals left="#data.REMARKS#" right="">
<cf_valueEquals left="#data.TYPE_NAME#" right="VARCHAR">

<cfdbinfo type="columns" datasource="#ds#" name="data" table="User306" pattern="id">
<cf_valueEquals left="#data.COLUMN_NAME#" right="id">
<cf_valueEquals left="#data.COLUMN_SIZE#" right="10">
<cf_valueEquals left="#data.DECIMAL_DIGITS#" right="0">
<cf_valueEquals left="#data.IS_FOREIGNKEY#" right="#false#">
<cf_valueEquals left="#data.IS_NULLABLE#" right="#false#">
<cf_valueEquals left="#data.IS_PRIMARYKEY#" right="#true#">
<cf_valueEquals left="#data.ORDINAL_POSITION#" right="1">
<cf_valueEquals left="#data.REFERENCED_PRIMARYKEY#" right="N/A">
<cf_valueEquals left="#data.REFERENCED_PRIMARYKEY_TABLE#" right="N/A">
<cf_valueEquals left="#data.REMARKS#" right="">
<cf_valueEquals left="#data.TYPE_NAME#" right="INT">


<cfdbinfo type="columns" datasource="#ds#" name="data" table="User306" pattern="data">
<cf_valueEquals left="#data.COLUMN_NAME#" right="data">
<cf_valueEquals left="#data.COLUMN_SIZE#" right="100">
<cf_valueEquals left="#data.DECIMAL_DIGITS#" right="0">
<cf_valueEquals left="#data.IS_FOREIGNKEY#" right="#false#">
<cf_valueEquals left="#data.IS_NULLABLE#" right="#true#">
<cf_valueEquals left="#data.IS_PRIMARYKEY#" right="#false#">
<cf_valueEquals left="#data.ORDINAL_POSITION#" right="2">
<cf_valueEquals left="#data.REFERENCED_PRIMARYKEY#" right="N/A">
<cf_valueEquals left="#data.REFERENCED_PRIMARYKEY_TABLE#" right="N/A">
<cf_valueEquals left="#data.REMARKS#" right="">
<cf_valueEquals left="#data.TYPE_NAME#" right="VARCHAR">
