<cfset ds="railo_mirror">

<cftry>
    <cfquery datasource="#ds#">
    CREATE TABLE test1654 (
    pk int NOT NULL,
    test int NULL
    )
    </cfquery>
	<cfcatch></cfcatch>
</cftry>


<cftransaction>
<cfquery datasource="#ds#">
insert into test1654 (pk,test)
values (1,1)

insert into test1654 (pk,test,aaa)
values (1,1,'test')

insert into test1654 (pk,test)
values (2,2)
</cfquery>
</cftransaction>




