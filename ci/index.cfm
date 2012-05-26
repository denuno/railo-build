<!DOCTYPE HTML>
<html>
<head>
	<title>CI</title>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/styles.css">
	<cfparam name="rc.js" default="#[]#">
	<style>
		BODY {
			padding-top:60px;
		}
	</style>
	<cflock scope="server" timeout="3">
		<cfif not structKeyExists(server,"ci")>
			<cfset server.ci = {"started"=now(),"runs"=arrayNew(1)} />
			<cfset server.ci.runningbuild = "false" />
		</cfif>
		<cfset request.runningbuild = server.ci.runningbuild />
	</cflock>
	<meta http-equiv="refresh" content="30" />
</head>
<body>
<cfoutput>
	<cfif structKeyExists(url,"forceidle")>
		<cfset server.ci.runningbuild = false />
		<cflocation url="index.cfm" addtoken="false"/>
	</cfif>
	<div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="brand" href="?">Railo Build System</a>
          <div class="nav-collapse">
            <ul class="nav">
             <li class="">
                <a href="">Build a Branch</a>
              </li>
             <li class="<!--- active --->">
                <a href="">Repo</a>
              </li>
			  <li><a href="">Documentation</a></li>
			  <li><a href="?list">List</a></li>
			  <li><a href="?forceidle" onclick="return confirm('Force idle status?')">STATUS:</a></li>
			  <li><span #(server.ci.runningbuild ? "style='color:yellow'><em>running build</em>" : "style='color:green'><b>idle</b>")# #server.ci.startedbuild#</span></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
	</cfoutput>

	<div class="container-fluid">

<h2>Continious Integration</h2>
<form action="ci.cfm" method="get">
	<cfset variables.buildDirectory = getDirectoryFromPath(getCurrentTemplatePath()) & "../build/" />
	<cf_antrunner antfile="#variables.buildDirectory#build.xml" action="getTargets" target="help" />
	<cfdump var="#cfantrunner#">
	<select name=""></select>
</form>
<h3><a href="ci.cfm?target=build">Run a Build</a></h3>
<cfdirectory name="builds" action="list" directory="#expandPath('/../dist/rc')#" filter="*.rc">
<h3>Available builds (<cfoutput>#builds.recordcount#</cfoutput>)</h3>
<cfloop query="builds">
	<cfoutput><a href="./#name#">#name#</a> #numberFormat(size/(1024*1000),"_.__")#M #dateFormat(dateLastModified,"mm/dd/yyy")# <a href="./commit.#listGetAt(name,5,".")#.log">details</a></cfoutput><br />
</cfloop>

<cfset runsDir = expandPath('/../dist/buildlog') />
<cfdirectory name="runs" action="list" directory="#runsDir#" filter="*.json">
<cfoutput>
	<h3><a href="?list">#runs.recordcount# Runs</a></h3>
<cfif structKeyExists(url,"list")>
	<cfloop query="runs">
		<cfset runinfo = deserializeJSON(fileRead(runsDir & "/" & name)) />
		ID <a href="?info=#runinfo.id#">#runinfo.id#</a><br />
		Status: #runinfo.status# Started: #runinfo.started#  Ended: #runinfo.ended#
		(#dateDiff("n",runinfo.started,runinfo.ended)# mins #dateDiff("s",runinfo.started,runinfo.ended)# secs)<br />
		<pre>#runinfo.errortext#</pre>
	</cfloop>
</cfif>
<cfif structKeyExists(url,"info")>
	<cfset runinfo = deserializeJSON(fileRead(runsDir & "/" & info & ".json")) />
		Status: #runinfo.status# Started: #runinfo.started#  Ended: #runinfo.ended#
		(#dateDiff("n",runinfo.started,runinfo.ended)# mins #dateDiff("s",runinfo.started,runinfo.ended)# secs)<br />
		<pre>#runinfo.errortext#</pre>
		<pre>#runinfo.outtext#</pre>
	<cfabort>
</cfif>

</cfoutput>

<cfif structKeyExists(server,"ci")>
	<cfset x = 1>
	<cfloop array="#server.ci.runs#" index="runinfo">
		<cfif runinfo.status != "run" || len(runinfo.errortext)>
			<cfoutput>
			<h4>Run #x++#</h4>
			Status: #runinfo.status# Started: #runinfo.started#  Ended: #runinfo.ended#<br />
			<pre>#runinfo.errortext#</pre>
			<hr />
			</cfoutput>
		</cfif>
	</cfloop>
	<cfoutput><em>Server started #server.ci.started#</em></cfoutput>
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