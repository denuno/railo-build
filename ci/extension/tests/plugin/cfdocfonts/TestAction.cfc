<cfcomponent displayname="TestAction"  extends="mxunit.framework.TestCase">  

  <cffunction name="setUp" returntype="void" access="public">
 		<cfset variables.Action = createObject("component","railo-nightly.src.plugin.railo-nightly.Action") />
 		<cfset variables.Action.init() />
  </cffunction>

		<cffunction name="dumpvar" access="private">
		<cfargument name="var">
		<cfdump var="#var#">
		<cfabort/>
	</cffunction>

	<cffunction name="testGetInstalledFonts">
		<cfscript>
			fontListAr = variables.Action.getInstalledFonts();
			debug(fontListAr);
		</cfscript>
	</cffunction>

</cfcomponent>