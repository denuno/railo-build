component {
	this.name = hash( getCurrentTemplatePath() )& gettickcount();
 	this.datasource = 'railo_mirror'; 

	this.ormEnabled = true; 
	this.ormSettings = { 
		savemapping=true,
		dbcreate = 'dropcreate' ,
		logSQL=true
	}; 
} 