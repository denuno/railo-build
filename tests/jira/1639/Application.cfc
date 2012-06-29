component {

	this.name = hash( getCurrentTemplatePath() );
	
	this.ormEnabled = true;
	this.ormSettings.eventHandling = true;
	this.ormSettings.flushatrequestend = false;
	this.ormSettings.autoManageSession = false;
	this.ormSettings.datasource = "railo_mirror";
	this.ormSettings.dbcreate = "update";
    this.ormSettings.skipCFCWithError=true;
	//this.ormSettings.cfclocation =contractPath(GetDirectoryFromPath(GetCurrentTemplatePath())) & "entities/";
	this.ormSettings.autogenmap = true;
	
	public any function onRequestStart() {
		ormReload();
	}
}