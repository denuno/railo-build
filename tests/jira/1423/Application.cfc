component {
	this.name = hash( getCurrentTemplatePath() )& gettickcount();
 	this.datasource = 'railo_mirror'; 

	this.ormEnabled = true; 
	this.ormSettings = { 
		savemapping=false,
		dbcreate = 'dropcreate' ,
		logSQL=true,
		sqlscript = 'install.sql',
		cfclocation = 'model'
	}; 
    
    
    function onApplicationStart(){
    	this.ormSettings.sqlscript = 'install2.sql';
    	ormReload();
    }
} 