<cfsetting showdebugoutput="no">

<cfldap
server = "directory.verisign.com"
action ="query"
name = "data"
scope="subtree"
start = ""
filter = "cn=EVELYN A AVANT"
attributes = "uid,dn,c,o,ou,cn,mail">

<cf_valueEquals left="#structKeyExists(data,'dn')#" right="true" cs="false">
<!--- two ou values should be in list --->
<cf_valueEquals left="#data.ou#" right="nhtsahq,dot headquarters" cs="false">

<cfldap
server = "directory.verisign.com"
action ="query"
separator="|"
name = "data"
scope="subtree"
start = ""
filter = "cn=EVELYN A AVANT"
attributes = "uid,dn,c,o,ou,cn,mail">

<cf_valueEquals left="#structKeyExists(data,'dn')#" right="true" cs="false">
<!--- two ou values should be in list --->
<cf_valueEquals left="#data.ou#" right="nhtsahq|dot headquarters" cs="false">

