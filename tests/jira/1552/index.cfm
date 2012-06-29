<cfsetting showdebugoutput="no">

<cfset current=GetDirectoryFromPath(GetCurrentTemplatePath())>

<cffile action="write" file="#current#test.txt" output="" />
<cf_valueEquals left="#fileExists("#current#test.txt")#" right="true">

<cffile action="rename" source="#current#test.txt" destination="#current#test.txt" />
<cf_valueEquals left="#fileExists("#current#test.txt")#" right="true">