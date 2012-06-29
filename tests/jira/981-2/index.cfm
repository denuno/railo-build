<!--- index.cfm --->

<cfquery name="qryOrders" >
	SELECT orderID from orders981
</cfquery>

<cfoutput query="qryOrders">
	<a href="index.cfm?orderID=#orderID#">Dump orderID #orderID#</a><br>
</cfoutput>


<cfscript>
//ormreload();

if (isDefined("url.orderID"))
{
	order = entityLoadByPK("order", url.orderID);
	writeDump(order);
}

if (qryOrders.recordCount LT 1)
{
	//create an order
	product = entityNew("product");
	product.setName("widget");
	EntitySave(product);

	orderDetail = entityNew("orderDetail");
	orderDetail.setProduct(product);


	order = entityNew("order");
	order.setDescription("test order");
	order.addOrderDetail(orderDetail);

	orderDetail.setOrder(order)

	EntitySave(order);
	EntitySave(orderDetail);
	location("index.cfm",false);
}

</cfscript>
