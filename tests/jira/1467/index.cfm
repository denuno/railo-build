<cfsetting showdebugoutput="no">
<cfset ormReload()>

<cfset t1=entityNew("things")>
<cfset t2=entityNew("things")>
<cfset entitySave(t1)>
<cfset entitySave(t2)>

<cfset asso=entityNew("assocations")>
<cfset asso.setChild(t1)>
<cfset asso.setParent(t2)>
<cfset entitySave(asso)>

<cfset ormFlush()>

<cf_valueEquals left="" right="">