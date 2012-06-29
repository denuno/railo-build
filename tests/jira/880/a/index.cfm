<cfscript>
import map.*;
</cfscript>

<cf_valueequals left="#new map.Test().getName()#" right="#getDirectoryFromPath(getCurrenttemplatePath())#Test.cfc">
<cf_valueequals left="#new Test().getName()#" right="#getDirectoryFromPath(getCurrenttemplatePath())#Test.cfc">
<cfsetting showdebugoutput="no">