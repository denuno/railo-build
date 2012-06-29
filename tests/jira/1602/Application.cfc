component
{
    this.name = hash( getCurrentTemplatePath() );
    this.datasource = 'railo_mirror';

    this.ormEnabled = true;
    this.ormSettings = {
		dbcreate = 'dropcreate',
        logSQL=true,
        flushatrequestend = false
    };
}
