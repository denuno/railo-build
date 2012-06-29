<cfsetting showdebugoutput="no">

<cfset current=GetDirectoryFromPath(GetCurrentTemplatePath())>
<cfset tmpName="E1466">

<cffunction name="doesTableExist" returntype="boolean">
    <cftry>
        <cfquery name="local.test">
        select * from #tmpName#
        </cfquery>
        <cfreturn true>
    	<cfcatch>
        	<cfreturn false>
        </cfcatch>
    </cftry>
</cffunction>

<cffunction name="doesEntityExist" returntype="boolean">
    <cftry>
        <cfset entityNew(tmpName)>
        <cfreturn true>
    	<cfcatch>
        	<cfreturn false>
        </cfcatch>
    </cftry>
</cffunction>


<cffile action="copy" 
	source="#current#cfc.template" 
    destination="#current##tmpName#.cfc">
    
<cfset ormReload()>
<cf_valueEquals left="#doesTableExist()#" right="#true#">
<cf_valueEquals left="#doesEntityExist()#" right="#true#">


<cffile action="delete" file="#current##tmpName#.cfc">

<cfset ormReload()>
<cf_valueEquals left="#doesTableExist()#" right="#true#">
<cf_valueEquals left="#doesEntityExist()#" right="#false#">