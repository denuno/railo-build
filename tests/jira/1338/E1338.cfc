component output="false" persistent="true" { 
	property name="id" fieldtype="id" generator="identity" ormtype="int"; 
     
	property name="r1s" singularname="r1" type="array" cfc="R1338" fieldtype="one-to-many" xfkcolumn="rId"; 
	property name="r2s" singularname="r2" type="array" cfc="R1338" fieldtype="one-to-many" xfkcolumn="rId"; 

 }