component displayName='Application' {
    this.name = 'railo_ber';
    this.datasource = 'railo_mirror';

    this.ormEnabled = true;
    this.ormSettings = {
    dbcreate = 'dropcreate',

    eventhandler='OrmEventHandler' ,
    datasourcex = 'railo_mirror'
    };
}