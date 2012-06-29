<cfsetting showdebugoutput="no">



 

<cfset accessKeyId = "..."> 
<cfset awsSecretKey = "..."> 

<cfset root="s3://#accessKeyId#:#awsSecretKey#@s3.amazonaws.com/">
<cfset dir=root&"jira1500/">
<cfset subdir=dir&"sub/">
<cfset _file=subdir&"test.txt">


<cfif DirectoryExists(dir)>
	<cfdirectory directory="#dir#" action="delete" recurse="yes">
</cfif>


<cfdirectory directory="#dir#" action="create">
<cfdirectory directory="#subdir#" action="create">
<cffile action="write" addnewline="no" file="#_file#" output="text1" fixnewline="no">

<cfdirectory action="list" name="foo" directory="#root#"/><!--- not supported by ACF --->
<cfdump var="#foo#">
<cfdirectory action="list" name="foo" directory="#dir#"/>
<cfdump var="#foo#">
<cfdirectory action="list" name="foo" directory="#subdir#"/>
<cfdump var="#foo#">

<cffile action="read" file="#_file#" variable="foo" >
<cfdump var="#foo#">
