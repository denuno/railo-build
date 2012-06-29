<cfsetting showdebugoutput="no">


<cffunction name="test">
	<cfargument name="del" type="string" required="yes">
	
    <cf_valueEquals left="#arrayLen(listtoarray("",del,true))#" right="1">
    <cf_valueEquals left="#arrayLen(listtoarray("",del,false))#" right="0">
    
    <cf_valueEquals left="#arrayLen(listtoarray("a",del,true))#" right="1">
    <cf_valueEquals left="#arrayLen(listtoarray("#del#",del,true))#" right="2">
    <cf_valueEquals left="#arrayLen(listtoarray("#del#x#del#",del,true))#" right="3">
    <cf_valueEquals left="#arrayLen(listtoarray("#del#x#del##del#y",del,true))#" right="4">
    
</cffunction>

<cfset test(chr(9))>
<cfset test(',')>
