<cfsetting showdebugoutput="no">

<h1>with original cfc everything works as expected</h1>
<cfset test=createObject('component', 'Test') />
<cfset test.test()>

<h1>with cloned cfc it fails</h1>
<cfset test=createObject('component', 'Test') />
<cfset test=duplicate(test)>
<cfset test.test()>
