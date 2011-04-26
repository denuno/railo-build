<cfcomponent displayname="TestInstall"  extends="mxunit.framework.TestCase">  


  <cffunction name="setUp" returntype="void" access="public">
		<cfset variables.extensionTag = "railo-nightly" />
 		<cfset variables.build = createObject("component","#variables.extensionTag#.src.extension.install.Build") />
		<cfset variables.extensionzip = "/#variables.extensionTag#/dist/#variables.extensionTag#-extension.zip">
  </cffunction>

	<cffunction name="dumpvar" access="private">
		<cfargument name="var">
		<cfdump var="#var#">
		<cfabort/>
	</cffunction>

	<cffunction name="testBuild">
		<cfset var buildresults = variables.build.build() />
		<cfset assertEquals(buildresults.errortext,"") />
		<cfset debug(buildresults) />
	</cffunction>
	
	<cffunction name="testInstall">
		<cfset install = createObject("component","TestInstall") />
		<cfset install.setUp() />
		<cfset install.testInstall() />
	</cffunction>

	<cffunction name="testUnInstall">
		<cfset install = createObject("component","TestInstall") />
		<cfset install.setUp() />
		<cfset install.testUnInstall() />
	</cffunction>

</cfcomponent>