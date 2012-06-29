<cfif thisTag.executionMode eq "start">

<!--- Parameters --->
<cfparam name="attributes.returnVariable" type="variablename" />

<!--- Return random number --->
<cfset caller[attributes.returnVariable] ="susi" />

</cfif>