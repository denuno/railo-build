/**
 * I am the address base class
 */
component persistent="true" table="ADDRESSES3244759"
discriminatorColumn="addressType"
{
       property name="addressid" column="address_id" fieldtype="id" generator="native";

       property name="title" column="address_title" default="";
       property name="forename" column="address_forename" default="";
       property name="surname" column="address_surname" default="";
       property name="email" column="address_email" default="";
       property name="telephone" column="address_telephone" default="";
       property name="house" column="address_house" default="";
       property name="street" column="address_street" default="";
       property name="district" column="address_district" default="";
       property name="town" column="address_town" default="";
       property name="county" column="address_county" default="";
       property name="postcode" column="address_postcode" default="";

}