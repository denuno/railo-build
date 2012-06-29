<div style="width:48%; overflow:auto; float:left;">
	<h1>Works</h1>
	
	<cfscript>
		imgWorks = ImageRead(expandPath('.')&"/works.JPG");
		writeDump(var=imageInfo(imgWorks),label="Working Image Info");
	</cfscript>
	<!--- Test with Not working Image --->
	<cfscript>	
		ImageScaleToFit(imgWorks,200,200);
		imageWrite(imgWorks,expandPath('.')&"/workingafter.JPG");
	</cfscript>
	
	<img src="workingafter.JPG" />
	<img style="width:30%;" src="notworking.JPG" />
</div>

<div style="width:48%; overflow:auto; float:left; border-left:3px dashed grey; margin-left:1%; padding-left:1%;">
	<h1>Does not Work</h1>
	
	<cfscript>	
		imgNotWorking = ImageRead(expandPath('.')&"/notworking.JPG");
		writeDump(var=imageInfo(imgNotWorking),label="Not Working Image Info");
	</cfscript>
	
	
	<cfscript>	
		ImageScaleToFit(imgNotWorking,200,200);
		imageWrite(imgNotWorking,expandPath('.')&"/notworkingafter.JPG");
	</cfscript>
	<img src="notworkingafter.JPG" />
	<img style="width:30%;" src="notworking.JPG" />
</div>