<cfsetting showdebugoutput="no">


<cfscript>
function toAscci(str) {
	var len=len(str);
	var i=1;
	var rtn="";
	for(;i<=len;i++) {
		rtn&=asc(mid(str,i,1));
	}
	return rtn;
}
</cfscript>



<cfset Input = 'x#Chr(10)#y' />

<cfsavecontent variable="Output1"><cfoutput>#Input#</cfoutput></cfsavecontent>

<cfset Code = '<cfsavecontent variable="Output2">#Input#</cfsavecontent>' />
<cfset FileWrite('xy.cfm',Code) />
<cfinclude template="xy.cfm" />

<cf_valueEquals left="#toAscci(Input)#" right="12010121">
<cf_valueEquals left="#toAscci(Output1)#" right="12010121">
<cf_valueEquals left="#toAscci(Output2)#" right="12010121">
