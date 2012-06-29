<cfcomponent output="true"> 
<cfscript> 
this.name = 'blah'; 
this.clientmanagement= "yes"; 
this.loginstorage = "session" ; 
this.sessionmanagement = "yes"; 
this.setClientCookies = "no"; 
this.setDomainCookies = "no"; 
this.scriptProtect = "all"; 
this.customTagPaths = ""; 
    server.enableORM = 'dinfao'; 
    this.ormEnabled = true; 
    this.datasource = 'railo_mirror'; // <-- CHANGE THIS 
    this.ormSettings = { dbcreate = 'update', cfclocation = getDirectoryFromPath(getCurrenttemplatePath())&'model' }; 
	
</cfscript> 
<!--- 
<cffunction name="OnApplicationStart" output="false"> 
</cffunction> 
<cffunction name="OnSessionStart" output="false"> 
</cffunction> 
<cffunction name="OnRequestStart" output="false"> 
</cffunction> 
<cffunction name="OnRequest" output="true"> 
<cfargument name="page" required="yes" type="string"> 
<cfinclude template="#arguments.page#"> 
</cffunction> 
<cffunction name="OnRequestEnd" output="false"> 
</cffunction> 
<cffunction name="OnSessionEnd" output="false"> 
</cffunction> 
<cffunction name="OnApplicationEnd" output="false"> 
</cffunction> 
---> 
</cfcomponent> 