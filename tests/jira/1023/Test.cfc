component {
	writeOutput("cfc body");
	remote string function test() {
    	writeOutput("cfc function body");
    	return "hello from test";
    }
 
} 