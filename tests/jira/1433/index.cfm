<cfsetting showdebugoutput="no">

<cfdirectory directory="./libs/" name="dir" listinfo="all">

<cfset jars=[]>
<cfloop query="dir">
	<cfset ArrayAppend(jars,dir.directory&"/"&dir.name)>
</cfloop>
<cfset jars=ArrayToList(jars)>


<cfif not structKeyExists(application, 'openIDConsumer') or structKeyExists(url, 'reinit')>
	<cfset application.openIDConsumer = createObject('java', 'org.openid4java.consumer.ConsumerManager', jars).init() />
</cfif>

<cfset openIDConsumer = application.openIDConsumer />

<cfset discoveries = openIDConsumer.discover('https://www.google.com/accounts/o8/id') />

<cfset discovered = openIDConsumer.associate(discoveries) />

<cfset authReq = openIDConsumer.authenticate(discovered, 'http://getRailo.org') />

<!--- Add fetch requests --->
<cfset fetch = createObject('java', 'org.openid4java.message.ax.FetchRequest', jars).createFetchRequest() />

<cfset fetch.addAttribute("FirstName", "http://axschema.org/namePerson/first", true) />
<cfset fetch.addAttribute("LastName", "http://axschema.org/namePerson/last", true) />
<cfset fetch.addAttribute("Email", "http://axschema.org/contact/email", true) />
<cfset fetch.addAttribute("Language", "http://axschema.org/pref/language", true) />

<cfset authReq.addExtension(fetch) />
<cfset _url=authReq.getDestinationUrl(true)>





<cf_valueEquals left="" right="">