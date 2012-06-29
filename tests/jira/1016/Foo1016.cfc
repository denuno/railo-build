component persistent='true' {
	property name='id' fieldtype='id' generator='assigned' ormtype='string' length='36' notnull='true';
	property name='foo';
	
    function init()	{ 
    	return this;
    }
}