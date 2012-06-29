component persistent="true" table="baskets" { 
	property name="id" column="basket_id" fieldtype="id";
    property name="cartitems" fieldtype="one-to-many" cfc="CartItem" fkcolumn="basketitem_basket_id";
}