------------------------------------------------
    __  ___           __          ________
   /  |/  /___ ______/ /_        /  _/  _/
  / /|_/ / __ `/ ___/ __ \______ / / / /  
 / /  / / /_/ / /__/ / / /_____// /_/ /   
/_/  /_/\__,_/\___/_/ /_/     /___/___/  

Project: Dashboard Module
Version: 1.0.0.1348
Built-on: 2009-02-17 16:11:55
$Id: README 1328 2009-02-09 09:14:25Z peterfarrell $
------------------------------------------------
If version number and built-on are placeholders, you are using a bleeding
edge release of the dashboard.
------------------------------------------------
___                                
 | ._ _|_ ._ _  _|    _ _|_ o _ ._ 
_|_| | |_ | (_)(_||_|(_  |_ |(_)| |
------------------------------------------------
Mach-II Dashboard is a module to assist in developing Mach-II 
web-applications.  Current functionality of the dashboard:

 - Basic authentication (login page)
 - Reload base application or individual modules
 - Reload base ColdSpring bean factory or individual child factories
 - Reload individual listeners, plugins, filters or properties (Mach-II 1.8+ only)
 - Manage logging
 - Manage caching including charts of logging statistics
 - Recent exception snapshots for easy debugging
 - Basic server and application configuration information
 - JVM memory usage including charts of memory usage 

The dashboard is designed to be run as a Mach-II module and thus 
*CANNOT* be run as a stand-alone Mach-II application.

------------------------------------------------
| o _ _ ._  _ _ 
|_|(_(/_| |_>(/_
------------------------------------------------
Mach-II Dashboard 1.0.0 is released under the Apache 2.0 license.  You can 
use the Mach-II Dashboard  on any commercial application as long as you abide 
by the license. For more  details, please see the NOTICE and LICENSE files that 
are shipped with the dashboard.

Copyright 2008-2009 GreatBizTools, LLC

Licensed under the Apache License, Version 2.0 (the "License"); 
you may not use this file except in compliance with the License. 
You may obtain a copy of the License at 

	http://www.apache.org/licenses/LICENSE-2.0 

Unless required by applicable law or agreed to in writing, software 
distributed under the License is distributed on an "AS IS" BASIS, 
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
See the License for the specific language governing permissions and 
limitations under the License.

----
Mach-II documentation, implicit "M" logo and other logos are not licensed under 
the Apache License:
Copyright 2008-2009 GreatBizTools, LLC All rights reserved.
----
Special thanks to Mike James for providing the dashboard icons:
http://www.famfamfam.com/lab/icons/silk/
Icons licensed under Creative Commons Attribution 2.5 License:
http://creativecommons.org/licenses/by/2.5/
----

------------------------------------------------
___                            
 | ._  _ _|_ _.|| _._|_ o _ ._ 
_|_| |_>  |_(_|||(_| |_ |(_)| |
------------------------------------------------
1.	Download the dashboard code from http://www.mach-ii.com.

2.	Unzip the dashboard to your web root. 

	a.	For example, on Windows the default web root is [DRIVE]:\Inetpub\wwwroot, 
		or if you are using your CFML server's built-in web server, your web root is 
		likely [DRIVE]:\CFusionMX\wwwroot.  If you are on a Unix system, your web 
		root will vary.

	b.	The end result of this step is that you should have the directory MachIIDashboard 
		(no hyphen) in your web root.  Inside this directory you will find the  
		dashboard files.

	c.	If you wish to place the core Mach-II Dashboard files in a location that is 
		different from your webroot, just create a mapping called "MachIIDashboard" 
		in the CFML administrator / control panel that points this mapping to the 
		location where you placed the dashboard files.

3.	Add the dashboard as a module in your Mach-II application configuration file  and 
	set the password in the override XML section:

	<modules>
		<module name="dashboard" file="/MachIIDashboard/config/mach-ii_dashboard.xml">
			<mach-ii>
				<properties>
					<property name="password" value="PLACE YOUR PASSWORD HERE" />
				</properties>
			</mach-ii>
		</module>
	</modules>

4.	Reload your Mach-II application and navigate to:

	http://www.example.com/index.cfm?event=dashboard:info.index
	
	(You may have to modify this url if you use a different event parameter 
	other than "event")


------------------------------------------------
 _                      
|_) _  _ _    ._ _ _  _ 
| \(/__>(_)|_|| (_(/__> 
------------------------------------------------
* The best way of contacting Team Mach-II or helping the Mach-II project is 
info@mach-ii.com.

* All defect (bug) reports and enhancement requests should be logged as a new ticket
on our Trac installation at http://trac.mach-ii.com.  Please search the tickets for
duplicate / similar defect reports or enhancement requests before submitting a new
ticket.

* The best place to get quick help from other developers is to join our public 
email listserv/forums at: http://groups.google.com/group/mach-ii-for-coldfusion.

* Check out http://www.mach-ii.com for Quick Starts, FAQs and additional sample 
applications and documentation.

* If you wish to submit code for defect fix or feature enhancement, your submission
is governed under the license in which Mach-II is released. For more information, 
please read the accompanying license.