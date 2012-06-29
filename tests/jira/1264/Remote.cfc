component {
	remote function getAsJson(required numeric id) output="false" returnformat="json" returntype="any" { 
    	var obj = EntityLoad("E1264", arguments.id, true); 
        return obj;	 
    }
	remote function cfcAsWddx(required numeric id) output="false" returnformat="wddx" returntype="component" { 
    	var e = new E1264(); 
        e.setID( '1' );
		e.setFoo( 'f' );
		return e;	 
    }
	remote function entityAsWddx(required numeric id) output="false" returnformat="wddx" returntype="any" { 
    	var obj = EntityLoad("E1264", arguments.id, true); 
        return obj;	 
    }
}