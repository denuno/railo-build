<!---
   Copyright 2010 Mark Mandel
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at
       http://www.apache.org/licenses/LICENSE-2.0
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
 --->

<cfcomponent hint="say hello" output="false" dostuff="true">

<!------------------------------------------- PUBLIC ------------------------------------------->

<cffunction name="init" hint="Constructor" access="public" returntype="Hello" output="false">
	<cfscript>
		return this;
	</cfscript>
</cffunction>

<cffunction	name="onMissingMethod" access="public" returntype="any" output="true" hint="invoked when a method could not be found" dostuff="true">
	<cfargument	name="missingMethodName" type="string"	required="true"	hint=""	/>
	<cfargument	name="missingMethodArguments" type="struct" required="true"	hint=""/>
    <cf_valueEquals left="#structKeyList(arguments.missingMethodArguments)#" right="str">
    <cf_valueEquals left="#structKeyExists(arguments.missingMethodArguments,'str')#" right="no">
    <cf_valueEquals left="#isDefined('arguments.missingMethodArguments.str')#" right="no">
    
	<cfreturn "Missing!" />
</cffunction>

<!------------------------------------------- PACKAGE ------------------------------------------->

<!------------------------------------------- PRIVATE ------------------------------------------->

</cfcomponent>