<!--- index.cfm ---> 
<cfscript> 
if ( structKeyExists( url, 'create' ) && url.create ) 
{ 
        writeOutput( 'Creating/saving a new entity...<br />' ); 
        user = entityNew( 'user' ); 
        user.name = 'todd'; 
        user.email = 'webRat@gmail.com'; 
        //entitySave( user ); 
        writeOutput( 'New entity saved with ID: #user.getID()#' ); 
} 
else { 
        writeOutput( 'Loading entity with id=1...<br />' ); 
        user = entityLoad( 'user', 1, true ); 
} 
if ( isDefined( 'user' ) ) 
{ 
        writeOutput( 'Entity: #user.getID()# #user.getName()# #user.getEmail()# '); 
} else { 
        writeOutput( 'No entity loaded' ); 
} 
</cfscript>