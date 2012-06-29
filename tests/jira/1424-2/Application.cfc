<cfcomponent>

<cfscript>
	this.name = hash(getCurrentTemplatePath() & 1);
 	this.datasource = 'railo_mirror'; 

	this.ormEnabled = true; 
	this.ormSettings = { 
		dbcreate = 'dropcreate',
		cfclocation = 'model1'
	};
</cfscript>

<cffunction name="onApplicationStart">
</cffunction>


<cffunction name="onRequestStart">
    <cf_valueEquals left="#getFunctioNames()#" right="GETACTIVE,GETID,SETACTIVE,SETID">
    
    <cfset this.ormSettings.cfclocation = 'model1'>
	<cfset ormReload()>
	
    <cf_valueEquals left="#getFunctioNames()#" right="GETACTIVE,GETACTIVE2,GETID,SETACTIVE,SETACTIVE2,SETID">
    
</cffunction>




    <cffunction name="getFunctioNames">
        <cfset var entity=entityNew('systemlogdata')>
        <cfset var meta=getMetaData(entity)>
        <cfset var names="">
        <cfloop array="#meta.FUNCTIONS#" index="local.func">
        	<cfset names=ListAppend(names,func.name)>
        </cfloop>
        <cfreturn ListSort(names,"textnocase")>
    </cffunction>

</cfcomponent>