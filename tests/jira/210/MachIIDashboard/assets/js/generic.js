/*
 * License:
 * Copyright 2008 GreatBizTools, LLC
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0

 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * 
 * Copyright: GreatBizTools, LLC
 * Author: Peter J. Farrell (peter@mach-ii.com)
 * $Id: generic.js 1269 2009-01-14 22:54:21Z peterfarrell $
 * 
 */
function addLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      if (oldonload) {
        oldonload();
  }
      func();
    }
  }
} // END FUNCTION

function fancyRules() { 
  if (!document.getElementsByTagName) return; 
	  var hr = document.getElementsByTagName("hr");
  for (var i=0; i<hr.length; i++) { 
    var newhr = hr[i]; 
    var wrapdiv = document.createElement('div');
    wrapdiv.className = 'line';  
    newhr.parentNode.replaceChild(wrapdiv, newhr);  
    wrapdiv.appendChild(newhr);  
  }
}

addLoadEvent(fancyRules);