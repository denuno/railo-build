<cfscript>
	
	cruise = entityNew("cruise");
	//product
	cruise.setThumbNail_small("thumbsmall.jpg");
	cruise.setThumbNail_big("thumbbig.jpg");
	cruise.setTeaser("This is the teaser");
	cruise.setDescription("This is the description");
	cruise.setHighlights("These are the hightlights");

	//tour
	cruise.setDuration("3 hours");
	cruise.setMeetingLocation("Near the pickup spot");

	cruise.setMeetingTime("9AM");

	cruise.setDepartureTime("10AM");
	cruise.setReturnTime("11PM");
	cruise.setMaxPeople("10");
	cruise.setMinPeople("1");
				
	//cruise
	cruise.setVessel("SS ORM");
	
	entitySave(cruise);
	

	daytour = entityNew("daytour");
	//product
	daytour.setThumbNail_small("thumbsmall.jpg");
	daytour.setThumbNail_big("thumbbig.jpg");
	daytour.setTeaser("This is the teaser");
	daytour.setDescription("This is the description");
	daytour.setHighlights("These are the hightlights");

	//tour
	daytour.setDuration("3 hours");
	daytour.setMeetingLocation("Near the pickup spot");

	daytour.setMeetingTime("9AM");

	daytour.setDepartureTime("10AM");
	daytour.setReturnTime("11PM");
	daytour.setMaxPeople("10");
	daytour.setMinPeople("1");
				
	//cruise
	daytour.setCity("My City");
	
	
		entitySave(daytour);
	
</cfscript>

<cfdump var="#cruise#" /><cfabort />