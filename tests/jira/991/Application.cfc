component output="false" {
	this.name = "test991" & getTickCount();
	this.applicationTimeout = createTimeSpan(0,1,0,0);
	this.sessionManagement = false;
	this.setClientCookies = false;

	this.mappings = { '/test991' = GetDirectoryFromPath(GetCurrentTemplatePath()) };
    
    
	this.ormEnabled = true;
	this.ormsettings = {
		datasource="railo_mirror",
		dbcreate="update",
		flushAtRequestEnd=false,
		logsql=true	,
        savemapping=false	,
        
        cfclocation = GetDirectoryFromPath(GetCurrentTemplatePath())
	};





	function onRequestStart( string targetPage ) {
	
		ormReload();
		
	}

}