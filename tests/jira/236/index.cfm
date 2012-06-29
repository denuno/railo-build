
<cfsavecontent variable="content"><cfset createObject("component","_argColl").ino(a:1,b:2)></cfsavecontent>
<cf_valueEquals left="#trim(content)#" right="A:1;B:2;A:1;B:37;">

<cfsavecontent variable="content"><cfset createObject("component","_argColl").ino(1,2)></cfsavecontent>
<cf_valueEquals left="#trim(content)#" right="A:1;B:2;2:2;A:1;B:37;">

