component displayname='OrmEventHandler'  implements="CFIDE.ORM.IEventHandler"
{ 

    public void function preLoad( any entity ) 
    { 
    systemOutput(  'preLoad' ); 
    } 
    
    public void function postLoad( any entity ) 
    { 
    systemOutput(  'postLoad' ); 
    } 
    
    public void function preInsert( any entity ) 
    { 
    systemOutput(  'preInsert' ); 
    } 
    
    public void function postInsert( any entity ) 
    { 
    systemOutput(  'postInsert' ); 
    } 
    
    public void function preUpdate( entity, struct oldData ) 
    { 
    systemOutput(  'preUpdate' ); 
    } 
    
    public void function postUpdate( any entity ) 
    { 
    systemOutput(  'postUpdate' ); 
    } 
    
    public void function preDelete( any entity ) 
    { 
    systemOutput(  'preDelete' ); 
    } 
    
    public void function postDelete( any entity ) 
    { 
    systemOutput(  'postDelete' ); 
    } 

} 