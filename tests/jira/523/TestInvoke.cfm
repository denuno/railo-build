<cfsilent>
<cffunction name="outsider" output="yes">o</cffunction>
<cffunction name="insider2" output="yes">o2</cffunction>
<cffunction name="insider3" output="yes">i2</cffunction>
<cfset this.insider2=insider3>

</cfsilent><cfinvoke method="insider" returnvariable="x"><cfinvoke method="outsider" returnvariable="x"><cfinvoke method="insider2" returnvariable="x">