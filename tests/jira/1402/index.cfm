<cfsetting showdebugoutput="no">

<cfset mysql="railo_mirror">

<!--- 
MYSQL
--->



<!--- no result no update --->
<cfset test={}>
<cfquery datasource="#mysql#" result="test.res"  name="test.qry">
set @x = 0;
</cfquery>
<cf_valueEquals left="#structKeyExists(test,"qry")#" right="#false#">
<cf_valueEquals left="#structKeyExists(test,"res")#" right="#true#">
<cf_valueEquals left="#test.res.RECORDCOUNT#" right="0">



<!--- set then result --->
<cfset test={}>
<cfquery datasource="#mysql#" result="test.res"  name="test.qry">
set @x = 1;
select @x as a;
</cfquery>
<cf_valueEquals left="#structKeyExists(test,"qry")#" right="#true#">
<cf_valueEquals left="#structKeyExists(test,"res")#" right="#true#">
<cf_valueEquals left="#test.res.RECORDCOUNT#" right="1">
<cf_valueEquals left="#test.res.columnlist#" right="a">
<cf_valueEquals left="#test.qry.RECORDCOUNT#" right="1">
<cf_valueEquals left="#test.qry.columnlist#" right="a">
<cf_valueEquals left="#test.qry.a#" right="1">


<!--- 3 set then result --->
<cfset test={}>
<cfquery datasource="#mysql#" result="test.res"  name="test.qry">
set @x = 1;
set @x = 2;
set @x = 3;
select @x as a;
</cfquery>
<cf_valueEquals left="#structKeyExists(test,"qry")#" right="#true#">
<cf_valueEquals left="#structKeyExists(test,"res")#" right="#true#">
<cf_valueEquals left="#test.res.RECORDCOUNT#" right="1">
<cf_valueEquals left="#test.res.columnlist#" right="a">
<cf_valueEquals left="#test.qry.RECORDCOUNT#" right="1">
<cf_valueEquals left="#test.qry.columnlist#" right="a">
<cf_valueEquals left="#test.qry.a#" right="3">

<!--- update,set then result --->
<cfset test={}>
<cfquery datasource="#mysql#" result="test.res"  name="test.qry">
delete from test;
set @x = 3;
select @x as a;
</cfquery>
<cf_valueEquals left="#structKeyExists(test,"qry")#" right="#true#">
<cf_valueEquals left="#structKeyExists(test,"res")#" right="#true#">
<cf_valueEquals left="#test.res.RECORDCOUNT#" right="1">
<cf_valueEquals left="#test.res.columnlist#" right="a">
<cf_valueEquals left="#test.qry.RECORDCOUNT#" right="1">
<cf_valueEquals left="#test.qry.columnlist#" right="a">
<cf_valueEquals left="#test.qry.a#" right="3">





<cf_valueEquals left="" right="">