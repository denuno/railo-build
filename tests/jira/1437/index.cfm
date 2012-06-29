<cfsetting showdebugoutput="no">

<cfset contentout_xmlobj = xmlParse('<?xml version="1.0" encoding="UTF-8"?><body><element id="1"/><element id="2"/></body> ')>
<cf_valueEquals left="#arrayLen(contentout_xmlobj.body.XmlChildren)#" right="2">

<cfset arrayDeleteAt(contentout_xmlobj.body.element, 1)>
<cf_valueEquals left="#arrayLen(contentout_xmlobj.body.XmlChildren)#" right="1">

<cfset arrayDeleteAt(contentout_xmlobj.body.element, 1)>
<cf_valueEquals left="#arrayLen(contentout_xmlobj.body.XmlChildren)#" right="0">


<cfset contentout_xmlobj = xmlParse('<?xml version="1.0" encoding="UTF-8"?><body><element id="1"/><element id="2"/></body> ')>
<cf_valueEquals left="#arrayLen(contentout_xmlobj.body.XmlChildren)#" right="2">

<cfset arrayDeleteAt(contentout_xmlobj.body.XmlChildren, 1)>
<cf_valueEquals left="#arrayLen(contentout_xmlobj.body.XmlChildren)#" right="1">

<cfset arrayDeleteAt(contentout_xmlobj.body.XmlChildren, 1)>
<cf_valueEquals left="#arrayLen(contentout_xmlobj.body.XmlChildren)#" right="0">

