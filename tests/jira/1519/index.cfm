<cfset accessKeyId = "...">
<cfset awsSecretKey = "...">

<cfset root="s3://#accessKeyId#:#awsSecretKey#@s3.amazonaws.com/">
<cfset dir=root&"jira1519/">
<cfset _file=dir&"test.txt">
<cfif DirectoryExists(dir)>
	<cfdirectory directory="#dir#" action="delete" recurse="yes">
</cfif>


<cfset perm = [{group="all", permission="full_control"}]>
<cfdirectory directory="#dir#" action="create" storeACL="#perm#" storeLocation="EU">

<cfset acl=storeGetACL(dir)>
<cf_valueEquals left="#arrayLen(acl)#" right="1">
<cf_valueEquals left="#acl[1].group#" right="all">
<cf_valueEquals left="#acl[1].permission#" right="FULL_CONTROL">



<cffile action="write" addnewline="no" file="#_file#" output="text1" fixnewline="no" storeACL="#perm#">

<cfset acl=storeGetACL(_file)>
<cf_valueEquals left="#arrayLen(acl)#" right="1">
<cf_valueEquals left="#acl[1].group#" right="all">
<cf_valueEquals left="#acl[1].permission#" right="FULL_CONTROL">



