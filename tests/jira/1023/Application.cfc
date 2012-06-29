component displayName='Application'  { 
	writeOutput("application body");
    this.name = 'railo_1023'; 
	
    function OnRequestStart(){
    	writeOutput("function OnRequestStart body");
    }
    function OnRequest(path){
    	writeOutput("function OnRequest body #path#");
        include path;
    }
    function OnRequestEnd(){
    	writeOutput("function OnRequestEnd body");
    }
} 