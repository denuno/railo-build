component displayName='Application' {

	this.name ="context1246";
	this.sessionmanagement=true;
    
    function onRequestStart() {
    	session[templateName() & ":start"]=true;
    }
    function onRequestEnd() {
    	session[templateName() & ":end"]=true;
    }
    
    
    function templateName() {
    	return listLast(cgi.SCRIPT_NAME,"/");
    }
 
}