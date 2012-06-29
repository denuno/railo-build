component {		
	property name="field1" type="string";		
		
	public MyClass function init() {
		this.field1 = "first";				
		return this;
	}	
	
	public string function getField1(){
		return this.field1;
	}
	
	public void function setField1(required string field1){
		this.field1 = arguments.field1;
	}

	/* serialize to base64 */
	public string function serialize(){		
		var byteOut = CreateObject("java", "java.io.ByteArrayOutputStream");
		byteOut.init();		
		var objOut = CreateObject("java", "java.io.ObjectOutputStream");
		objOut.init(byteOut);
		objOut.writeObject(this);
		objOut.close();
		
		return ToBase64(byteOut.toByteArray());
	}
	
	/* this should be a static function... 
	 * to use it just create an empty instance: 
	 *   myOriginalClass = new MyClass().deserialize(yourSerializedClass);
	 */
	public MyClass function deserialize(required string serializedClass){		
		var bytearray = BinaryDecode(arguments.serializedClass,"Base64");
		
		if(isBinary(bytearray)){			
			var byteIn = CreateObject("java", "java.io.ByteArrayInputStream");
			byteIn.init(bytearray);			
			var objIn = CreateObject("java", "java.io.ObjectInputStream");
			objIn.init(byteIn);			
			var newCFCInstance = objIn.readObject();			
			objIn.close();
			
			if(isInstanceOf(newCFCInstance,"MyClass")){
				return newCFCInstance;
			}
			
			throw("InvalidArgumentType",message="recreated instance must be of type MyClass"); 
		}
		throw("InvalidArgumentType",message="serializedClass must be a base64 string decodable to binary"); 
	}	
	
}