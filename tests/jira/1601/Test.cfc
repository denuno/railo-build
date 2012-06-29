component persistent="true" table="Test1601" { 
property name="ID" fieldtype="id" generator="uuid" ; 
property name="Name"; 
property name="DateCreated" type="date" ormtype="timestamp"; 
property name="Test" type="string"; 


	public void function preInsert() { 
		//systemOutput("hash:<hash-code><print-stack-trace>",true,true);
    	setTest("Salve");
    	setDateCreated(now()); 
    } 
}