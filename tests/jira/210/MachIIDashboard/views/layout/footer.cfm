<cfsilent>
<!---
License:
Copyright 2008 GreatBizTools, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Copyright: GreatBizTools, LLC
$Id: footer.cfm 1286 2009-01-21 08:07:06Z peterfarrell $

Created version: 1.0.0
Updated version: 1.0.0

Notes:
--->
</cfsilent>
<cfoutput>
<div>
	<p class="right">
		<img src="#BuildUrl("sys.serveAsset", "path=@img@icons@help.png")#" width="16" height="16" alt="Help" title="Help" />
		 <a href="http://trac.mach-ii.com">Help - Wiki, Documentation &amp; Bug Tracker</a></p>
	<p><a href="http://greatbiztoolsllc.trac.cvsdude.com/mach-ii/wiki/Dashboard" title="Dashboard Wiki Home">Mach-II Dashboard</a> - #getProperty("udfs").getVersionString()#</p>
	<p>&copy; Copyright 2008-2009 GreatBizTools, LLC and released under the Apache 2.0 license</p>
</div>
</cfoutput>