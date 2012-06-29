component {
	
    
    THIS.name = "test_orm"& hash( getCurrentTemplatePath() );
	THIS.ormenabled = true;
	THIS.datasource = 'railo_mirror';
	THIS.ormSettings = { 
    	autogenmap = true, 
        automanageSession = true, 
        dbcreate = 'none', 
        dialect = 'Oracle10g', 
        eventHandling = false, 
        flushatrequestend = true, 
        logSQL = false, 
        savemapping = false, 
        secondarycacheenabled = false, 
        skipCFCWithError = false, 		
        useDBForMapping = true };
} 