<cfsetting showdebugoutput="no">

<cfsavecontent variable="str">
{"algorithm":"HMAC-SHA256","expires":1306486800,"issued_at":1306482721,"oauth_token":"129653667047670|2.AQAdzNdqTtGU_zXz.3600.1306486800.0-1323312705|Dcha7h7qg8AiUBRvoXv5wkrCSkI","page":{"id":"136348403064176","liked":false,"admin":true},"user":{"country":"at","locale":"en_US","age":{"min":21}},"user_id":"1323312705"}
</cfsavecontent>
<cfset str=trim(str)>

<cfset deserializeJson(str)>
<cf_valueEquals left="#isJson(str)#" right="#true#">