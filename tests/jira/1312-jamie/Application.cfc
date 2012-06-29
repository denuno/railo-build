component
{
	this.name = 'railo_jira_XXXX';
	this.datasource = 'railo_mirror';
	this.ormEnabled = true;
	this.ormSettings.dbcreate = 'dropcreate';
	this.ormSettings.flushatrequestend = false;
	this.ormSettings.logsql = true;
}
