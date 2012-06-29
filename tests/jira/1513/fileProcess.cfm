<cfsetting showdebugoutput="no">

    <cfset current=GetDirectoryFromPath(GetCurrentTemplatePath())>
	<cf_valueEquals left="#ListSort(StructKeyList(form),'textnocase')#" right="fieldnames,fileToLoad">
	<cf_valueEquals left="#fileExists(form.fileToLoad)#" right="true">
	
    <cffile action="upload"  destination="#current#" filefield="Form.fileToLoad" nameconflict="overwrite">
	<cf_valueEquals left="#cffile.serverfile#" right="exampleFile.jsp">