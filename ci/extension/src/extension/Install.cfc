<cfcomponent extends="install.Installer">

		<cfset variables.extensionTag = "railo-nightly" />

    <cffunction name="validate" returntype="string" output="no"
    	hint="called from Railo to install application">
    	<cfargument name="error" type="struct">
        <cfargument name="path" type="string">
        <cfargument name="config" type="struct">
        <cfargument name="step" type="numeric">
        <cfset arguments.config=arguments.config.mixed>
    </cffunction>

    <cffunction name="install" returntype="string" output="no"
    	hint="called from Railo to install application">
    	<cfargument name="error" type="struct">
        <cfargument name="path" type="string">
        <cfargument name="config" type="struct">

				<cfset arguments.config=arguments.config.mixed>
				<cfset standardInstall(error,path,config) />
        <cfset var message='Railo-Nightly is now successfully installed! Rock on with your bad self.'>
        <cfreturn message>

    </cffunction>


    <cffunction name="update" returntype="string" output="no"
    	hint="called from Railo to install application">
    	<cfargument name="error" type="struct">
        <cfargument name="path" type="string">
        <cfargument name="config" type="struct">
        <cfreturn install(error,path,config) />

    </cffunction>

    <cffunction name="uninstall" returntype="string" output="no"
    	hint="called from Railo to uninstall application">
    	<cfargument name="path" type="string">
        <cfargument name="config" type="struct">
       	<cfset arguments.config=arguments.config.mixed>
				<cfset standardUnInstall(path,config) />
        <cfreturn 'application sucessfully removed'>
    </cffunction>

</cfcomponent>