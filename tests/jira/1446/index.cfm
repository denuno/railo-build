<cfsetting showdebugoutput="no">
<cfscript>
function getNull(){}

function test() {
	local.myStruct = {};
	local.otherStruct = {};
	local.otherStruct.key = getNull();//returns void/undefined/null

	StructAppend(local.myStruct, local.otherStruct);
}
test();
</cfscript>


