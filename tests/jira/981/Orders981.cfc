component persistent="true" entityname="Order" table="Orders981" 
{ 
	property name="orderID" fieldtype="id" generator="identity"; 
	property name="description";
	property name="orderDetails" type="array" fieldtype="one-to-many" cfc="OrderDetails981" singularname="orderDetail" fkcolumn="orderID" inverse="true" cascade="all-delete-orphan" ;
} 
