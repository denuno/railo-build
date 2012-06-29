<cfcomponent name="Mapitem">

	<!--- Meta data --->
	<cfset this.metadata.attributetype="fixed">
    <cfset this.metadata.attributes={
	    sct:{required:false,type:"struct",default:structNew()},
	    str:{required:false,type:"string",default:"string value"},
	    arr:{required:false,type:"array",default:[1,2,3]}
	}>


     <cffunction name="onStartTag" output="yes" returntype="boolean">
   		<cfargument name="attributes" type="struct">
   		<cfargument name="caller" type="struct">
        <cf_valueEquals left="#ListSort(StructKeyList(attributes),"textnocase")#" right="arr,sct,str">
        <cfreturn false>
   	</cffunction>


</cfcomponent>