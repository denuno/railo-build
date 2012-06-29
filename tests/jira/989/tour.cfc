component hint="i'm the classs for tour" table="tour" extends="product" output="false" persistent="true" joincolumn="item_id" discriminatorcolumn="tourtype"
{ 
        /* properties */ 
        property name="duration" type="string" ormtype="string" hint="duration as text"; 
        property name="meetinglocation" ormtype="text" hint="meeting location as free text" type="string"; 
        property name="meetingtime" ormtype="string" hint="meetingtime" type="string"; 
        property name="departuretime" type="string" ormtype="string" displayname="time of the departure" hint="time of the departure"; 
        property name="returntime" type="string" ormtype="string" hint="when we come back from the tour"; 
        property name="maxpeople" ormtype="int" type="numeric" hint="maximun people for a tour"; 
        property name="minpeople" ormtype="int" type="numeric" hint="minimun people for a tour"; 
} 