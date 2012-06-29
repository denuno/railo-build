<cfsetting showdebugoutput="no">
<cfset dest="#request.current#/result/צהü.gif">
<cfloop list="#form.fieldnames#" index="key">
    <cffile action="upload" fileField="#key#" destination="#dest#" nameConflict="MakeUnique" result="upload_results">
    <cfoutput>#form.fieldnames#-#upload_results.clientfile#</cfoutput>
</cfloop>


<cfdirectory directory="#request.current#/result/" action="list" name="dir" recurse="no">
<cfloop query="dir">
<cffile action="delete" file="#dir.directory#/#dir.name#">
</cfloop>