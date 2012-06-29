/**
 * I model the Billing Address
 * In the database this is persisted as a table per hierachy, using a
discriminator value of "BILLING"
 */
component extends="BaseAddress" persistent="true"
table="ADDRESSES3244759" discriminatorvalue="BILLING"
{
	property name="sssss" type="string"; 
}