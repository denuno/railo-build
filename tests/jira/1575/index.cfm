<cfsetting showdebugoutput="no">

<cfset ds="railo_mirror">


<!--- create table --->
<cftry>
	<cfquery datasource="#ds#">
    select * from farBarnacle1575
    </cfquery>

    <cfcatch>
        <cfquery datasource="#ds#">
        CREATE TABLE `farBarnacle1575` (
        `referenceid` varchar(50) DEFAULT NULL,
        `barnaclevalue` decimal(10,2) DEFAULT NULL,
        `ownedby` varchar(250) DEFAULT NULL,
        `roleid` varchar(50) DEFAULT NULL,
        `locked` tinyint(1) NOT NULL DEFAULT '0',
        `permissionid` varchar(50) DEFAULT NULL,
        `datetimecreated` datetime NOT NULL DEFAULT '2211-02-03 13:47:28',
        `datetimelastupdated` datetime NOT NULL DEFAULT '2211-02-03 13:47:28',
        `ObjectID` varchar(50) NOT NULL DEFAULT '',
        `lastupdatedby` varchar(250) NOT NULL DEFAULT '',
        `objecttype` varchar(250) DEFAULT NULL,
        `label` varchar(250) DEFAULT NULL,
        `lockedBy` varchar(250) DEFAULT NULL,
        `createdby` varchar(250) NOT NULL DEFAULT '',
        PRIMARY KEY (`ObjectID`),
        KEY `referenceid_index` (`referenceid`),
        KEY `roleid_index` (`roleid`),
        KEY `permissionid_index` (`permissionid`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8
        </cfquery>
</cfcatch>
</cftry>


<cfdbinfo datasource="#ds#" type="index" table="farBarnacle1575" name="q" />




<cf_valueEquals left="#q.recordcount#" right="4">

<!--- ObjectID --->
<cf_valueEquals left="#q.COLUMN_NAME[1]#" right="ObjectID">
<cf_valueEquals left="#q.INDEX_NAME[1]#" right="PRIMARY">
<cf_valueEquals left="#q.NON_UNIQUE[1]#" right="#false#">
<cf_valueEquals left="#q.ORDINAL_POSITION[1]#" right="1">
<cf_valueEquals left="#q.PAGES[1]#" right="0">
<cf_valueEquals left="#q.TYPE[1]#" right="Other Index">
<cf_valueEquals left="#q.CARDINALITY[1]#" right="0">

<!--- referenceid --->
<cf_valueEquals left="#q.COLUMN_NAME[2]#" right="referenceid">
<cf_valueEquals left="#q.INDEX_NAME[2]#" right="referenceid_index">
<cf_valueEquals left="#q.NON_UNIQUE[2]#" right="#true#">
<cf_valueEquals left="#q.ORDINAL_POSITION[2]#" right="1">
<cf_valueEquals left="#q.PAGES[2]#" right="0">
<cf_valueEquals left="#q.TYPE[2]#" right="Other Index">
<cf_valueEquals left="#q.CARDINALITY[2]#" right="0">

<!--- roleid --->
<cf_valueEquals left="#q.COLUMN_NAME[3]#" right="roleid">
<cf_valueEquals left="#q.INDEX_NAME[3]#" right="roleid_index">
<cf_valueEquals left="#q.NON_UNIQUE[3]#" right="#true#">
<cf_valueEquals left="#q.ORDINAL_POSITION[3]#" right="1">
<cf_valueEquals left="#q.PAGES[3]#" right="0">
<cf_valueEquals left="#q.TYPE[3]#" right="Other Index">
<cf_valueEquals left="#q.CARDINALITY[3]#" right="0">