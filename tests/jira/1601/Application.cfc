component {
	this.name = hash( getCurrentTemplatePath() )& gettickcount();
 	this.datasource = 'railo_mirror'; 

	this.ormEnabled = true; 
	this.ormSettings = { 
		eventHandling = true,
		savemapping=false,
		dbcreate = 'dropcreate' ,
		logSQL=true
	}; 
} 