
<cfinvoke webservice="http://#cgi.server_name#:#cgi.SERVER_PORT##GetDirectoryFromPath(cgi.script_name)#test.cfc?wsdl" method="invoke" returnvariable="res">
<cfdump var="#res#">