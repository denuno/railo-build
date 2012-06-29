<cfsetting showdebugoutput="no">
<cfset entities=entityLoad("systemLogdata")>

<cf_valueEquals left="#arrayLen(entities)#" right="1">
<cfset entity=entities[1]>
<cfset str=entity.getStr()>

<cf_valueEquals left="#isDate(str)#" right="1">
<cfset diff=DateDiff("s",str,now())>
<cf_valueEquals left="#diff GTE -5 and diff LTE 5#" right="1">
