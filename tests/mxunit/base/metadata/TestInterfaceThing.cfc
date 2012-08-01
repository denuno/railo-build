<cfcomponent extends="mxunit.framework.TestCase">

	<cfscript>
		private function removeWS(str) {
			return REReplace(str, "[[:space:]]+", "", "ALL");
		}
	</cfscript>

	<cffunction name="getFunctionMeta" access="private">
		<cfargument name="meta" type="struct" required="yes">
		<cfargument name="name" type="string" required="yes">
	    <cfloop array="#meta.functions#" index="local.fm">
	    	<cfif fm.name EQ name>
	        	<cfreturn fm>
	        </cfif>
	    </cfloop>
	</cffunction>

	<cffunction name="testJira875">
		<cfset test=new AObject()>
		<cfset meta=getMetaData(test)>
		<cfset assertEquals("#removeWS(meta.hint)#","hintparam")>
		<cfset assertEquals("#removeWS(meta.fromDocComment)#","hellofromdoccomment")>
		<cfset assertEquals("#removeWS(meta.fromCFC)#","hellofromCFC")>
		<cfset test1 = getFunctionMeta(meta,"test1")>
		<cfset assertEquals("#removeWS(test1.hint)#","HelloWorldaabb*howareyou")>
		<cfset assertEquals("#removeWS(test1.susi1)#","susanne1")>
		<cfset assertEquals("#removeWS(test1.susi2)#","susisorglos")>
		<cfset assertEquals("#removeWS(test1.susi3)#","#true#")>
		<cfset assertEquals("#removeWS(test1['@'])#","#true#")>
		<cfset test2=getFunctionMeta(meta,"test2")>
		<cfset assertEquals("#removeWS(test2.hint)#","HelloWorld")>
		<cfset test3=getFunctionMeta(meta,"test3")>
		<cfset params=test3.parameters>
		<cfset assertEquals("#removeWS(params[1].hint)#","LastName")>
		<cfset assertEquals("#removeWS(params[2].hint)#","FirstName")>
		<cfset assertEquals("#removeWS(params[2].urs)#","Urs")>
		<cfset assertEquals("#removeWS(params[2]['a.b.c'])#","ABC")>
		<cfset impl=meta.implements.IAObject>
		<cfset assertEquals("#removeWS(impl.hint)#","abcdef")>
		<cfset assertEquals("#removeWS(impl.fromDocComment)#","hellofromdoccommentininterface")>
		<cfset params=impl.functions[1].parameters>
		<cfset assertEquals("#removeWS(params[1].hint)#","LastName")>
		<cfset assertEquals("#removeWS(params[2].hint)#","FirstName")>
		<cfset assertEquals("#removeWS(params[2].urs)#","Urs")>
		<cfset assertEquals("#removeWS(params[2]['a.b.c'])#","ABC")>
	</cffunction>

</cfcomponent>
