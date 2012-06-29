<!--- index.cfm --->
<cfscript>

e1 = entityNew( 'Entity991' );
e2 = createObject( 'component', 'Entity991' );
e3 = new Entity991();

</cfscript>

<cf_valueEquals left="#e1.getFoo()#" right="base entity">
<cf_valueEquals left="#e2.getFoo()#" right="default">
<cf_valueEquals left="#e3.getFoo()#" right="base entity">

