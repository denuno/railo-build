<cfsetting showdebugoutput="no">
<cfset ds="railo_mirror">

<cfdbinfo name="dbi" type="version" datasource="#ds#">
<cf_valueEquals left="#dbi.recordcount#" right="1">
<cf_valueEquals left="#listSort(dbi.columnlist,"textnocase")#" right="DATABASE_PRODUCTNAME,DATABASE_VERSION,DRIVER_NAME,DRIVER_VERSION,JDBC_MAJOR_VERSION,JDBC_MINOR_VERSION">
