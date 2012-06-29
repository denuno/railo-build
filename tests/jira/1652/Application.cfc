<cfcomponent extends="BaseApplication">
	<cfset this.namex="abc">
	<cfset this.sessionManagement=true>
	<cfset this.sessionTimeout=CreateTimeSpan(0,0,0,1)>
	
<cffunction name="onSessionEndX" returnType="void">
    <cfargument name="SessionScope" required=True/>
    <cfargument name="ApplicationScope" required=False/>
    <cfset systemOutput("onSessionEnd",true,true)>
</cffunction>
</cfcomponent>