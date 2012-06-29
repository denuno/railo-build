component extends="Remote" {
	remote function getAsPlain(required numeric id) output="false" returnformat="plain" returntype="any" { 
    	var obj = EntityLoad("E1264", arguments.id, true); 
        return obj;	 
    }
	remote function getAsSerialize(required numeric id) output="false" returnformat="serialize" returntype="any" {
    	var obj = EntityLoad("E1264", arguments.id, true); 
        return obj;	 
    }
}