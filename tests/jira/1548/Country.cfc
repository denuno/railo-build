component persistent="true" table="COUNTRIES1548" { 
	property name="countryid" column="country_id" fieldtype="id" generator="native"; 
    property name="code" column="country_code"; 
    // only used for lookup in HQL below 
    property name="DeliveryZone" fieldtype="many-to-one" fkcolumn="fk_deliveryzone_id" cfc="DeliveryZone"; 
}