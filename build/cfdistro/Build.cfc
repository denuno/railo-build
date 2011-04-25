<cfcomponent output="false">

	<cffunction name="init" output="false">
		<cfset variables.adminType = "web" />
		<cfparam name="cfadminpassword" default="@cfadmin.password@" />
		<cfset variables["password#variables.adminType#"] = cfadminpassword />
		<cfreturn this />
	</cffunction>

	<cffunction name="compile-mapping" access="remote" output="false">
		<cfargument name="mapping" required="true">
		<cfsilent>
		<cfset init() />
		<cftry>
			<cfadmin
			    action="compileMapping"
			    type="web"
			    password="#variables["password"&variables.adminType]#"
			    virtual="#arguments.mapping#"
		    	stoponerror="false"
		     />
		    <cfreturn "compiled mapping: #arguments.mapping#" />
			<cfcatch>
				<cfreturn cfcatch.message & cfcatch.detail />
			</cfcatch>
		</cftry>
		</cfsilent>
	</cffunction>


	<cffunction name="compile-archive" access="remote" output="false">
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

	<cffunction name="show-results" access="remote" output="false">
		<cfargument name="resultsFile" required="true">
		<cffile action="read" file="#resultsFile#" variable="results" />
	    <cfset writeOutput("compiled archive: #paragraphFormat(results)#")/>
	    <cfabort>

	</cffunction>

</cfcomponent>