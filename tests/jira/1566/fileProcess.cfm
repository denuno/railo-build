<cfsetting showdebugoutput="no">

    <cfset current=GetDirectoryFromPath(GetCurrentTemplatePath())>
	<cf_valueEquals left="#fileExists(form['hello.world'])#" right="true">
	
    <cffile action="upload"  destination="#current#" filefield="Form.hello.world" nameconflict="overwrite">
	<cf_valueEquals left="#cffile.serverfile#" right="exampleFile.jsp">
    <cffile action="upload"  destination="#current#" filefield="hello.world" nameconflict="overwrite">
	<cf_valueEquals left="#cffile.serverfile#" right="exampleFile.jsp">
    
    <cffile action="upload"  destination="#current#" filefield="Form.hello.world.how.are.you" nameconflict="overwrite">
	<cf_valueEquals left="#cffile.serverfile#" right="exampleFile.jsp">
    <cffile action="upload"  destination="#current#" filefield="hello.world.how.are.you" nameconflict="overwrite">
	<cf_valueEquals left="#cffile.serverfile#" right="exampleFile.jsp">
    
    
    