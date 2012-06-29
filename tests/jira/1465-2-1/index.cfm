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

<!--- Get groups --->
<cfset groups=entityLoad('group')>
<cfset users1=groups[1].getUser()>
<cfset users2=groups[2].getUser()>


<!--- Compare ORM with SQL result --->
<!--- Group 1 --->
<cfquery name="sqlUsers1">
	SELECT *
	FROM group1465 as G
	INNER JOIN user1465 as U
		ON U.groupID = G.id
	WHERE G.id = 1
</cfquery>
<cf_valueEquals left="#ArrayLen(users1)#" right="#sqlusers1.recordCount#"><!--- not equal!!! --->

<!--- Group2 --->
<cfquery name="sqlUsers2">
	SELECT *
	FROM group1465 as G
	INNER JOIN user1465 as U
		ON U.groupID = G.id
	WHERE G.id = 2
</cfquery>
<cf_valueEquals left="#ArrayLen(users2)#" right="#sqlusers2.recordCount#">

