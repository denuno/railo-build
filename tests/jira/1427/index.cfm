<cfsetting showdebugoutput="no">
<cfset base="http://#cgi.HTTP_HOST##GetDirectoryFromPath(cgi.SCRIPT_NAME)#">
<cfhttp url="#base#target/index.cfm" resolveurl="yes"/>
<cf_valueEquals left="#trim(cfhttp.FileContent)#" right='<a href="http://#cgi.HTTP_HOST#/jm/jira/1427/target/sub/index.cfm">a</a>'>