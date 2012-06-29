component {
	this.name = hash( getCurrentTemplatePath() );
 	this.datasource = 'railo_mirror'; 

	this.ormEnabled = true; 
	this.ormSettings = { 
		savemapping=false,
		dbcreate = 'dropcreate' ,
		logSQL=false
	}; 
    
    
	public any function onRequestStart() {
		ormReload();
	}
} 