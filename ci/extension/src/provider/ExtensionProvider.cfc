<cfcomponent output="false" style="rpc" namespace = "http://#cgi.HTTP_HOST#/extensions/ExtensionProvider"><cfsilent>


	<cfset this.downloadDir = getDirectoryFromPath(getBaseTemplatePath()) />
	<cfset this.downloadDir = getDirectoryFromPath("artifacts/") />
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
			<cfset var hasinfo = structNew() />
			<cfset var info = structNew() />
			<cfset var infoItem = structNew() />
			<cfset var extensions = arrayNew(1) />
			<cfset var objXml = createObject("component","xml2Struct")>

			<cfset jfu = createObject("component","jfu") />
			<cfset zipsQry = jfu.Directorylisting(extensionsDir) />
			<cfloop query="zipsQry">
				<cfif lcase(listLast(name,".")) eq "zip" >
					<cftry>
					<cfzip
					action="list"
					file="#directory#/#name#"
					filter="config.xml"
					name="hasinfo"
					recurse="false"
					storepath="false"
					/>
					<cfif hasinfo.recordcount>
						<cfzip
						action="read"
						file="#directory#/#name#"
						variable="infoFile"
						entrypath="config.xml"
						recurse="false"
						storepath="false"
						/>
	<!---
						<cfset infoFile = jfu.readBinaryFromZip(directory & "/" & name,"info.xml")>
	 --->
	 					<cfset infoItem = objXml.ConvertXmlToStruct(xmlParse(toString(infoFile)).config.info,structNew()) />
	 					<cfset infoItem.path = "#directory#/#name#">
						<cfset arrayAppend(extensions,infoItem) />
					</cfif>

					<cfcatch>
						<!--- comment to ignore unloadable (corrupt zip? etc.) extensions
						<cfrethrow />
						--->
					</cfcatch>
					</cftry>
				<cfelseif type eq "dir">
					<cfset extensions = arrayMerge(extensions,loadExtensionsMetadata(directory & "/" & name))>
				</cfif>
			</cfloop>
<!---
			<cfcontent type="text/html" reset=true>
			<cfdump var="#zipsQry#">
			<cfdump var="#extensions#"><cfabort>
 --->

			<cfreturn extensions/>
	</cffunction>

	<cffunction name="extensionsArrayToQuery" output="false">
		<cfargument name="extensionsArray" required="true" />
       <cfset var apps = queryNew('type,id,name,label,description,version,category,image,download,paypal,author,codename,video,support,documentation,forum,mailinglist,network,created,path')>
       <cfset var rootURL = getInfo().url />
			<cfset var exAry = "" />
			<cfloop array="#extensionsArray#" index="exAry">
		       <cfset QueryAddRow(apps)>
		       <cfset QuerySetCell(apps,'id',exAry.Id)>
		       <cfset QuerySetCell(apps,'name',exAry.Name)>
		       <cfset QuerySetCell(apps,'type',exAry.Type)>
		       <cfset QuerySetCell(apps,'label',exAry.Label)>
		       <cfset QuerySetCell(apps,'description',exAry.Description)>
		       <cfset QuerySetCell(apps,'author',exAry.Author)>
		       <cfset QuerySetCell(apps,'codename',exAry.Codename)>
		       <cfset QuerySetCell(apps,'image',exAry.Image)>
		       <cfset QuerySetCell(apps,'support',exAry.Support)>
		       <cfset QuerySetCell(apps,'documentation',exAry.Documentation)>
		       <cfset QuerySetCell(apps,'created',exAry.Created) />
		       <cfset QuerySetCell(apps,'version',exAry.Version) />
		       <cfset QuerySetCell(apps,'category',exAry.Category) />
		       <cfset QuerySetCell(apps,'path',exAry.path) />
		       <!--- <cfset QuerySetCell(apps,'download',"http://" & cgi.HTTP_HOST & exAry.Download) /> --->
		       <cfset QuerySetCell(apps,'download',"http://" & cgi.HTTP_HOST & cgi.SCRIPT_NAME & "?method=download&id=" & exAry.Name) />
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

	<cffunction name="ui" access="remote" returntype="query" output="false">
		<a href="ant.cfm">Run Ant Builds</a>
		<br>
		<a href="<cfoutput>#getContextRoot()#</cfoutput>/extensions/ExtensionProvider.cfc?method=listapplications&reloadextensions=1">Reload and List Extensions</a>
		<cfdump var="#this.downloaddir#">
		<cfdump var="#listApplications()#" /><cfabort />
	</cffunction>


</cfsilent></cfcomponent>
