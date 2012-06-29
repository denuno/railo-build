<cfcomponent>

<cfscript>
	this.name = hash(getCurrentTemplatePath()) & getTickCount();
 	this.datasource = "railo_mirror"; 
		
	this.ormEnabled = true; 
	this.ormSettings = { 
		dbcreate = "dropcreate",
		cfclocation = "model",
		flushatrequestend = false,
		eventhandling = true,
		eventHandler= "model.eventHandler"
	} ;
</cfscript>


<cffunction name="onApplicationStart">
	
</cffunction>


<cffunction name="onRequestStart">
	
</cffunction>

</cfcomponent>