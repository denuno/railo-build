<cfsetting showdebugoutput="no">

<cfset ds="railo_mirror">

<cftry>
    <cfquery datasource="#ds#">
    CREATE TABLE test1654 (
	    pk int NOT NULL,
    	test int NULL
    )
    </cfquery>
	<cfcatch>
		<cfif findNoCase("access denied to execute", cfcatch.message)>
			<cfrethrow />
		</cfif>
	</cfcatch>
</cftry>


<cftransaction>
<cfquery datasource="#ds#">
insert into test1654 (pk,test)
values (1,1)

insert into somethingnonexistent (pk,test,aaa)
values (1,1,'test')

insert into test1654 (pk,test)
values (2,2)
</cfquery>
</cftransaction>




