<cfsetting showdebugoutput="no">
<cfset dir=GetDirectoryFromPath(GetCurrentTemplatePath())>


<cffile action="copy" source="#dir#a.pdf" destination="#dir#a1.pdf">
<cffile action="copy" source="#dir#b.pdf" destination="#dir#b1.pdf">



<cfpdf action="merge" 
	source="#dir#a1.pdf,#dir#b1.pdf"
	destination="#dir#c.pdf"
	overwrite="true">

<cffile action="delete" file="#dir#c.pdf">
<cffile action="delete" file="#dir#a1.pdf">
<cffile action="delete" file="#dir#b1.pdf">