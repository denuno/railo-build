<cfsetting showdebugoutput="no" requesttimeout="2">

<cftry>
	<cfif server.ColdFusion.ProductName EQ "Railo">
    	<cfset test=createObject('java','test1472.TestException',"test1472.jar").init("THIS IS THE MESSAGE")>
    <cfelse>
    	<cfset test=createObject('java','test1472.TestException').init("THIS IS THE MESSAGE")>
    </cfif>
	
    
	<cfset test.doThrow()>
    <cfcatch>
		<cf_valueEquals left="#cfcatch.bool#" right="#false#">
		<cf_valueEquals left="#cfcatch.isBool()#" right="#false#">
        <cfset cfcatch.setBool(true)>
        <cf_valueEquals left="#cfcatch.bool#" right="#true#">
		<cf_valueEquals left="#cfcatch.isBool()#" right="#true#">
        
        
    </cfcatch>
</cftry>



<cftry>
	<cfif server.ColdFusion.ProductName EQ "Railo">
        <cfset test=createObject('java','test1472.TestException',"test1472.jar").init("THIS IS THE MESSAGE","String",true,{a="www"},['a','b'])>
    <cfelse>
        <cfset test=createObject('java','test1472.TestException').init("THIS IS THE MESSAGE","String",true,{a="www"},['a','b'])>
    </cfif>
    <cfset test.doThrow()>
    <cfcatch>
        
        <!--- bool --->
        <cf_valueEquals left="#cfcatch.bool#" right="#true#">
		<cf_valueEquals left="#cfcatch.isBool()#" right="#true#">
        <cfset cfcatch.setBool(false)>
		<cf_valueEquals left="#cfcatch.bool#" right="#false#">
		<cf_valueEquals left="#cfcatch.isBool()#" right="#false#">
        
        <!--- str --->
        <cf_valueEquals left="#cfcatch.str#" right="String">
		<cf_valueEquals left="#cfcatch.getStr()#" right="String">
        <cfset cfcatch.setStr("String2")>
        <cf_valueEquals left="#cfcatch.str#" right="String2">
		<cf_valueEquals left="#cfcatch.getStr()#" right="String2">
        <cfset cfcatch.str="String3">
        <cf_valueEquals left="#cfcatch.str#" right="String3">
		<cf_valueEquals left="#cfcatch.getStr()#" right="String3">
        
        
        <!--- map --->
        <cf_valueEquals left="#serializeJson(cfcatch.map)#" right='{"A":"www"}'>
        <cf_valueEquals left="#serializeJson(cfcatch.getMap())#" right='{"A":"www"}'>
        <!--- list --->
        <cf_valueEquals left="#serializeJson(cfcatch.list)#" right='["a","b"]'>
        <cf_valueEquals left="#serializeJson(cfcatch.getList())#" right='["a","b"]'>
        
        
        
    </cfcatch>
</cftry>