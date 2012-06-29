component extends="org.corfield.fw1" {

	public void function setupRequest() {
		var path = getCurrentTemplatePath();
		writeOutput( path );
	}

}