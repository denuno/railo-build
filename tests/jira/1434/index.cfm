<cfsetting showdebugoutput="no">
<cfset accessKeyId = "1DHC5C5FVD7YEPR4DBG2"> 
<cfset awsSecretKey = "R/sOy3hgimrI8D9c0lFHchoivecnOZ8LyVmJpRFQ"> 

<cfset root="s3://#accessKeyId#:#awsSecretKey#@s3.amazonaws.com/">
<cfset dir=root&"1434/">
<cfset _file=dir&"test.txt">
<cfif not DirectoryExists(dir)>
	<cfdirectory directory="#dir#" action="create" mode="777" >
</cfif>

<cffile action="write" addnewline="no" file="#_file#" output="text1" fixnewline="no">
<cffile action="read" file="#_file#" variable="text">
<cf_valueEquals left="#text#" right="text1">


<cfset fileWrite(_file,"text1434")>
<cfset text=FileRead(_file)>
<cf_valueEquals left="#text#" right="text2">
