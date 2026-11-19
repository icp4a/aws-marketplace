-- Creating DB named: ICNDB
CALL rdsadmin.create_database('ICNDB',32768,'UTF-8','US' );

--- Comment out all SQL stored procedures below when you are creating the database.
--- Once the database is created, comment out the create_database stored procedure statement and uncomment the below statements and execute them.
--- Creation of the Database can take some time, Please wait for a few minutes before executing the statements below.

CALL rdsadmin.create_bufferpool('ICNDB','ICNDB_BP',1024,'Y','Y',32768,0,32);
CALL rdsadmin.create_bufferpool('ICNDB','ICNDB_TEMPBP',1024,'Y','Y',32768,0,32);

-- The default table space name is "ICNDB".
-- If use default table space name "ICNDB", you do not need to input the value for spec.navigator_configuration.icn_production_setting.icn_table_space.
-- If change table space name, you need to use same value for spec.navigator_configuration.icn_production_setting.icn_table_space in custom resource.
CALL rdsadmin.create_tablespace('ICNDB','ICNDB','ICNDB_BP',32768,NULL,NULL,'U','AUTOMATIC');
CALL rdsadmin.create_tablespace('ICNDB','ICNDB_TEMP','ICNDB_TEMPBP',32768,NULL,NULL,'T','AUTOMATIC');

-- Create role for the database ICNDB with the role name of BAN
CALL rdsadmin.create_role('ICNDB','BAN');
-- Create a user
CALL rdsadmin.add_user('<username>','<password>',null);
CALL rdsadmin.grant_role(?,'ICNDB','BAN','USER <username>','N');
CALL rdsadmin.dbadm_grant(?,'ICNDB','DBADM','USER <username>');
CALL rdsadmin.update_db_param('ICNDB','LOCKTIMEOUT','30');

--- Execute the below statement after the admin user is connected to the newly created Database
GRANT CONNECT ON DATABASE TO USER <username>;
GRANT SELECT ON SYSIBM.SYSVERSIONS TO USER <username>;
GRANT SELECT ON SYSCAT.DATATYPES TO USER <username>;
GRANT SELECT ON SYSCAT.INDEXES TO USER <username>;
GRANT SELECT ON SYSIBM.SYSDUMMY1 TO USER <username>;
GRANT USAGE ON WORKLOAD SYSDEFAULTUSERWORKLOAD TO USER <username>;
GRANT IMPLICIT_SCHEMA ON DATABASE TO USER <username>;
CREATE SCHEMA ICNDB AUTHORIZATION <username>;
GRANT EXECUTE ON PACKAGE NULLID.SYSSH200 TO USER <username>;

-- Done creating and tuning DB named: ICNDB
