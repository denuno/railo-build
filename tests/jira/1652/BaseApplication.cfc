<cfcomponent>


<cffunction name="onSessionEnd" returnType="void">
    <cfargument name="SessionScope" required=True/>
    <cfargument name="ApplicationScope" required=False/>
    <cfset systemOutput("base.onSessionEnd",true,true)>
</cffunction>

</cfcomponent>