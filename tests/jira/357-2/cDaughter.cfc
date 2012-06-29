<cfcomponent extends="cMother">

  <cffunction name="a">
  	<cfset b()>
    <cf__interna>
    <cfimport prefix="jira357" taglib="/tests/jira/357-2/">
    <jira357:_interna>
  </cffunction>

</cfcomponent>