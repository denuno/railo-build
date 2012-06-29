

<cfhttp url="http://#cgi.server_name#:#cgi.server_port##getDirectoryFromPath(cgi.script_name)#a/index.cfm">
<cfoutput>#cfhttp.filecontent#</cfoutput>

<cfhttp url="http://#cgi.server_name#:#cgi.server_port##getDirectoryFromPath(cgi.script_name)#b/index.cfm">
<cfoutput>#cfhttp.filecontent#</cfoutput>