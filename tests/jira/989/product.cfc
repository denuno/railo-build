component  hint="I'm the base product component" output="false" persistent="true" display="product"  discriminatorcolumn="tourtype"
{ 
	property name="item_id" type="uuid" ormtype="string" fieldtype="id" generator="uuid" hint="key of the product"; 
	property name="thumbnail_small" type="string"; 
	property name="thumbnail_big" type="string"; 
	property name="teaser" ormtype="text" type="string" hint="the teasertext the in master list"; 
	property name="description" type="string" ormtype="text" hint="free text description of the product"; 
	property name="highlights" ormtype="text" hint="highlighs tour as free text" type="string"; 
} 