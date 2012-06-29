/**
abc
* @output true
def
* @fromDocComment hello from doc comment
@hint hint param 
ghi
@test1.hint hello  
*/component implements="ITest" fromCFC="hello from CFC" { 

	/**
    hint property 1
    * @metaprop1 value meta prop 1
    @scale vm
    */
	property name="prop1"; 


    /**
    @output false
    * Hello World 
	* @susi1 susanne 1
	* @susi2 susi sorglos
	* @susi3 
    * @ 
    aa bb * 
    * how are you
	*/
    function test1() {  
    
    }
    
    /**
     Hello World 
	*/
    function test2() { 

    }
    
    /**
     Hello World 
     @susi Susanne
     @urs.buehler Urs Buehler
     @lastName Last Name
     @firstName.hint First Name
     @firstName.urs Urs
     @firstName.a.b.c ABC
     @firstName. point
     
	*/ 
    function test3(lastname,firstname) {   
     
    }
    
    
    function test4(arg1,arg2) { 
    
    }
} 