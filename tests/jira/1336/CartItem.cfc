component persistent="true" table="carts" { 
	property name="id" column="basket_id" generator="native"; 
    property name="ipaddress" column="basket_ip"; 
    property name="cartitems" fieldtype="one-to-many" cfc="Cart" fkcolumn="basketitem_basket_id";
}