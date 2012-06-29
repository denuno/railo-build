<cfsetting showdebugoutput="no">
<cfset request.base=replace(request.base,8501,8080)>
<cfset str="#chr(228)##chr(246)##chr(252)#">

<!--- File --->
<cfdirectory directory="#request.current#" action="list" name="dir" filter="*.gif" recurse="no" >
<cfloop query="dir">
<cfhttp url="#request.base#file.cfm" method="POST" charset="utf-8" multipart="yes">
	<cfset key=replace(dir.name,".gif","")>
    <cfhttpparam name="#key#" type="FILE" file="#request.current##dir.name#">
</cfhttp>
<cf_valueEquals left="#trim(cfhttp.FileContent)#" right="#key#-#dir.name#">
</cfloop>

<!--- formfield --->
<cfhttp url="#request.base#formfield.cfm" method="POST" charset="utf-8" multipart="no">
	<cfhttpparam type="formfield" name="#str#" value="#str#">
</cfhttp>
<cf_valueEquals left="#trim(cfhttp.FileContent)#" right="#str#=#str#">

<!--- formfield multipart --->
<cfhttp url="#request.base#formfield.cfm" method="POST" charset="utf-8" multipart="yes">
	<cfhttpparam type="formfield" name="#str#" value="#str#">
</cfhttp>
<cf_valueEquals left="#trim(cfhttp.FileContent)#" right="#str#=#str#">

<!--- url --->
<cfhttp url="#request.base#url.cfm" method="POST" charset="utf-8" multipart="no">
	<cfhttpparam type="url" name="#str#" value="#str#">
</cfhttp>

<cf_valueEquals left="#trim(cfhttp.FileContent)#" right="#str#=#str#">

<!--- url multipart --->
<cfhttp url="#request.base#url.cfm" method="POST" charset="utf-8" multipart="yes">
	<cfhttpparam type="url" name="#str#" value="#str#">
</cfhttp>

<cf_valueEquals left="#trim(cfhttp.FileContent)#" right="#str#=#str#">


<!--- cookie --->
<cfhttp url="#request.base#cookie.cfm" method="POST" charset="utf-8" multipart="no">
	<cfhttpparam type="cookie" name="#str#" value="#str#">
</cfhttp>

<cf_valueEquals left="#trim(cfhttp.FileContent)#" right="#str#=#str#">



<!--- cookie multipart --->
<cfhttp url="#request.base#cookie.cfm" method="POST" charset="utf-8" multipart="yes">
	<cfhttpparam type="cookie" name="#str#" value="#str#">
</cfhttp>

<cf_valueEquals left="#trim(cfhttp.FileContent)#" right="#str#=#str#">


<!--- cgi --->
<cfhttp url="#request.base#cgi.cfm" method="POST" charset="utf-8" multipart="no">
	<cfhttpparam type="cgi" name="#str#" value="#str#">
	<cfhttpparam type="cgi" name="aaa" value="#str#">
</cfhttp>

<cf_valueEquals left="#trim(cfhttp.FileContent)#" right="#str#=#str#">

<!--- cgi multipart --->
<cfhttp url="#request.base#cgi.cfm" method="POST" charset="utf-8" multipart="yes">
	<cfhttpparam type="cgi" name="#str#" value="#str#">
	<cfhttpparam type="cgi" name="aaa" value="#str#">
</cfhttp>

<cf_valueEquals left="#trim(cfhttp.FileContent)#" right="#str#=#str#">





