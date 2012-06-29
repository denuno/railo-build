component displayName='Entity991' extends='Base991' persistent='true'
{
property name='id' fieldtype='id';
property name='foo' default='default';

function init()

{ super.init(); setFoo( '#getFoo()# entity' ); return this; }
}