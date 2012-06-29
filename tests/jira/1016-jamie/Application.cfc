component {
	this.name = hash( getCurrentTemplatePath() );

    request.datasource="railo_mirror";

    this.datasource = request.datasource;
	this.ormEnabled = true;
	this.ormSettings = {
		savemapping=false,
		dbcreate = 'dropcreate' ,
		logSQL=false,

     //   dialect = 'MySQLwithInnoDB',
        flushatrequestend = false
	};



}