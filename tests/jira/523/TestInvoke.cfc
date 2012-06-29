<cfcomponent>

  <cffunction name="insider" output="true" returntype="void" access="public">i</cffunction>
  
  <cffunction name="a" output="false" returntype="string" access="public">
  	<cfset var rtn="">
    <cfsavecontent variable="rtn"><cfinvoke method="insider" returnvariable="x"></cfsavecontent>
    <cfreturn rtn>
  </cffunction>
  
  <cffunction name="b" output="false" returntype="string" access="public">
  	<cfset var rtn="">
    <cfsavecontent variable="rtn"><cfinclude template="TestInvoke.cfm"><cfinvoke method="outsider" returnvariable="x"></cfsavecontent>
    <cfreturn rtn>
  </cffunction>
</cfcomponent> 