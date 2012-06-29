<cfsetting showdebugoutput="no">

<cfhttp
url="http://www.cnn.com/"
method="head"
redirect="false"
useragent="#CGI.http_user_agent#"
result="cfhttpResult"
throwonerror="false"
timeout="5"
/>
<cf_valueEquals left="#cfhttpResult.fileContent#" right="">