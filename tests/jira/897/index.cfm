

<cfimport path="com.andreacfm.caching.*"> 


<cf_valueequals 
	left="#new org.andreacfm.caching.SimpleCache().getName()#" 
    right="#getDirectoryFromPath(getCurrenttemplatePath())#org/andreacfm/caching/SimpleCache.cfc">
<cf_valueequals 
	left="#new com.andreacfm.caching.SimpleCache().getName()#" 
    right="#getDirectoryFromPath(getCurrenttemplatePath())#org/andreacfm/caching/SimpleCache.cfc">
<cf_valueequals 
	left="#new SimpleCache().getName()#" 
    right="#getDirectoryFromPath(getCurrenttemplatePath())#org/andreacfm/caching/SimpleCache.cfc">
