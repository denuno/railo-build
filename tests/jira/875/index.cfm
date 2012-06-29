<cfsetting showdebugoutput="no">

<cffunction name="getFunctionMeta">
	<cfargument name="meta" type="struct" required="yes">
	<cfargument name="name" type="string" required="yes">
    <cfloop array="#meta.functions#" index="local.fm">
    	<cfif fm.name EQ name>
        	<cfreturn fm>
        </cfif>
    </cfloop>
</cffunction>


<cfscript>
function removeWS(str) {
	return REReplace(str, "[[:space:]]+", "", "ALL");
}
</cfscript>




<cfset test=new Test()>
<cfset meta=getMetaData(test)>
<cf_valueEquals left="#removeWS(meta.hint)#" right="hintparam">
<cf_valueEquals left="#removeWS(meta.fromDocComment)#" right="hellofromdoccomment">
<cf_valueEquals left="#removeWS(meta.fromCFC)#" right="hellofromCFC">




<cfset test1=getFunctionMeta(meta,"test1")>

<cf_valueEquals left="#removeWS(test1.hint)#" right="HelloWorldaabb*howareyou">

<cf_valueEquals left="#removeWS(test1.susi1)#" right="susanne1">
<cf_valueEquals left="#removeWS(test1.susi2)#" right="susisorglos">
<cf_valueEquals left="#removeWS(test1.susi3)#" right="#true#">
<cf_valueEquals left="#removeWS(test1['@'])#" right="#true#">

<cfset test2=getFunctionMeta(meta,"test2")>
<cf_valueEquals left="#removeWS(test2.hint)#" right="HelloWorld">

<cfset test3=getFunctionMeta(meta,"test3")>
<cfset params=test3.parameters>
<cf_valueEquals left="#removeWS(params[1].hint)#" right="LastName">
<cf_valueEquals left="#removeWS(params[2].hint)#" right="FirstName">
<cf_valueEquals left="#removeWS(params[2].urs)#" right="Urs">
<cf_valueEquals left="#removeWS(params[2]['a.b.c'])#" right="ABC">


<cfset impl=meta.implements.ITest>
<cf_valueEquals left="#removeWS(impl.hint)#" right="abcdef">
<cf_valueEquals left="#removeWS(impl.fromDocComment)#" right="hellofromdoccommentininterface">


<cfset params=impl.functions[1].parameters>
<cf_valueEquals left="#removeWS(params[1].hint)#" right="LastName">
<cf_valueEquals left="#removeWS(params[2].hint)#" right="FirstName">
<cf_valueEquals left="#removeWS(params[2].urs)#" right="Urs">
<cf_valueEquals left="#removeWS(params[2]['a.b.c'])#" right="ABC">