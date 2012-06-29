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
<cf_valueEquals left="#data.dn#" right="cn=EVELYN A AVANT,ou=NHTSAHQ,ou=DOT Headquarters,o=U.S. Government,c=US" cs="false">

<cfldap
server = "directory.verisign.com"
action ="query"
name = "data"
scope="subtree"
start = ""
filter = "cn=EVELYN A AVANT"
attributes = "uid,c,o,ou,cn,mail">
<cfdump var="#data#">
<cf_valueEquals left="#structKeyExists(data,'dn')#" right="false" cs="false">



