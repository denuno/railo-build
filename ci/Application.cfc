component {

	this.name="ci-#hash(getTemplatePath())#";

	function onApplicationStart() {
		include "bootstrap.cfm";
	}

	function onRequestStart(thepage) {
		include "bootstrap.cfm";
	}

	function loadProperties(required propsfile)  {
		var properties = createObject('java', 'java.util.Properties').init();
		var fileStream = createObject('java', 'java.io.FileInputStream').init(propsfile);
		properties.load(fileStream);
		return properties;
	}

	function storeProperties(required propsfile ,required properties, comment ="modified #now()#")  {
		var fileStream = createObject('java', 'java.io.FileOutputStream').init(propsfile);
		properties.store(fileStream,comment);
		return properties;
	}


}