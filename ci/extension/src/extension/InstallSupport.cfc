<cfcomponent>
	
    <cffunction name="validate" returntype="string" output="no"
    	hint="validate a config input value">
        <cfargument name="config" type="struct" required="yes">
    	<cfargument name="name" type="string" required="yes">
        <cfargument name="type" required="no" default="">
        <cfargument name="message" required="no" default="">
        
        
        <cfif len(config[arguments.name]) EQ 0>
        	<cfthrow message="">
        </cfif>
        
        
        <!--- check 
				
		input --->
<!--- 
        <cfset validate(config,'prefix','string','please define a prefix for your tables')>
        <cfset validate(config:config,prefix:'prefix',message:'please define a prefix for your tables')>
		<cfif len(config.tablePrefix) EQ 0><cfthrow message="please define a prefix for your tables" type="config.tablePrefix"></cfif>
 --->
        
        <!--- check input --->
<!--- 
        <cfif len(config.tablePrefix) EQ 0><cfthrow message="please define a prefix for your tables" type="config.tablePrefix"></cfif>
        <cfif len(config.title) EQ 0><cfthrow message="please define a title for your forum" type="config.title"></cfif>
        <cfif len(config.perPage) EQ 0 or not IsNumeric(config.perPage) or config.perPage LTE 0><cfthrow message="must be a positive numeric value" type="config.perPage"></cfif>
        <cfif len(config.fromAddress) EQ 0><cfthrow message="please define the from address" type="config.fromAddress"></cfif>
        <cfif len(config.sendOnPost) EQ 0><cfthrow message="please define the Post CC Address" type="config.sendOnPost"></cfif>
 --->
        
        
    </cffunction>
    
    
    
</cfcomponent>