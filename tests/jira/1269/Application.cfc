component {
	this.name = "jira-" & hash( getCurrentTemplatePath() );
 	this.datasource = 'railo_mirror';

	this.ormEnabled = true;
	this.ormSettings = {
		savemapping=false,
		dbcreate = 'dropcreate' ,
		logSQL=true
	};
}