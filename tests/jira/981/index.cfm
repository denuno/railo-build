<cfsetting showdebugoutput="no">
<cfscript>
entities=entityLoad("Order");

if(arrayLen(entities) EQ 0) {
	//create an order
	product = entityNew("product");
	product.setName("widget");
	EntitySave(product);

	orderDetail = entityNew("orderDetail");
	orderDetail.setProduct(product);


	order = entityNew("order");
	order.setDescription("test order");
	order.addOrderDetail(orderDetail);

	orderDetail.setOrder(order);

	EntitySave(order);
	EntitySave(orderDetail);
}

entities=entityLoad("Order");
</cfscript>

<cfloop from="1" to="#arrayLen(entities)#" index="i">
	<cfset order = entityLoadByPK("order", entities[i].getOrderID())>
    <cf_valueEquals left="#order.getDescription()#" right="test order">
</cfloop>