<cfscript>

// create new entity in current session
	
	function getEntities(id){
		
		
		
		var c=entityNew("Cart");
		c.setId(id);
		var ci=entityNew("CartItem");
		var ci2=new CartItem();
		

		c.addCartitems(ci);
		c.addCartitems(ci2);
		entitySave(c);
		entitySave(ci);
		entitySave(ci2);
		
        ormFlush();
		
		
		c=entityLoadByPK("Cart",id);
		ci=entityNew("CartItem");
		c.addCartitems(ci);
		
		return c;
		
		
		
		
		
		
		/*var entity = entityNew( 'PT' );
		entity.setID( id );
		entity.setFoo( name);
		entitySave( entity);*/
	}
	
	
	
	

</cfscript>
