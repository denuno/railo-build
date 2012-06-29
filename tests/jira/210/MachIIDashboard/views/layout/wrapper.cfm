<!---
License:
Copyright 2008 GreatBizTools, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Copyright: GreatBizTools, LLC
$Id: wrapper.cfm 1269 2009-01-14 22:54:21Z peterfarrell $

Created version: 1.0.0
Updated version: 1.0.0

Notes:
 - Leave cfcontent reset next to DocType to remove a line break that cause some browsers to go into quirks mode
--->
<cfoutput><cfcontent reset="true" /><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>#event.getArg("meta.title")# | Dashboard (#cgi.SERVER_NAME#)</title>
	<link rel="stylesheet" type="text/css" href="#BuildUrl("sys.serveAsset", "path=@css@basic.css")#" media="screen,projection" />
	<link rel="shortcut icon" type="image/x-icon" href="#BuildUrl("sys.serveAsset", "path=@img@favicon.ico")#" />
	<link rel="icon" type="image/x-icon" href="#BuildUrl("sys.serveAsset", "path=@img@favicon.ico")#" />
<cfif event.isArgDefined("meta.refresh")>
	<meta http-equiv="refresh" content="#event.getArg("meta.refresh")#"/>
</cfif>
	<meta http-equiv="Pragma" content="no-cache,no-store" />
	<meta http-equiv="Cache-Control" content="no-cache,no-store,must-revalidate,max-age=0" />
	<meta http-equiv="Expires" content="Sat, 05 Jul 1997 07:00:00 GMT" />
	<cfset addHTTPHeaderByName("Pragma", "no-cache,no-store") />
	<cfset addHTTPHeaderByName("Cache-Control", "no-cache,no-store,must-revalidate,max-age=0") />
	<cfset addHTTPHeaderByName("Expires", "Sat, 05 Jul 1997 07:00:00 GMT") />

	<script type="text/javascript" src="#BuildUrl("sys.serveAsset", "path=@js@generic.js")#"></script>
</head>
<body>
<div id="container">

<div id="header">
	#event.getArg("layout.header")#
</div>

<div id="content">
	#event.getArg("layout.content")#
</div>

<div id="footer">
	#event.getArg("layout.footer")#
</div>

</div>
</body>
</html></cfoutput><cfsetting enablecfoutputonly="true" />