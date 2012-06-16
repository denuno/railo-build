<cfcomponent output="false" style="rpc" namespace = "http://#cgi.HTTP_HOST#/extensions/ExtensionProvider"><cfsilent>


	<cfset this.downloadDir = getDirectoryFromPath(getBaseTemplatePath()) />
	<cfset this.reloadseconds = 10 />

   <cffunction name="getInfo" access="remote" returntype="struct" output="false">
       <cfset var info=structNew() />
       <cfset info.title="Extension Provider ("&cgi.HTTP_HOST&")" />
       <cfset info.description="Railo Extensions" />
       <cfset info.image="http://www.railo.ch/img.jpg" />
       <cfset info.url="http://"&cgi.HTTP_HOST />
       <cfset info.mode="develop" />
       <cfreturn info>
   </cffunction>

	<cffunction name="loadExtensionsMetadata" access="public" output="false">
		<cfargument name="extensionsDir" required="true" />
			<cfset var info = structNew() />
			<cfset var extensions = arrayNew(1) />
			<cfset var objXml = createObject("component","xml2Struct")>

			<cfset jfu = createObject("component","jfu") />
			<cfset zipsQry = jfu.Directorylisting(extensionsDir) />
			<cfloop query="zipsQry">
				<cfif lcase(listLast(name,".")) eq "zip" >
					<cftry>
<!---
					<cfzip
					action="read"
					file="#expandPath( directory & "/" & name )#"
					variable="infoFile"
					entrypath="info.xml"
					recurse="false"
					storepath="false"
					/>
 --->
					<cfset infoFile = jfu.readBinaryFromZip(directory & "/" & name,"info.xml")>
					<cfset arrayAppend(extensions,objXml.ConvertXmlToStruct(xmlParse(toString(infoFile)),structNew())) />
					<cfcatch>
						<!--- comment to ignore unloadable (corrupt zip? etc.) extensions --->
						<cfrethrow />
					</cfcatch>
					</cftry>
				</cfif>
			</cfloop>
			<cfreturn extensions/>
	</cffunction>

	<cffunction name="extensionsArrayToQuery" output="false">
		<cfargument name="extensionsArray" required="true" />
       <cfset var apps = queryNew('type,id,name,label,description,version,category,image,download,paypal,author,codename,video,support,documentation,forum,mailinglist,network,created')>
       <cfset var rootURL = getInfo().url />
			<cfset var exAry = "" />
			<cfloop array="#extensionsArray#" index="exAry">
       <cfset QueryAddRow(apps)>
       <cfset QuerySetCell(apps,'id',exAry.extension.extensionId)>
       <cfset QuerySetCell(apps,'name',exAry.extension.extensionName)>
       <cfset QuerySetCell(apps,'type',exAry.extension.extensionType)>
       <cfset QuerySetCell(apps,'label',exAry.extension.extensionLabel)>
       <cfset QuerySetCell(apps,'description',exAry.extension.extensionDescription)>
       <cfset QuerySetCell(apps,'author',exAry.extension.extensionAuthor)>
       <cfset QuerySetCell(apps,'codename',exAry.extension.extensionCodename)>
       <cfset QuerySetCell(apps,'image',exAry.extension.extensionImage)>
       <cfset QuerySetCell(apps,'support',exAry.extension.extensionSupport)>
       <cfset QuerySetCell(apps,'documentation',exAry.extension.extensionDocumentation)>
       <cfset QuerySetCell(apps,'forum',exAry.extension.extensionForum)>
       <cfset QuerySetCell(apps,'created',exAry.extension.extensionCreated) />
       <cfset QuerySetCell(apps,'version',exAry.extension.extensionVersion) />
       <cfset QuerySetCell(apps,'category',exAry.extension.extensionCategory) />
       <!--- <cfset QuerySetCell(apps,'download',"http://" & cgi.HTTP_HOST & exAry.extension.extensionDownload) /> --->
       <cfset QuerySetCell(apps,'download',"http://" & cgi.HTTP_HOST & cgi.SCRIPT_NAME & "?metnod=download&id=" & exAry.extension.extensionName) />
			</cfloop>
		<cfreturn apps />
	</cffunction>

	<cffunction name="download" access="remote" returntype="void" output="false">
		<cfquery name="getEx" dbtype="query">
		  SELECT * FROM application.extensions.extensionsQuery
		  WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(url.id,'-extension.zip','')#" />
		</cfquery>
		<cfset _download(filename="#getEx.id#-extension.zip",file="#this.downloaddir#/#url.id#",mimetype="application/octet-stream",forcedownload="true") />
	</cffunction>

  <cffunction name="_download" output="false" returntype="string" access="private">
		<cfargument name="fileName" required="true" />
		<cfargument name="fileContent" default="" />
		<cfargument name="file" default="" />
		<cfargument name="mimetype" default="application/octet-stream" />
		<cfargument name="forceDownload" default="false" />
		<cfset var cvalue = "" />

		<cfsetting showdebugoutput="no">
		<cfsetting enablecfoutputonly="yes">
		<cfif file gt "" and NOT fileExists(file)>
		  <cfthrow type="extensionprovider.download.nofile" detail="File not found: #file#" />
		</cfif>

		<cfif arguments.forceDownload>
			<cfset cvalue = 'attachment;'>
		</cfif>
	  <cfset cvalue = cvalue & "filename=#arguments.fileName#">
		<cfheader name="Content-Disposition" value="#cvalue#" charset="utf-8">
		<cfif file eq "">
			<cfcontent type="#arguments.mimetype#" reset="true"><cfoutput>#arguments.fileContent#</cfoutput>
		<cfelse>
			<cfcontent type="#arguments.mimetype#" reset="true" file="#arguments.file#" />
		</cfif>
	</cffunction>

	<cffunction name="loadExtensions" returntype="struct" access="private">
		<cfset var extensions = structNew()>
		<cfset extensions.lastloaded = now() />
		<cfset extensions.extensionsQuery = extensionsArrayToQuery(loadExtensionsMetadata(this.downloadDir)) />
		<cfreturn extensions />
	</cffunction>

	<cffunction name="listApplications" access="remote" returntype="query" output="false">
		<cfif NOT structKeyExists(application,"extensions") OR structKeyExists(url,"reloadextensions")>
			<cfset application.extensions = loadExtensions() />
		</cfif>
		<cfif datediff('s',application.extensions.lastloaded,now()) gt this.reloadseconds>
			<cfset application.extensions = loadExtensions() />
		</cfif>
		<cfreturn application.extensions.extensionsQuery />
	</cffunction>

	<cffunction name="extensionlist" access="remote" returntype="query" output="false">
		<cfdump var="#this.downloaddir#">
		<cfdump var="#listApplications()#" /><cfabort />
	</cffunction>


</cfsilent></cfcomponent>