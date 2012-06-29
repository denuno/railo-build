component persistent="true" entityname="OrderDetail" table="OrderDetails981" 
{ 
	property name="orderDetailID" fieldtype="id" generator="identity"; 

	property name="order" fieldtype="many-to-one" fkcolumn="orderID" cfc="Orders981" missingRowIgnored="true";
	property name="product" fieldtype="one-to-one" cfc="Products981" fkcolumn="productID" ;
} 
