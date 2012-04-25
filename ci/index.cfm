<!DOCTYPE HTML>
<html>
<head>
	<title>Extension Builder SDK</title>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/styles.css">
	<cfparam name="rc.js" default="#[]#">
	<style>
		BODY {
			padding-top:60px;
		}
	</style>
</head>
<body>
<cfoutput>
	<div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="brand" href="">Railo Build System</a>
          <div class="nav-collapse">
            <ul class="nav">
             <li class="">
                <a href="">Build a Branch</a>
              </li>
             <li class="<!--- active --->">
                <a href="">Repo</a>
              </li>
			  <li><a href="">Documentation</a></li>
			  <li><a href="">Resources</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
	</cfoutput>

	<div class="container-fluid">


<cfset distDir = expandPath('/../dist') />
<cfdirectory name="builds" action="list" directory="#distDir#" filter="*.rc">
<cfif structKeyExists(url,"list")>
	<cfset json = "[ " />
	<cfloop query="builds">
		<cfset json &= "{'name':" & serializeJSON(builds["name"][currentrow]) & ",'size':" &
		serializeJSON(builds["size"][currentrow]) & ",'built':" & serializeJSON(builds["dateLastModified"][currentrow]) & "},">
	</cfloop>
	<cfoutput>#left(json,len(json)-1)#]</cfoutput>
	<cfabort>
</cfif>
<cfif structKeyExists(url,"info")>
	<cfif listLen(url.buildid,".") eq 6>
		<cfset logfile = "commit." & listGetAt(url.buildid,5,".") & ".log">
	<cfelse>
		<cfset logfile = "commit.log">
	</cfif>
	<cffile action="read" file="#distDir#/#logFile#" variable="commitlog">
	<cfset json = "{'commits':" & serializeJSON(commitLog) & "}">
	<cfoutput>#json#</cfoutput>
	<cfabort>
</cfif>
<h2>Continious Integration</h2>
<h3><a href="ci.cfm?target=build">Run a Build</a></h3>
<h3>Available builds</h3>
<cfdirectory name="builds" action="list" directory="#expandPath('/../dist')#" filter="*.rc">
<cfloop query="builds">
	<cfoutput><a href="./#name#">#name#</a>  <a href="./commit.#listGetAt(name,5,".")#.log">build log</a></cfoutput><br />
</cfloop>

<cfif structKeyExists(server,"ci")>
<cfdump var="#server.ci#">
</cfif>

	 <hr>
	 <footer class="footer">
        <p class="pull-right"><a href="#">Back to top</a></p>
     </footer>

	</div>


	  <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
<!---     <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script> --->
    <script src="/js/jquery.js"></script>
    <script src="/js/google-code-prettify/prettify.js"></script>
    <script src="/js/bootstrap-transition.js"></script>
    <script src="/js/bootstrap-alert.js"></script>
    <script src="/js/bootstrap-modal.js"></script>
    <script src="/js/bootstrap-dropdown.js"></script>
    <script src="/js/bootstrap-scrollspy.js"></script>
    <script src="/js/bootstrap-tab.js"></script>
    <script src="/js/bootstrap-tooltip.js"></script>
    <script src="/js/bootstrap-popover.js"></script>
    <script src="/js/bootstrap-button.js"></script>
    <script src="/js/bootstrap-collapse.js"></script>
    <script src="/js/bootstrap-carousel.js"></script>
    <script src="/js/bootstrap-typeahead.js"></script>
    <script src="/js/jquery.form.js"></script>
    <script src="/js/tooltips.js"></script>
    <script src="/js/upload.js"></script>
	<cfloop array="#rc.js#" index="js">
	<cfoutput>#js#</cfoutput>
	</cfloop>
</body>
</html>