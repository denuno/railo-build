<cfsetting showdebugoutput="no">




<cffunction name="test1243" access="private" returntype="void">
   <cfargument name="a" type="string" default="default1">
   <cfargument name="b" type="string" default="default2">
   <cfargument name="c" type="string" default="default3">

	<cf_valueEquals left="#arguments.a#" right="1">
	<cf_valueEquals left="#arguments.b#" right="2">
	<cf_valueEquals left="#arguments.c#" right="3">
</cffunction>

<CFSCRIPT>
	   
    ac1 = {};
    ac1.a = "1";
    ac1.b = "2";
    ac1.c = "3";
	test1243(ArgumentCollection=ac1);
		
	ac2 =  createobject('java', 'java.util.HashMap').init();
    ac2.a = "1";
    ac2.b = "2";
    ac2.c = "3";
	test1243(ArgumentCollection=ac2);
	
	// not supported by ACF   
	if(server.ColdFusion.ProductName EQ "railo") {
		
		ac3 =  createobject('java', 'java.util.HashMap');
		ac3.a = "1";
		ac3.b = "2";
		ac3.c = "3";
		test1243(ArgumentCollection=ac3);
	
		ac4 = [];
		ac4[1] = "1";
		ac4[2] = "2";
		ac4[3] = "3";
		test1243(ArgumentCollection=ac4);
	
		ac5 = createobject('java', 'java.util.ArrayList');
		ac5[1] = "1";
		ac5[2] = "2";
		ac5[3] = "3";
		test1243(ArgumentCollection=ac5);
	
		ac6 = createobject('java', 'java.util.ArrayList').init();
		ac6[1] = "1";
		ac6[2] = "2";
		ac6[3] = "3";
		test1243(ArgumentCollection=ac6);
	}
</CFSCRIPT>

<cf_test attributeCollection="#ac1#">
<cf_test attributeCollection="#ac2#">
<!--- not supported by ACF --->
<cfif server.ColdFusion.ProductName EQ "railo">
	<cf_test attributeCollection="#ac3#">
</cfif>


