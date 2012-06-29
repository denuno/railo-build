<cfsetting showdebugoutput="no">

<cfset testCaseObject = new TestCaseObject() />
<cfset testVariable = testCaseObject.testMethod() />

<cf_valueEquals left="#testVariable#" right="susi">