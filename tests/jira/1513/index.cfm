<cfsetting showdebugoutput="no">	
    
<cfset base="http://#cgi.HTTP_HOST##GetDirectoryFromPath(cgi.SCRIPT_NAME)#">
        
	<cfhttp  method="post" url="#base#fileProcess.cfm"  throwonerror="Yes"> 
	
	    <cfhttpparam name="fileToLoad" type="file"
		 	file="#ExpandPath("exampleFile.jsp")#" mimetype="text/html"> 
		
	</cfhttp> 
	 
	
	<cfoutput>
		#cfhttp.filecontent#	
	</cfoutput>
