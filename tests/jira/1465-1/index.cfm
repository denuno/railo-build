<cfsetting showdebugoutput="no">

<cfscript>
function deleteAllEntities(string name){
	var entities = entityLoad( name );
	var entityToDelete="";
	for(entityToDelete in entities){
		transaction {
			entityDelete( entityToDelete );
		}
	}
}
deleteAllEntities("group");
deleteAllEntities("user");

</cfscript>

<cfset groups=entityLoad('group')>
<cf_valueEquals left="#arrayLen(groups)#" right="0">

<!--- Generate two Groups --->
<cftransaction action="begin">
	<cfset local.group = [
		entityNew("group",{id=1,name="Team America"}),
		entityNew("group",{id=2,name="Team Switzerland"})
	]>
			
	<cfloop array="#local.group#" index="local.entity">
		<cfset entitySave(local.entity)>
	</cfloop>
	
	<cftransaction action="commit" />		
</cftransaction>		



<cfset groups=entityLoad('group')>
<cf_valueEquals left="#arrayLen(groups)#" right="2">

	

<!--- Add user to the first group --->
<cftransaction action="begin">
	<cfset local.user = [
		entityNew('user',{name='todd'}),
		entityNew('user',{name='mark'}),
		entityNew('user',{name='jamie'})
	]>		
	
	<cfset local.group = EntityLoad('group',{id=1})[1]>
	<cfset local.group.setUser(local.user)>
	
	<cftransaction action="commit" />		
</cftransaction>
<cfset sleep(1000)>

	
<!--- Add user to the second group --->
<cftransaction action="begin">		
	<cfset local.user = [
		entityNew('user',{name='Heidi'}),
		entityNew('user',{name='Peter'}),
		entityNew('user',{name='Alp Öhi'})
	]>
	
	<cfset local.group = EntityLoad('group',{id=2})[1]>
	<cfset local.group.setUser(local.user)>
	
	<cftransaction action="commit" />		
</cftransaction>

<cfset groups=entityLoad('group')>
<cf_valueEquals left="#arrayLen(groups)#" right="2">

<cfset users1=groups[1].getUser()>
<cfset users2=groups[2].getUser()>

<cf_valueEquals left="#arrayLen(users1)#" right="3">
<cf_valueEquals left="#arrayLen(users2)#" right="3">


<cf_valueEquals left="#users1[1].getId()#" right="1">
<cf_valueEquals left="#users1[2].getId()#" right="2">
<cf_valueEquals left="#users1[3].getId()#" right="3">

<cf_valueEquals left="#users2[1].getId()#" right="4">
<cf_valueEquals left="#users2[2].getId()#" right="5">
<cf_valueEquals left="#users2[3].getId()#" right="6">

<cfset d1=users1[1].getDateCreated()>
<cfset d2=users2[1].getDateCreated()>
<cf_valueEquals left="#DateDiff("s",d1,d2) GT 0#" right="true">

