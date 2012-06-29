<cfsetting showdebugoutput="no">

<cfthread name="sendIt">
<cfset mic="michael@">
<cfmail subject="Test Email from Thread should be unique (#getTickCount()#)" to="#mic#stre.it" from="#mic#getrailo.com">
This is a test email that was sent just once from inside a thread.
</cfmail>
</cfthread>

<cfset mic="michael@">
<cfmail subject="Test Email from main request should be unique (#getTickCount()#)" to="#mic#stre.it" from="#mic#getrailo.com">
This is a test email that was sent just once from the main request.
<cfoutput>Time: #now()#</cfoutput>
</cfmail>
