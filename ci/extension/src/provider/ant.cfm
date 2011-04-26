<cfset props = {
			"dist":expandPath("/") & "../dist",
			"extension.extensionDownloadURL":"/"
			} />
<cfdump var="#props#">


<cfparam name="target" default="build-test" />

<cfdirectory action="list" directory="./../../../" name="src">
<ul>
	<li><a href="?build=all">Build All</a> | <a href="?build=all&ignore-build-errors=1">Build All Ignore</a></li>
<cfoutput query="src">
  <cfif fileExists(directory & "/#name#/build/build.xml")>
		<li>#name# :
			<a href="?build=#name#&target=build">build</a> |
			<a href="?build=#name#">build-test</a> |
			<a href="?build=#name#&ignore-build-errors=1">build-ignore-error</a> |
			<a href="?build=#name#">build-revision</a></li>
		<cfif structKeyExists(url,"build") AND url.build eq name OR structKeyExists(url,"build") AND url.build eq "all">
			<cfif structKeyExists(url,"ignore-build-errors")>
			  <cfset props["mxunit.haltonerror"] = false />
			<cfelse>
			  <cfset props["mxunit.haltonerror"] = true />
			</cfif>
			<cf_antrunner antfile="#directory#/#name#/build/build.xml" properties="#props#" target="#target#" resultsVar="antres"/>
			<cfif antres.errortext eq "">
				<pre>#antres.outtext#</pre>
				<li>Success <a href="file://#directory#/#name#/build/testresults/html/index.html">Test Results</a></li>
			<cfelse>
				<li>Fail: #antres.errortext#</li>
			</cfif>
		</cfif>
	</cfif>
</cfoutput>
</ul>
