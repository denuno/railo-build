<cfsetting showdebugoutput="no">

<cfset text="S#chr(228)#l#chr(252)# z#chr(228)#me"><!--- ACF was not able to read the specal char from template, because of that the chr function is used --->
<cfparam name="cookie.greeting" default="#text#">
<cfset cookie.greeting2=text>
<cfif not structKeyExists(cookie,'greeting3')><cfcookie name="greeting3" value="#text#"></cfif>
<cfcookie name="greeting4" value="#text#">

<cf_valueEquals left="#cookie.greeting#" right="#text#"><!--- ACF does not decode in this case --->
<cf_valueEquals left="#cookie.greeting2#" right="#text#">
<cf_valueEquals left="#cookie.greeting3#" right="#text#">
<cf_valueEquals left="#cookie.greeting4#" right="#text#">