<cfsetting showdebugoutput="no">

<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>


<cfscript>
function test(date date){
	local.originaltime=arguments.date;
	local.encoded = serializeJSON(local.originaltime,false);
	local.decoded = deserializeJSON(local.encoded,false);
	local.newtime = parsedatetime(local.decoded);
	valueEquals(local.originaltime,local.newtime);
}
test(createDateTime(2011,8,30,11,59,59));
test(createDateTime(2011,8,30,12,0,0));
test(createDateTime(2011,8,30,12,30,0));
test(createDateTime(2011,8,30,12,59,59));
test(createDateTime(2011,8,30,13,0,0));
test(createDateTime(2011,8,30,23,59,59));
test(createDateTime(2011,8,30,0,0,0));

</cfscript>

