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
	<meta http-equiv="refresh" content="30" />
</head>
<body>
<cfset infoIni = getDirectoryFromPath(getCurrentTemplatePath()) & "../src/railo-java/railo-core/src/railo/runtime/Info.ini" />
<cfset ciPropsPath = getDirectoryFromPath(getCurrentTemplatePath()) & "../build/build.ci.properties" />
<cfset buildVersion = getProfileString(infoIni, "version", "number") />
<cfoutput>
	<cfif structKeyExists(url,"forceidle")>
		<cfset server.ci.runningbuild = false />
		<cflocation url="index.cfm" addtoken="false"/>
	</cfif>
	<cfif structKeyExists(url,"psaux")>
		<cfexecute name="#expandPath('.')#/../build/psaux.sh" timeout="10"  variable="ps"/>
		<cfdump var="#arrayLen(ps.split("cfml\s+\d+"))-1#" label="running java processes">
		<pre>#ps#</pre>
		<cfexecute name="/usr/bin/free" arguments="-m" timeout="10"  variable="free"/>
		<pre>#free#</pre>
	</cfif>
	<div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="brand" href="?">Railo Build System</a>
          <div class="nav-collapse">
            <ul class="nav">
<!---
             <li class="selected">
                <a href="ci.cfm?target=build" onclick="confirm('You wanna runna build #buildVersion#?')">build</a>
              </li>
 --->
             <li class="">
                <a href="?selectbranch=true">Branch</a>
              </li>
             <li class="nav">
                <a href="?selecttag=true">Tag</a>
              </li>
			<li> <span style="color:gray">|</span> </li>
			  <li><a href="?psaux=true">ps</a></li>
			  <li><a href="">Docs</a></li>
			  <li><a href="?type=rc">rc</a></li>
			  <li><a href="?type=war">WAR</a></li>
			  <li><a href="?type=cli">CLI</a></li>
			  <li><a href="?type=jar">Jar/Lib</a></li>
			  <li><a href="?type=express">Express</a></li>
			  <li><a href="?type=installer">Installer</a></li>
			  <li><a href="?type=rpm">RPM</a></li>
			  <li><a href="/artifacts/" target="_blank">ARTIFACTS</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
	</cfoutput>

	<div class="container-fluid">

<cfoutput>
<blockquote>Select a branch or tag to build ^-- up there. &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	The rest of ---^ that stuff be build artifacts mostly. Arrr.</blockquote>
<h2>
	Continious Integration :
	<cfif request.ci.runningbuild>
	  <span  style="color:green">Running</span>
	<cfelse>
	  <span  style="color:silver">Idle</span>
	</cfif>
</h2>
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
<cfelseif structkeyExists(url,"selectcommit")>
	<cfset arraydeleteat(branches,1) />
	<form action="ci.cfm" method="get">
		Commit: <input type="text" name="commit">
		<input type="submit" name="target" value="build">
	</form>
	<cfoutput><pre>#antTarget.outtext#</pre></cfoutput>
<cfelseif structkeyExists(url,"showoutput")>
	<cfif structKeyExists(server,"buildthread")>
		<h4>Build is running</h4>
		<cfif structkeyexists(server.buildthread,"outputstream")>
			<pre><cfoutput>#toString(server.buildthread.outputstream)#</cfoutput></pre>
		<cfelse>
			<cfexecute name="#expandPath('.')#/../build/psaux.sh" timeout="10"  variable="ps"/><br />
			<br />The build thread output stream isn't there.  Forcing idle.
			<cfset server.ci.runningbuild = false />
			Current number of running java processes: <cfoutput>#arrayLen(ps.split("cfml\s+\d+"))#</cfoutput>
			<pre><cfoutput>#ps#</cfoutput></pre>
		</cfif>
	<cfelse>
		<h4>No build currently running.</h4>
	</cfif>
<cfelse>
	<h3>
	<cfif request.ci.runningbuild>
		<cfoutput>
		<a href="?forceidle" onclick="return confirm('Force idle status?')" style="color:green">Running Target: #request.currentrun.target#</a> -
		<cfif isDate(request.ci.startedbuild) && request.ci.runningbuild>
			<cfset dtDiff = (parseDateTime(now()) - parseDateTime(request.ci.startedbuild)) />
			#dateDiff( "h",now(),server.ci.startedbuild)# Hour(s),
			#TimeFormat( dtDiff, "m" )# Minute(s),
			#TimeFormat( dtDiff, "s" )# Second(s)
		</cfif>
		<a href="?showoutput=true">output</a>
		</cfoutput>
	<cfelse>
		<cfset targets = "mvn.deploy.libs,mvn.deploy.core,build.installer,build.cli.all,build.cli.mvn,build.cli,build.cli.exe,build.cli.bin,build.cli.rpm,build.cli.deb,build.cli.express,build.cli.jre">
		<form action="ci.cfm" method="get">
			Target: <select name="target">
				<option value="build">build (<cfoutput>#buildVersion#</cfoutput>)</option>
				<option value="project.update">manually update sources</option>
			<cfloop list="#targets#" index="target">
			<cfoutput><option value="#target#">#target#</option></cfoutput>
			</cfloop>
			</select>
			<input type="submit" name="submit" value="run">
		</form>
	</cfif>
	</h3>
</cfif>

<br /><a href="?erroremails">set build.error.emails</a><br />
<cfif structKeyExists(url,"erroremails")>
<cfoutput>
	<cfset properties = loadProperties(ciPropsPath) />
	<cfif structKeyExists(form,"fieldnames")>
		<cfloop list="#form.emails#" index="addy">
			<cfset m[addy] = addy />
		</cfloop>
		<cfset properties.setProperty("build.error.emails",structKeyList(m)) />
		<cfset storeProperties(ciPropsPath,properties) />
		<h4>build.error.emails = #structKeyList(m)#</h4>
	<cfelse>
	<form action="?erroremails=set" method="post">
		<cfset emails = properties.getProperty('build.error.emails') />
		<cfset defaultEmails = "denny@getrailo.com,michael@getrailo.com">
			<cfloop list="#emails#" index="addy">
				<input type="checkbox" name="emails" value="#addy#" checked="true">#addy#<br/>
			</cfloop>
			<cfloop list="#defaultEmails#" index="addy">
				<cfif !listfindNoCase(emails,addy)>
				<input type="checkbox" name="emails" value="#addy#">#addy#<br/>
				</cfif>
			</cfloop>
			<input type="text" name="emails" style="width:333px" size="78" value="" /><br />
<!---
		<input name="propertyname" value="build.error.emails">
		<input name="propertyvalue" value="#properties.getProperty('build.error.emails')#">
 --->
		<input type="submit" />
	</form>
	</cfif>
</cfoutput>
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
<cfparam name="url.type" default="jar" />
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
	<h3><a href="?list">Run Log: #runs.recordcount# available</a> | <a href="?runsclear=true">clear</a></h3>
	<cfif structKeyExists(url,"list")>
		<cfloop query="runs">
			<cfset runinfo = deserializeJSON(fileRead(runsDir & "/" & name)) />
			RUNHASH <a href="?info=#runinfo.id#">#runinfo.id#</a><br />
			Target: <strong>#runinfo.target#</strong> Status: <em>#runinfo.status#</em> Started: #runinfo.started#  Ended: #runinfo.ended#
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
				dateDiff( "h",#server.ci.started#,#now()#) ==
				#dateDiff( "h",server.ci.started,now())# Hour(s) ?,
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
</html><cfsilent>

<cffunction name="loadProperties">
	<cfargument name="propsfile" required="true" />
	<cfscript>
		var properties = createObject('java', 'java.util.Properties').init();
		var fileStream = createObject('java', 'java.io.FileInputStream').init(propsfile);
		properties.load(fileStream);
		return properties;
	</cfscript>
</cffunction>

<cffunction name="storeProperties">
	<cfargument name="propsfile" required="true" />
	<cfargument name="properties" required="true" />
	<cfargument name="comment" default="modified #now()#" />
	<cfscript>
		var fileStream = createObject('java', 'java.io.FileOutputStream').init(propsfile);
		properties.store(fileStream,comment);
		return properties;
	</cfscript>
</cffunction>

</cfsilent>