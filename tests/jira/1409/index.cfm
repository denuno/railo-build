<cfsetting showdebugoutput="no">


<cfset path="http://"&cgi.server_name&":"&cgi.server_port&getDirectoryFromPath(cgi.SCRIPT_NAME)&"test_remote.cfc">
<cfhttp url="#path#?method=testRemote" result="test" resolveurl="no" />
<cf_valueEquals left="#trim(test.filecontent)#" right='while(1); //{"VALUE":"susi"}'>