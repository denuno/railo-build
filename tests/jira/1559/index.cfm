<cfsetting showdebugoutput="no">


<cfscript>
function removeWS(str) {
	return REReplace(str, "[[:space:]]+", "", "ALL");
}
</cfscript>
<cfset current=GetDirectoryFromPath(getCurrentTemplatePath())>


<cfpdf action="extracttext" source="#current#test.pdf" name="res" />
<cf_valueEquals left="#removeWS(res)#" right='<?xmlversion="1.0"encoding="UTF-8"?><DocText><TextPerPage><PagepageNumber="1">CFDocumentPDFtestForm</Page></TextPerPage></DocText>'>
