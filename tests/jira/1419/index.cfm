<cfsetting showdebugoutput="no">

<cfset passwordWebAdmin="testtest">
<cfset physical=GetDirectoryFromPath(GetCurrentTemplatePath())&"cfc/">




<!--- create mapping if not exists --->
<cfadmin
	action="getComponentMappings"
	type="web"
	password="#passwordWebAdmin#"
	returnVariable="mappings">
<cfset hasMapping=false>
<cfloop query="mappings">
	<cfif mappings.strphysical EQ variables.physical>
		<cfset hasMapping=true>
	</cfif>
</cfloop>
<cfif not hasMapping>

    <cfadmin
        action="updateComponentMapping"
        type="web"
        password="#passwordWebAdmin#"
        physical="#physical#"
        virtual=""
        archive=""
        primary="physical"
        trusted="false">
</cfif>

<cfset xMeta = getMetaData(new Bla())>
<cf_valueEquals left="#xMeta.name#" right="Bla">
<cf_valueEquals left="#xMeta.fullName#" right="Bla">

<cfset xMeta = getMetaData(new a.b.c.BlaBla())>
<cf_valueEquals left="#xMeta.name#" right="a.b.c.Bla">
<cf_valueEquals left="#xMeta.fullName#" right="a.b.c.Bla">
