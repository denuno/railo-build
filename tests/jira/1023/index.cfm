<cfscript>
test=createObject('wsdl',"http://#cgi.HTTP_HOST##getDirectoryFromPath(cgi.SCRIPT_NAME)#Test.cfc?wsdl");
dump(test.test());


</cfscript>