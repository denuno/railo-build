<cfset dsn="railo_mirror">


<!--- Create TestNvarchar --->
<cftry>
<cftry>
	<cfquery datasource="#dsn#">
        select * from TestNvarchar
    </cfquery>
    <cfcatch>
    <cfquery datasource="#dsn#">
    	CREATE TABLE TestNvarchar (
[id] [int] IDENTITY (1, 1) NOT NULL ,
[title] [nvarchar] (50)
) ON [PRIMARY]
    </cfquery>
    </cfcatch>
</cftry>

<cfquery datasource="#dsn#" name="test">
insert into TestNvarchar(title)
values('Susi')
</cfquery>




<cfquery datasource="#dsn#" name="test">
select * from TestNvarchar
</cfquery>
<cfset qry=test>

<cfquery dbtype="query" name="qry2">
select * from test,qry
where id=id
</cfquery>




	<cffinally>
    <cfquery datasource="#dsn#">
    	drop TABLE TestNvarchar
    </cfquery>
    </cffinally>

</cftry>

