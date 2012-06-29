<cfscript>
component displayName='Application' 
{


	this.sessionmanagement=true;
	this.name ="context1586";
    
	
	
    function onRequestStart(){
		 request.data=[
    	"we you us",
        "we+you us",
        "we%20you us"
    ];
	}
	
   
} 
</cfscript>