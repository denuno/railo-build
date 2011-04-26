 <cfcomponent name="javafileutil" displayname="directoryReaderComponent" output="false">  
     
	<cffunction name="readFile" output="false">
		<cfargument name="filePath" required="true">
		<cfset objLineReader = CreateObject("java","java.io.LineNumberReader").Init(  
			CreateObject("java","java.io.BufferedReader").Init(  
			CreateObject("java","java.io.FileReader").Init(JavaCast( "string", ExpandPath( filePath ) )  
			))) 
		/>
		<cfset wee = structNew() />
		<cfset wee.filedata = "" />
		<cfset wee.linedata = objLineReader.ReadLine() />	
		<!--- Loop while we still have line data. --->
		<cfloop condition="StructKeyExists( wee, 'LineData' )">		
			<!--- Get the line number. --->
			<cfset intLineNumber = objLineReader.GetLineNumber() />		
			<!--- Output line data. --->
			<cfset wee.filedata = wee.filedata & wee.LineData />
			<!--- Read the next line. --->
			<cfset wee.linedata = objLineReader.ReadLine() />		
		</cfloop>
		<cfreturn wee.filedata />
	</cffunction>

	<cffunction name="Directorylisting" returntype="query" output="false">  
		<cfargument name="pathToparse" type="string" required="true" />  
		<cfargument name="recurse" type="boolean" default="false" required="false" />  
		<cfargument name="dirInfo" type="query" default="#queryNew('datelastmodified,name,size,type,directory,hidden,pathname,attributes')#">  
		<cfset var thisFile = "" />  
		<cfset var listFiles = "" />  
		<cfset var theType = '' />  
		<cfif Len(arguments.pathToparse)>  
			<cfset jfile = createObject("java","java.io.File").init(Trim(arguments.pathToParse)) />
			<cfif NOT jfile.exists()>
			  <cfthrow type="not.there" message="The dir: '#pathToparse#' do not exist!" />
			</cfif>
			<cfset listFiles =  jfile.listFiles() />  
			<cfset theDate = createObject("java","java.util.Date") />  
			<cfset theDateFormat = createObject("java","java.text.SimpleDateFormat") /> 
			<cfif isDefined("listFiles")>
				<cfloop from="1" to="#arraylen(listFiles)#" index="thisFile">  
					<cfset queryAddRow(arguments.dirInfo)>  
					<cfset querySetCell(arguments.dirInfo,"datelastmodified", theDateFormat.format(listFiles[thisFile].lastModified()))>  
					<!--- <cfset querySetCell(arguments.dirInfo,"datelastmodified", listFiles[thisFile].lastModified() )> --->  
					<cfset querySetCell(arguments.dirInfo,"name", listFiles[thisFile].getName() )>  
					<cfset querySetCell(arguments.dirInfo,"size", Val( listFiles[thisFile].length() ) )>  
					<cfset querySetCell(arguments.dirInfo,"directory", listFiles[thisFile].getParent() )>  
					<cfset querySetCell(arguments.dirInfo,"hidden", listFiles[thisFile].isHidden() )>  
					<cfset querySetCell(arguments.dirInfo,"pathname", listFiles[thisFile].getPath() )>  
					<cfset querySetCell(arguments.dirInfo,"attributes", listFiles[thisFile].canWrite() )>  
					<cfset theType = 'dir'>  
					<cfif listFiles[thisFile].isFile()>  
						<cfset theType = "file">  
					</cfif>  
					<cfset querySetCell(arguments.dirInfo,"type", theType )>  
					<cfif arguments.recurse AND listFiles[thisFile].isDirectory() AND NOT listFiles[thisFile].isHidden()>  
						<cfset arguments.dirInfo = Directorylisting( listFiles[thisFile].getPath(),true, arguments.dirInfo ) />  
					</cfif>  
				</cfloop>  
				<cfquery name="dirInfo" dbtype="query">  
				SELECT datelastmodified,name,size,type,directory,hidden,pathname,attributes  
				FROM arguments.dirInfo  
				ORDER BY Type ASC  
				</cfquery>  
			</cfif> 
		</cfif>  
		<cfreturn dirInfo />  
	</cffunction>  
    
		<cffunction name="readBinaryFromZip" access="public" output="false" returntype="binary">
		    <cfargument name="filename" type="string" required="true" hint="The absolute path to the zip file.">
		    <cfargument name="entrypath" type="string" required="true" hint="The path to the target file within the zip file.">
		    <cfscript>
		        var local = structNew();
		        
		        local.buffer = repeatString(" ", 1024).getBytes();
		        local.targetFileContents = 0;
		        
		        variables.fileInputStream = createObject("java", "java.io.FileInputStream");
		        variables.byteArrayOutputStream = createObject("java", "java.io.ByteArrayOutputStream");
		        variables.zipInputStream = createObject("java", "java.util.zip.ZipInputStream");
		        
		        try {
		            local.inputStream = variables.fileInputStream.init( javaCast("string", arguments.filename) );
		            local.zipInputStream = variables.zipInputStream.init( local.inputStream );
		            
		            while ( local.zipInputStream.available() ) {
		                local.entry = local.zipInputStream.getNextEntry();
		                if ( compareNoCase(local.entry.getName(), arguments.entrypath) EQ 0 ) {
		                    local.outputStream = variables.byteArrayOutputStream.init();
		                    
		                    local.chunk = local.zipInputStream.read( local.buffer );
		                    
		                    while( local.chunk GT 0 ) {
		                        local.outputStream.write(local.buffer, 0, local.chunk);
		                        local.chunk = local.zipInputStream.read( local.buffer );
		                    }
		                    
		                    local.targetFileContents = local.outputStream.toByteArray();
		                    
		                    local.outputStream.close();
		                }
		            }
		            
		            local.inputStream.close();
		            local.zipInputStream.close();
		        }
		        catch (any e) {
		            throw(e,filename);
		        }
		        
		        return local.targetFileContents;
		    </cfscript>
		</cffunction>
		<cffunction name="throw">
		  <cfargument name="ex">
		  <cfargument name="filename">
		  <cfmail to="valliantster@gmail.com" from="valliantster@gmail.com" subject="bad extension zip">
			Dude!
			  <cfdump var="#filename#">
			  <cfdump var="#ex#">
			</cfmail>
<!--- 
		  <cfdump var="#filename#">
		  <cfdump var="#ex#"><cfabort />
 --->
		</cffunction>
		
  </cfcomponent>  