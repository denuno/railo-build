component output="false" persistent="true" { 
	property name="id" fieldtype="id" generator="identity" ormtype="int"; 
	
    property name="e" cfc="E1338" fieldtype="many-to-one" xfkcolumn="rId";
    
    
    
 }