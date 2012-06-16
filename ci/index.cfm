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
             <li class="selected">
                <a href="ci.cfm?target=build">Build</a>
              </li>
             <li class="">
                <a href="?selectbranch=true">Branch</a>
              </li>
             <li class="nav">
                <a href="?selecttag=true">Tag</a>
              </li>
			  <li><a href="">Docs</a></li>
			  <li><a href="?type=rc">rc</a></li>
			  <li><a href="?type=war">WAR</a></li>
			  <li><a href="?type=cli">CLI</a></li>
			  <li><a href="?type=jar">Jar</a></li>
			  <li><a href="?type=express">Express</a></li>
			  <li><a href="?type=installer">Installer</a></li>
			  <li><a href="?type=rpm">RPM</a></li>
			  <li><a href="?type=libs">Libs</a></li>
			  <li><a href="/artifacts/" target="_blank">ARTIFACTS</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
	</cfoutput>

	<div class="container-fluid">

<cfoutput>
<h2>Continious Integration :
	<cfif server.ci.runningbuild>
		<span style="font-size:88%">
			<a href="?forceidle" onclick="return confirm('Force idle status?')" style="color:green">Running</a> -
			<cfif isDate(server.ci.startedbuild) && server.ci.runningbuild>
				<cfset dtDiff = (parseDateTime(now()) - parseDateTime(server.ci.startedbuild)) />
				#dateDiff( "h",now(),server.ci.startedbuild)# Hour(s),
				#TimeFormat( dtDiff, "m" )# Minute(s),
				#TimeFormat( dtDiff, "s" )# Second(s)
			</cfif>
			<a href="?showoutput=true">output</a>
		</span>
	<cfelse>
	  <span  style="color:silver">Idle</span>
	</cfif>
</cfoutput>



<cfset variables.buildDirectory = getDirectoryFromPath(getCurrentTemplatePath()) & "../build/" />
<!---
<form action="ci.cfm" method="get">
	<cfset variables.buildDirectory = getDirectoryFromPath(getCurrentTemplatePath()) & "../build/" />
	<cf_antrunner antfile="#variables.buildDirectory#build.xml" action="getTargets" target="help" />
	<cfdump var="#cfantrunner#">
	<select name=""></select>
</form>
 --->
<cfif structKeyExists(url,"selectbranch")>
	<cf_antrunner antfile="#variables.buildDirectory#build.xml" resultsVar="antTarget">
		<git command="branch" dir="${src.dir}"><args><arg value="-a"/></args></git>
	</cf_antrunner>
	<cfset branches = listToArray(antTarget.outtext,chr(13)&chr(10)) />
	<cfset arraydeleteat(branches,1) />
	<form action="ci.cfm" method="get">
		Branch: <select name="branch">
		<cfloop array="#branches#" index="branch">
		<cfoutput><option value="#trim(replace(branch,'origin/',''))#">#branch#</option></cfoutput>
		</cfloop>
		</select>
		<input type="submit" name="target" value="build">
	</form>
	<cfoutput><pre>#antTarget.outtext#</pre></cfoutput>
<cfelseif structkeyExists(url,"selecttag")>
	<cf_antrunner antfile="#variables.buildDirectory#build.xml" resultsVar="antTarget">
		<git command="tag" dir="${src.dir}" />
	</cf_antrunner>
	<cfset branches = listToArray(antTarget.outtext,chr(13)&chr(10)) />
	<cfset arraydeleteat(branches,1) />
	<form action="ci.cfm" method="get">
		Branch: <select name="branch">
		<cfloop array="#branches#" index="branch">
		<cfoutput><option value="#trim(replace(branch,'origin/',''))#">#branch#</option></cfoutput>
		</cfloop>
		</select>
		<input type="submit" name="target" value="build">
	</form>
	<cfoutput><pre>#antTarget.outtext#</pre></cfoutput>
<cfelseif structkeyExists(url,"showoutput")>
	<cfif structKeyExists(server,"buildthread")>
		<pre><cfoutput>#toString(server.buildthread.outputstream)#</cfoutput></pre>
	<cfelse>
		<h4>No build currently running.</h4>
	</cfif>
<cfelse>
	<h3>
		<cfset targets = "mvn.deploy.libs,mvn.deploy.core,build.installer,build.cli.all,build.cli.mvn,build.cli,build.cli.exe,build.cli.bin,build.cli.rpm,build.cli.deb,build.cli.express,build.cli.jre">
		<form action="ci.cfm" method="get">
			Target: <select name="target">
			<cfloop list="#targets#" index="target">
			<cfoutput><option value="#target#">#target#</option></cfoutput>
			</cfloop>
			</select>
			<input type="submit" name="submit" value="run">
		</form>
	</h3>

</cfif>
<cfdirectory name="builds" action="list" directory="#expandPath('/../dist/rc')#" filter="*.rc" sort="name DESC">
<cfif structKeyExists(url,"json")>
	<cfset buildsarray = [] />
	<cfloop query="builds">
		<cfset arrayAppend(buildsarray,{name:name,size:size,dateLastModified:dateLastModified}) />
	</cfloop>
	<cfcontent reset="true"><cfoutput>#serializeJSON(buildsarray)#</cfoutput><cfabort>
</cfif>

<cffunction name="listdist">
	<cfargument name="type" />
	<cfdirectory name="dists" action="list" directory="#expandPath('/../dist/#type#')#" sort="name DESC">
	<h3><cfoutput>#type# (#dists.recordcount#</cfoutput>)</h3>
	<table cellpadding="2px">
	<cfloop query="dists">
		<tr>
		<cfoutput>
			<td><a href="./#name#">#name#</a></td>
			<td>#numberFormat(size/(1024*1000),"_.__")#M &nbsp;&nbsp;</td>
			<td>#dateFormat(dateLastModified,"mm/dd/yyyy")# #timeFormat(dateLastModified,"HH:mm tt")# &nbsp;&nbsp;</td>
			<cfif type == "rc">
				<td> <a href="./commit.#listGetAt(name,5,".")#.log" target="_blank">commit log</a></td>
			</cfif>
		</cfoutput>
		</tr>
	</cfloop>
	</table>
</cffunction>
<cfparam name="url.type" default="rc" />
<cfset listdist(url.type) />

<cfset runsDir = expandPath('/../dist/buildlog') />

<cfif structKeyExists(url,"runsclear")>
	<cfset directoryDelete(runsDir,true) />
	<cfset directoryCreate(runsDir) />
	<cfset server.ci.runningbuild = false />
	<cflocation url="index.cfm" addtoken="false"/>
</cfif>

<cfdirectory name="runs" action="list" directory="#runsDir#" filter="*.json" sort="dateLastModified DESC">
<cfoutput>
	<h3><a href="?list">#runs.recordcount# Runs</a> | <a href="?runsclear=true">clear</a></h3>
	<cfif structKeyExists(url,"list")>
		<cfloop query="runs">
			<cfset runinfo = deserializeJSON(fileRead(runsDir & "/" & name)) />
			RUNHASH <a href="?info=#runinfo.id#">#runinfo.id#</a><br />
			Target: #runinfo.target# Status: #runinfo.status# Started: #runinfo.started#  Ended: #runinfo.ended#
			(#dateDiff("n",runinfo.started,runinfo.ended)# mins #dateDiff("s",runinfo.started,runinfo.ended)# secs)<br />
			<cfif runinfo.errortext != "">
				<pre style="color:red">#runinfo.errortext#</pre>
			<cfelse>
				<br />
			</cfif>
		</cfloop>
	</cfif>
	<cfif structKeyExists(url,"info")>
		<cfset runinfo = deserializeJSON(fileRead(runsDir & "/" & info & ".json")) />
			Target: #runinfo.target# Status: #runinfo.status# Started: #runinfo.started#  Ended: #runinfo.ended#
			(#dateDiff("n",runinfo.started,runinfo.ended)# mins #dateDiff("s",runinfo.started,runinfo.ended)# secs)<br />
			<pre>#runinfo.outtext#</pre>
			<pre style="color:red">#runinfo.errortext#</pre>
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
	<cfoutput><em>Server started #server.ci.started#
				<cfset dtDiff = (parseDateTime(now()) - parseDateTime(server.ci.started)) />
				#dateDiff( "h",server.ci.started,now())# Hour(s),
				#TimeFormat( dtDiff, "m" )# Minute(s),
				#TimeFormat( dtDiff, "s" )# Second(s)
	</em></cfoutput>
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