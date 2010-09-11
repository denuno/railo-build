<cfcomponent output="false">  

	<cffunction name="init" output="false">
		<cfset variables.adminType = "web" />
		<cffile action="read" file="#getDirectoryFromPath(getMetadata(this).path)#/cfadminpassword.txt" variable="variables.password#variables.adminType#" />
		<cfreturn this />	
	</cffunction>
	
	<cffunction name="compile-mapping" access="remote">
		<cfargument name="mapping" required="true">
		<cfset init() />
		<cfadmin
		    action="compileMapping"
		    type="web"
		    password="#variables["password"&variables.adminType]#"
		    virtual="#arguments.mapping#"
	    	stoponerror="false"
	     />
	    <cfreturn "compiled mapping: #arguments.mapping#" />
	</cffunction>
	
	<cffunction name="compile-archive" access="remote">
		<cfargument name="mapping" required="true">
		<cfargument name="toFile" required="true">
		<cfset init() />
		<cfadmin
		    action="createArchive"
		    type="web"
		    password="#variables["password"&variables.adminType]#"
		    file="#arguments.toFile#"
		    virtual="#arguments.mapping#"
		    secure="true"
	    	stoponerror="false"
		    append="false"
		     />
	    <cfreturn "compiled archive: #arguments.mapping# : #arguments.toFile#" />
	</cffunction>
	

</cfcomponent>