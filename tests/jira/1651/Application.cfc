<cfcomponent>
	<cfset this.namex="abc">
	<cfset this.sessionManagement=true>
	<cfset this.sessionTimeout=CreateTimeSpan(0,0,0,1)>
    <cfset this.sessionManagement=true>
	<cfset this.applicatonTimeout=CreateTimeSpan(0,0,0,1)>
    
    
	<cfset current=GetDirectoryFromPath(GetCurrentTemplatePath())>
<cffunction name="onRequestStart" returnType="void" output="yes"><cffile action="append" addnewline="yes" file="#current#events.log" output="onRequestStart:#structKeyList(arguments)#"></cffunction>
<cffunction name="onRequestEnd" returnType="void" output="yes"><cffile action="append" addnewline="yes" file="#current#events.log" output="onRequestEnd:#structKeyList(arguments)#"></cffunction>

<cffunction name="onSessionStart" returnType="void" output="yes"><cffile action="append" addnewline="yes" file="#current#events.log" output="onSessionStart:#structKeyList(arguments)#"></cffunction>
<cffunction name="onSessionEnd" returnType="void" output="yes"><cffile action="append" addnewline="yes" file="#current#events.log" output="onSessionEnd:#structKeyList(arguments)#"></cffunction>

<cffunction name="onApplicationStart" returnType="void" output="yes"><cffile action="append" addnewline="yes" file="#current#events.log" output="onApplicationStart:#structKeyList(arguments)#"></cffunction>
<cffunction name="onApplicationEnd" returnType="void" output="yes"><cffile action="append" addnewline="yes" file="#current#events.log" output="onApplicationEnd:#structKeyList(arguments)#"></cffunction>

</cfcomponent>