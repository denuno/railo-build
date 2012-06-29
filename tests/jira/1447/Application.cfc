component displayName='Application' 
{


	this.sessionmanagement=true;
	this.name ="context1250";
	
	request.base="http://#cgi.HTTP_HOST##GetDirectoryFromPath(cgi.SCRIPT_NAME)#";
    request.base=replace(request.base,'8501','8080');
	request.current=GetDirectoryFromPath(GetCurrentTemplatePath());
    
    
    
    
    function dump2() {
    	var x='צהü1';
    	form[x]=1;
    	var str=structKeyList(form);
        var barr=str.getBytes("utf-8");
        
        writedump("+++++++++++++++++++++");
        writedump(barr);
        writedump(str);
        
        
        for(var i=1;i<=arrayLen(barr);i++){
        	writedump(barr[i]);
        }
        writedump("x:"& x);
        
    }
    request.dump2=dump2;
} 