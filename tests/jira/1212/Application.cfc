component output="false" {

    key="test1212";
    this.name =  key& getTickCount();
	this.applicationTimeout = createTimeSpan(0,1,0,0);
	this.sessionManagement = false;
	this.setClientCookies = false;

	this.mappings = { '/#key#' = GetDirectoryFromPath(GetCurrentTemplatePath()) };


	this.ormEnabled = true;
	this.ormsettings = {
		datasource="railo_mirror",
		dbcreate="update",
		flushAtRequestEnd=false,
		logsql=true	,
        savemapping=false,
        cfclocation = GetDirectoryFromPath(GetCurrentTemplatePath())
	};

	function onRequestStart( string targetPage ) {
		ormReload();
	}

}