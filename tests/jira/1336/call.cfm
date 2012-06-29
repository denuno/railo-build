<cfsetting showdebugoutput="no">



<cfinclude template="createEntity.cfm">
<cfscript>
	
	entities=getEntities(1);
	session.entity=entities;
	
	
</cfscript>