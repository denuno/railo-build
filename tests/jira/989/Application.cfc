component output="false" {

	this.name = hash( getCurrentTemplatePath() );
	this.applicationTimeout = createTimeSpan(1,0,0,0);
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0,1,0,0);
	this.setClientCookies = false;

	server.enableORM = "dinfao";

	this.ormEnabled = true;
	this.ormsettings = {
		datasource="railo_mirror",
		dbcreate="update",
		eventhandling=false,
		flushAtRequestEnd=false,
        savemapping=false	,
		logsql=true};		

	boolean function onRequestStart( string targetPage ) {
		
		ormReload();
		return true;	
	
	} 
	
}