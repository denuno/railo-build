<cfsetting showdebugoutput="no">

<cfscript>
isRailo=server.ColdFusion.ProductName EQ "Railo";
cfc=isRailo?"RemoteRailo":"Remote";




// delete existing
entities = entityLoad( 'E1264' );
for(entityToDelete in entities){
	entityDelete( entityToDelete );
}
ormFlush();


// create new entity
e = entityNew( 'E1264' );
e.setID( '1' );
e.setFoo( 'f' );
entitySave(e);
ormFlush();

uri="http://"&cgi.HTTP_HOST& GetDirectoryFromPath(cgi.SCRIPT_NAME)&cfc&".cfc";

</cfscript>

<!--- Local --->
<cfset e = entityLoad( 'E1264' ,1,true)>
<cf_valueEquals left="#e.getId()#" right="1">
<cf_valueEquals left="#e.getFoo()#" right="f">


<!--- Json --->
<cfhttp url="#uri#?method=getAsJson&id=1" />
<cfset json=deserializeJson(cfhttp.filecontent)>
<cf_valueEquals left="#ListSort(StructKeyList(json),"textnocase")#" right='BAR,foo,id'>
<cf_valueEquals left="#json.id#" right='1'>
<cf_valueEquals left="#json.foo#" right='f'>
<cf_valueEquals left="#json.bar#" right='bbbaaar'>


<!--- WDDX --->
<cfif isRailo>
	<cfscript>
    e = new E1264();
    e.setID( '1' );
    e.setFoo( 'f' );
    </cfscript>
    <cfwddx action="cfml2wddx" input="#e#" output="wddx" usetimezoneinfo="yes" >
    <cfwddx action="wddx2cfml" input="#wddx#" output="wddx2" >
    <cf_valueEquals left="#wddx2.getId()#" right="1">
    <cf_valueEquals left="#wddx2.getFoo()#" right="f">

	<cfhttp url="#uri#?method=cfcAsWddx&id=1" />
    <cfwddx action="wddx2cfml" input="#cfhttp.filecontent#" output="wddx2" >
    <cf_valueEquals left="#wddx2.getId()#" right="1">
    <cf_valueEquals left="#wddx2.getFoo()#" right="f">

	<cfhttp url="#uri#?method=entityAsWddx&id=1" />
    <cfwddx action="wddx2cfml" input="#cfhttp.filecontent#" output="wddx2" >
    <cf_valueEquals left="#wddx2.getId()#" right="1">
    <cf_valueEquals left="#wddx2.getFoo()#" right="f">
</cfif>
        

<!--- Serialize --->
<cfif isRailo>
    <cfhttp url="#uri#?method=getAsSerialize&id=1" />
    <cfset c=evaluate(trim(cfhttp.FileContent))>
    <cf_valueEquals left="#c.getId()#" right="1">
    <cf_valueEquals left="#c.getFoo()#" right="f">
</cfif>


<!--- Webservice --->
<cfset wse=createObject("webservice",uri&"?wsdl").getAsJson(1)>
<cf_valueEquals left="#wse.getId()#" right="1">
<cf_valueEquals left="#wse.getFoo()#" right="f">
