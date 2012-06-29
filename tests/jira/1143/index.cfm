<cfsetting showdebugoutput="no">

<cfset accessKeyId = "...">
<cfset awsSecretKey = "...">

<cfset root="s3://#accessKeyId#:#awsSecretKey#@s3.amazonaws.com/">
<cfset dir=root&"jira1143/">
<cfset _file=dir&"test.txt">
<cfif not DirectoryExists(dir)>
	<cfdirectory directory="#dir#" action="create">
</cfif>
<cffile action="write" addnewline="no" file="#_file#" output="text1" fixnewline="no">

<cfset list=directoryList(dir)>

<cf_valueEquals left="#arrayLen(list)#" right="1">
<cf_valueEquals left="#listLast(list[1],'@')#" right="/jira1143/test.txt">