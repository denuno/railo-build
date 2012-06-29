/**
 * I model the Shipping Address
 * In the database this is persisted as a table per hierachy, using a
discriminator value of "SHIPPING"
 */
component extends="BaseAddress" persistent="true"
table="ADDRESSES3244759" discriminatorvalue="SHIPPING"
{
	//property name="city" type="string"; 
}
