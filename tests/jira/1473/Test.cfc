<cfscript>
component {
	
	STR_FALSE = 'x"false"';
	STR_TRUE = 'x"true"';
	BOOL_FALSE = 'xfalse';
	BOOL_TRUE = 'xtrue';

	public void function cfargumentTypeBooleanWithDefaultShouldSerializeCorrectly() {
		var expectedFalse = '{"KEY":false}';
		var expectedTrue = '{"KEY":true}';
		var tbc = new TagBasedComponent();
		var results = [];
		
		this.valueEquals(BOOL_FALSE,"x"&getMockStructFalse(),"script key = false");
		this.valueEquals(BOOL_TRUE,"x"&getMockStructTrue(),'script key = true');
		
		this.valueEquals(BOOL_FALSE,"x"&getMockStructDoubleQuoteFalseDoubleQuote(),'script key = "false"');
		this.valueEquals(BOOL_TRUE,"x"&getMockStructDoubleQuoteTrueDoubleQuote(),'script key = "true"');
		
		this.valueEquals(BOOL_FALSE,"x"&getMockStructDoubleQuotePoundFalsePoundDoubleQuote(),'script key = "##false##"');
		this.valueEquals(BOOL_TRUE,"x"&getMockStructDoubleQuotePoundTruePoundDoubleQuote(),'script key = "##true##"');
		
		this.valueEquals(BOOL_TRUE,"x"&tbc.getMockStructTrue(),'tag default="true"');
		this.valueEquals(BOOL_FALSE,"x"&tbc.getMockStructFalse(),'tag default="false"');
		
		this.valueEquals(BOOL_TRUE,"x"&tbc.getMockStructPoundTruePound(),'tag default="##true##"');
		this.valueEquals(BOOL_FALSE,"x"&tbc.getMockStructPoundFalsePound(),'tag default="##false##"');
		
	}

	private string function getMockStructFalse(boolean key = false) {
		return serializeJson(arguments.key);
	}
	private string function getMockStructTrue(boolean key = true) {
		return serializeJson(arguments.key);
	}

	private string function getMockStructDoubleQuoteFalseDoubleQuote(boolean key = "false") {
		return serializeJson(arguments.key);
	}

	private string function getMockStructDoubleQuoteTrueDoubleQuote(boolean key = "true") {
		return serializeJson(arguments.key);
	}

	private string function getMockStructDoubleQuotePoundFalsePoundDoubleQuote(boolean key = "#false#") {
		return serializeJson(arguments.key);
	}

	private string function getMockStructDoubleQuotePoundTruePoundDoubleQuote(boolean key = "#true#") {
		return serializeJson(arguments.key);
	}
}
</cfscript>