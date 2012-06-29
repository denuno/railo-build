component output="false" {
	this.name = "test1406" & getTickCount();
	this.applicationTimeout = createTimeSpan(0,1,0,0);
	this.sessionManagement = false;
	this.setClientCookies = false;


	this.ormEnabled = true;
	this.ormsettings = {
		datasource="railo_mirror",
		dbcreate="update",
		flushAtRequestEnd=false,
		logsql=true	,
        savemapping=false

	};





	function onRequestStart( string targetPage ) {

		ormReload();

	}

}