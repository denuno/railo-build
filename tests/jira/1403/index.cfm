<cfsetting showdebugoutput="no">

<cfset server.THREAD_TASK_DONE=false>
<cfthread action="run" name="run1" type="task" retryInterval="#{Interval:createTimeSpan(0,0,5,0), Tries:1}#"> 
	<cfscript> 
		objSample = createObject("component", "sample").init(); 
	</cfscript> 
	<cfoutput> 
	<p>#objSample.getDateTime()#</p> 
	</cfoutput> <cfset server.thread_task_done=true>
</cfthread>


<!--- cannot do a cfthread-join ---->
<cfset sleep(1000)>
<cf_valueEquals left="#structKeyExists(server,"THREAD_TASK_DONE") and server.THREAD_TASK_DONE#" right="#true#">