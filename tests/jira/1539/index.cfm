<cfsetting showdebugoutput="no">

<cfif server.ColdFusion.ProductName EQ "Railo">
	<cfset setTimezone("pst")>
    
    <cf_valueEquals left="#IsDate('2011-09-30T21:09:21Z')#" right="true">
    <cf_valueEquals left="#IsDate('2011-09-30T21:09:21.131Z')#" right="true">
    
    <cf_valueEquals left="#ParseDateTime('2011-09-30T21:09:21')#x" right="{ts '2011-09-30 21:09:21'}x">
    <cf_valueEquals left="#ParseDateTime('2011-09-30T21:09:21.131')#x" right="{ts '2011-09-30 21:09:21'}x">
    
    <cf_valueEquals left="#ParseDateTime('2011-09-30T21:09:21Z')#x" right="{ts '2011-09-30 14:09:21'}x">
    <cf_valueEquals left="#ParseDateTime('2011-09-30T21:09:21.131Z')#x" right="{ts '2011-09-30 14:09:21'}x">
</cfif>