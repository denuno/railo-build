component {

	this.name="ci-#hash(getTemplatePath())#";

	function onApplicationStart() {
		include "bootstrap.cfm";
	}

}