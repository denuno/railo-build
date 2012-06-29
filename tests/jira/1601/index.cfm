<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>


<cfscript> 
t = entitynew("Test"); 
t.setName("Susi");
d=now();
entitysave(t);
ormFlush();


transaction { 
	t2 = entitynew("Test"); 
	t2.setName("Chris");
	d2=now();
	ormFlush();
	entitysave(t2);
	
}
</cfscript>
<cfquery name="q"> 
SELECT * FROM Test1601
</cfquery> 



<cf_valueEquals left="#t.getName()#" right="Susi">
<cf_valueEquals left="#t.getTest()#" right="Salve">
<cf_valueEquals left="#t.getDateCreated()#" right="#d#">

<cf_valueEquals left="#t2.getName()#" right="Chris">
<cf_valueEquals left="#t2.getTest()#" right="Salve">
<cf_valueEquals left="#t2.getDateCreated()#" right="#d2#">

<cf_valueEquals left="#q.DateCreated[1]#" right="#d#">
<cf_valueEquals left="#q.Test[1]#" right="Salve">
<cf_valueEquals left="#q.Name[1]#" right="Susi">

<cf_valueEquals left="#q.DateCreated[2]#" right="#d2#">
<cf_valueEquals left="#q.Test[2]#" right="Salve">
<cf_valueEquals left="#q.Name[2]#" right="Chris">