component {
	this.name = hash( getCurrentTemplatePath() )& gettickcount();
    this.secureJSON=true;
    this.secureJSONPrefix = "while(1); //";
} 