component {
	this.name = hash( getCurrentTemplatePath()& getTickCount() );
 	this.datasource = 'railo_mirror'; 

	this.ormEnabled = true; 
	this.ormSettings = { 
		savemapping=false,
		dbcreate = 'dropcreate' ,
		logSQL=true,
        skipCFCWithError=false,
        cfclocation=GetDirectoryFromPath(GetCurrentTemplatePath())
	}; 
} 