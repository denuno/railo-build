<cfcomponent>

<cfscript>
	this.name = hash(getCurrentTemplatePath()) & getTickCount();
</cfscript>


<cffunction name="onApplicationStart">

</cffunction>


<cffunction name="onRequestStart">

</cffunction>

</cfcomponent>