<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>


<cfset current=getDirectoryFromPath(getCurrentTemplatePath())>
<cfset _src=current&"test.txt">
<cfset src=current&"test1.txt">
<cfset trg=current&"test2.txt">


<cftry>
<cffile action="delete" file="#trg#" />
<cfcatch></cfcatch>
</cftry>

<cftry>
<cffile action="delete" file="#src#" />
<cfcatch></cfcatch>
</cftry>


<cffile action="copy" source="#_src#" destination="#src#" />


<cffile action="copy" source="#src#" destination="#trg#" />
<cffile action="move" source="#src#" destination="#trg#" />




<cf_valueEquals left="" right="">