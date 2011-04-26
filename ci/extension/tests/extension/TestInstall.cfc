<cfcomponent displayname="TestInstall"  extends="mxunit.framework.TestCase">


  <cffunction name="setUp" returntype="void" access="public">
		<cfset variables.extensionTag = "railo-nightly" />
 		<cfset variables.Install = createObject("component","#variables.extensionTag#.src.extension.Install") />
		<cfset variables.extensionzip = "/#variables.extensionTag#/dist/#variables.extensionTag#-extension.zip">
		<cfset variables.defaultconfig = {"mixed":{"isBuiltInTag":true,"installTestPlugin":true}}>
		<cfset request.adminType = "server" />
		<cffile action="read" file="#expandpath('/'&variables.extensionTag)#/tests/cfadminpassword.txt" variable="session.password#request.adminType#" />
  </cffunction>

	<cffunction name="dumpvar" access="private">
		<cfargument name="var">
		<cfdump var="#var#">
		<cfabort/>
	</cffunction>

	<cffunction name="getPluginDir" access="private" output="false">
		<cfset var pluginDir = "" />
		<cfadmin
		    action="getPluginDirectory"
		    type="#request.adminType#"
		    password="#session["password"&request.adminType]#"
		    returnVariable="pluginDir">
		<cfif NOT directoryExists(pluginDir)>
			<cfdirectory action="create" directory="#pluginDir#" recurse="true" />
		</cfif>
		<cfreturn pluginDir />
	</cffunction>

	<cffunction name="testInstall">
		<cfargument name="uninstall" default="false">
		<cfscript>
			var error = structNew();
			var path = "zip://" & expandPath("#variables.extensionzip#!/");
			var config = variables.defaultconfig;
			var result = variables.Install.install(error,path,config);
			debug(result);
			assertTrue(directoryExists("#getPluginDir()#/#variables.extensionTag#"));
//			assertEquals(true,result.status,result.message);
			if(arguments.uninstall){
				testUnInstall();
			}
		</cfscript>
	</cffunction>

	<cffunction name="testUnInstall">
		<cfscript>
			var error = structNew();
			var path = "zip://" & expandPath("#variables.extensionzip#!/");
			var config = variables.defaultconfig;
			var result = variables.Install.uninstall(path,config);
			assertFalse(directoryExists("#getPluginDir()#/#variables.extensionTag#"));
	//		debug(result);
//			assertEquals(true,result.status,result.message);
		</cfscript>
	</cffunction>

</cfcomponent>