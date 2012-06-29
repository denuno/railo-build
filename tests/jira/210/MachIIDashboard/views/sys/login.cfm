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
$Id: login.cfm 1321 2009-01-30 04:07:29Z peterfarrell $

Created version: 1.0.0
Updated version: 1.0.0

Notes:
--->
<cfimport prefix="dashboard" taglib="/MachIIDashboard/customtags" />
</cfsilent>
<cfoutput>
<dashboard:displayMessage refresh="false" />

<h1>Login</h1>

<hr />
<!---
We are not posting to a concrete "login_process" event handler
instead the LoginPlugin will catch the post, annouce the login process
event and then redirect to the originally requested event handler.
--->
<form action="#BuildUrl(event.getRequestName())#" method="post">
	<h4><label for="password">Password</label></h4>
	<p>
		<input type="password" name="password" id="password" value="" size="20" />&nbsp;
		<input type="submit" value="Login" />
	</p>
</form>
</cfoutput>