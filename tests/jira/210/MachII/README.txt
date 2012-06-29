------------------------------------------------
    __  ___           __          ________
   /  |/  /___ ______/ /_        /  _/  _/
  / /|_/ / __ `/ ___/ __ \______ / / / /  
 / /  / / /_/ / /__/ / / /_____// /_/ /   
/_/  /_/\__,_/\___/_/ /_/     /___/___/  

Version: 1.6.0.8
Built-on: 2009-02-09 02:38:02
$Id: README 1327 2009-02-09 07:34:44Z peterfarrell $
------------------------------------------------
If version number and built-on are placeholders (e.g. @xyz@), you are using 
a bleeding edge release (BER) of the framework.
------------------------------------------------
___                                
 | ._ _|_ ._ _  _|    _ _|_ o _ ._ 
_|_| | |_ | (_)(_||_|(_  |_ |(_)| |
------------------------------------------------
Mach-II is a framework for developing object oriented Model-View-Controller 
web applications.  The framework focuses on easing software development and 
maintenance.  Mach-II was the first object-oriented framework for CFML 
and continues to mature as a strong and viable framework choice for developers.

------------------------------------------------
| o _ _ ._  _ _ 
|_|(_(/_| |_>(/_
------------------------------------------------
Mach-II 1.6.0 is released under the Apache 2.0 license.  You can use Mach-II 
on any commercial application as long as you abide by the license. For more 
details, please see the NOTICE and LICENSE files that are shipped with the 
framework.

Copyright 2003-2009 GreatBizTools, LLC

Licensed under the Apache License, Version 2.0 (the "License"); 
you may not use this file except in compliance with the License. 
You may obtain a copy of the License at 

	http://www.apache.org/licenses/LICENSE-2.0 

Unless required by applicable law or agreed to in writing, software 
distributed under the License is distributed on an "AS IS" BASIS, 
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
See the License for the specific language governing permissions and 
limitations under the License.

Mach-II's documentation and logos are *not* licensed under the Apache 2.0 license:
Copyright 2007-2009 GreatBizTools, LLC All rights reserved.

------------------------------------------------
___                            
 | ._  _ _|_ _.|| _._|_ o _ ._ 
_|_| |_>  |_(_|||(_| |_ |(_)| |
------------------------------------------------
1.	Download the core framework code from http://www.mach-ii.com.

2.	Unzip the framework to your web root. 

	a.	For example, on Windows the default web root is [DRIVE]:\Inetpub\wwwroot, 
		or if you are using your CFML server's built-in web server, your web root is 
		likely [DRIVE]:\CFusionMX\wwwroot.  If you are on a Unix system, your web 
		root will vary.

	b.	The end result of this step is that you should have the directory MachII 
		(no hyphen) in your web root.  Inside this directory you will find the core 
		framework files.

	c.	If you wish to place the core Mach-II framework files in a location that is 
		different from your webroot, just create a mapping called "MachII" in the 
		CFML administrator / control panel that points this mapping to the location 
		where you placed the framework files.

3.	If you use sandbox security on your CFML server, you may have to add the 
	framework's directory to your sandbox otherwise your CFML server may throw an 
	java security exception.

Just three simple steps and you are done.  The Mach-II framework is just a CFML 
application, so it will operate and behave just like any other CFML application.
Please read the Upgrading Note below if you are upgrading your installation of Mach-II.

Please Note Well:
The framework core is not a stand-alone application.  Do not expect to run the
mach-ii.cfm and expect a "welcome" message. Download the Mach-II Skeleton
available at mach-ii.com to start a new application or download a sample
application.

If your webroot is "wwwroot", your directory structure should look like this:
|-+ wwwroot
  |- MachII
  |- MyCoolApplication
  |- MyBlogApplication

If you encounter problems:

1.	Please first ensure that your directory structure matches the one shown above
	or that your "MachII" mapping is pointing to the right directory if you are
	using a mapping.

2.	Clear your template cache if you have caching on and restart your CFML server 
	service.

3.	If your problems persist, please check out the Mach-II for CFML Google Group:
	http://groups.google.com/group/mach-ii-for-coldfusion

------------------------------------------------                                       
| |._  _ ._ _. _|o._  _   |\ | _ _|_ _ 
|_||_)(_|| (_|(_||| |(_|  | \|(_) |_(/_
   |   _|             _|     
------------------------------------------------
If you are updating your Mach-II installation from an older version, you *must* clear 
your template cache and restart your CFML server after you replace  your older version 
of Mach-II with a newer version.

If you do not clear your template cache and restart your server, you will receive 
an exceptions similar to:

- The value returned from function getAppFactory() is not of type MachII.framework.AppFactory.
- The value returned from function getMessageManager() is not of type MachII.framework.MessageManager.
- Element AppLoader undefined in application[MACHII_APP_KEY].
- Etc. (Too many to list here as it vary from what version you upgraded from)

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

* All documentation and FAQs are located in our wiki at: http://trac.mach-ii.com

* The best place to get quick help from other developers is to join our public 
email list / forums at: http://groups.google.com/group/mach-ii-for-coldfusion

* Check out http://www.mach-ii.com for Quick Starts, FAQs and additional sample 
applications and documentation.

* If you wish to submit code for defect fix or feature enhancements, your submission
is governed under the license in which Mach-II is released. For more information, 
please read the accompanying license.