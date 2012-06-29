<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>




<cfset variables.company = entityNew("Company") />
<cfset variables.user = entityNew("User") />
<cfset variables.user.setCompany(variables.company) />
<cfset entitySave(variables.company) />
<cfset entitySave(variables.user) />

<cfdump var="#variables.company.getUsers()#">



<cf_valueEquals left="" right="">