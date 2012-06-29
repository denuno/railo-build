<cfoutput>
/*
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
$Id: basic.cfm 1286 2009-01-21 08:07:06Z peterfarrell $

Created version: 1.0.0
Updated version: 1.0.0
*/

* {
margin: 0;
padding: 0;		
}

html {
	font-size: 100.1%; /* IE hack */
}

body {
	font: 0.75em/1.5em Arial, Helvetica, sans-serif;
	margin:0;
	background: ##FFF url(#BuildUrl("sys.serveAsset", "path=@img@headerBk.jpg")#) top left repeat-x;
}

hr {
	padding: 0;
	border: 0;
	color: ##D0D0D0;
	background-color: ##D0D0D0;
	height: 1px;
	margin: 2em 0 2em 0;
}

table {
	width:100%;
	border: 0;
}

table tr {
	border: 0;
}

table td {
	border: 0;
	vertical-align: top;
}

a, a:visited, a:hover {
	text-decoration: none;
	color: ##1878B2;
}

img {
	border: 0;
	padding: 0;
}

h1 { font-size: 150%; margin: 1em 0 1em 0; color: ##000; }

h2 { font-size: 135%; margin: 0; color: ##1878B2; }

h3 { font-size: 120%; margin: 0; color: ##1878B2; }

h4 { font-size: 100%; font-weight: bold; margin: 0; }

.small { font-size: 0.9em }
.green, .green a, .green a:visited, .green a:hover {
	color: ##6BB300;
}

.red, .red a, .red a:visited, .red a:hover {
	color: ##CC0000;
}

.right {
	float: right;
}

/* CONTAINER
---------------*/
##container {
	margin: 0 auto 0 auto;
	padding: 0;
	width: 960px;
	text-align: left;
}

/* HEADER
---------------*/
##header {
	margin: 0;
	padding: 0;
	height: 94px;
	position: relative;
}

##logo h3 {
	float: left;
	margin: 8px 0;
	padding: 0;
}

/* NAVTABS
---------------*/

##navTabs {
	position: absolute;
	bottom: 12px;
	right: -3px;
}

##navTabs ul {
	padding: 0;
	margin: 0;
	display: block;
	font-size: 1.1em;
	font-weight: bold;
}

##navTabs li {
	list-style: none;
	float: left;
	padding: 0 3px 0 3px;
}

##navTabs a {
	float: left;
	padding: 6px 15px;
	text-decoration: none;
	color: ##FFF;
	height: 28px;
	voice-family: "\"}\"";
	voice-family: inherit;
	height: 18px;
}

##navTabs a:link, ##navTabs a:visited {
	background-color: ##999;
}

##navTabs a:hover {
	background-color: ##666;
}

##navTabs a.highlight {
	background-color: ##CC0000;
}

/* SERVERINFO
---------------*/

##serverInfo {
	position: absolute;
	top: 0;
	right: 0;
	font-size: 0.9em;
}

##serverInfo ul {
	position: relative;
	list-style-type: none;
	margin: 0;
	padding: 0;
	float: right;
	overflow: hidden;
	padding: 9px 0 9px 2em;
	border-bottom: 1px dotted ##D0D0D0;
	border-right: 1px dotted ##D0D0D0;
	border-left: 1px dotted ##D0D0D0;
	background-color: ##F5F5F5;
	font-size: 0.9em;
}

##serverInfo li {
	list-style-type: none;
	border-left: 1px dotted ##D0D0D0;
	float: left;
	line-height: 1.1em;
	margin: 0 1em 0 -1em;
	padding: 0 1em 0 1em;
}

##serverInfo li:first-child {
	border-left: none;
}

##serverInfo li img {
	vertical-align: middle;
}

##serverInfo strong {
	color: ##0971AF;
}

/* CONTENT
---------------*/

##content {
	margin: 24px 0 24px 0;
	clear: both;
}

##content h1:first-child {
	margin-top: 0;
}

##content h4 img { vertical-align: middle; }

##content div.info {
	font-weight: bold;
	color: ##0971AF;
	padding: 0.5em 0 0.5em 2.5em;
	margin: 0.5em 0 1em 0;
	background: ##E6ECFF url(#BuildUrl("sys.serveAsset", "path=@img@icons@information.png")#) 0.5em center no-repeat;
	border: 1px solid ##0971AF;
	border-top: 6px solid ##0971AF;
}

##content div.success {
	font-weight: bold;
	color: ##6BB300;
	padding: 0.5em 0 0.5em 2.5em;
	margin: 0.5em 0 1em 0;
	background: ##E9FFE6 url(#BuildUrl("sys.serveAsset", "path=@img@icons@tick.png")#) 0.5em center no-repeat;
	border: 1px solid ##6BB300;
	border-top: 6px solid ##6BB300;
}

##content div.exception {
	font-weight: bold;
	color: ##CC0000;
	padding: 0.5em 0 0.5em 2.5em;
	margin: 0.5em 0 1em 0;
	background: ##FFE6E6 url(#BuildUrl("sys.serveAsset", "path=@img@icons@exclamation.png")#) 0.5em center no-repeat;
	border: 1px solid ##CC0000;
	border-top: 6px solid ##CC0000;
}

##content .twoColumn {
}

##content .twoColumn .left {
	padding: 0 24px 0 0;
    float:left;
}

##content .twoColumn .right {
    padding: 0 0 0 24px;
    border-left: 1px dotted ##D0D0D0;
    float:right;
}

hr {
	padding: 0;
	border: 0;
	color: ##D0D0D0;
	background-color: ##D0D0D0;
	height: 1px;
	margin: 2em 0 2em 0;
}

div.line hr { /* take out the troublemaking HR */
	display:none;
}
div.line { /* DIV that wraps and replaces the HR */
	height: 1px;
	border-bottom: 1px dotted ##D0D0D0;
	height: 1px;
	margin: 2em 0 2em 0;
	padding: 0;
	clear:both;
}

##content .icon img {
	vertical-align: middle;
}

##content ul {
	padding-left: 2em;
	list-style-type: disc;
}

##content ul.none {
	padding-left: 0;
	list-style-type: none;
}

##content table .shade {
	background-color: ##F5F5F5;
}

##content table.none td {
	border: none;
}

##content table th {
	padding: 0.5em;
	color: ##FFF;
	background-color: ##999;
	border-top: 1px solid ##666;
	border-bottom: 1px solid ##666; 
}

##content table th h3 {
	color: ##FFF; 
}

##content table td {
	padding: 0.5em;
	border-top: 1px dotted ##D0D0D0;
	border-bottom: 1px dotted ##D0D0D0;
}

##content table td hr {
	margin: 1em 0 1em 0;
}

##content table td .shade {
	background-color: ##F5F5F5;
}

##content table table td {
	border: none;
	padding: 0;
	margin: 0;
}


/* pageNav
---------------*/

.pageNavTabs {
	margin: 2em 0 2em 0;
	padding: 1em 0 1em 0;
	overflow: hidden;
	border-top: 1px dotted ##D0D0D0;
	border-bottom: 1px dotted ##D0D0D0;
}

.pageNavTabs ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	float: right;
	width: 960px;
}

.pageNavTabs li {
	list-style-type: none;
	border-left: 1px dotted ##D0D0D0;
	float: left;
	line-height: 1.1em;
	margin: 0 1em 0 -1em;
	padding: 0 1em 0 1em;
}

.pageNavTabs li:first-child {
	border-left: none;
}

.pageNavTabs li img {
	vertical-align: bottom;
}

.pageNavTabs a, .pageNavTabs a:visited {
}

/* FOOTER
---------------*/

##footer {
	clear: both;
	padding: 24px 0 24px 0;
}

##footer div {
	padding: 12px 0 12px 0;
	border-top: 1px dotted ##D0D0D0;
	border-bottom: 1px dotted ##D0D0D0;
}

##footer p {
	font-size: 0.9em;
	color: ##666;
}

##footer p img {
	vertical-align: top;
}
</cfoutput>