-- Creating DB named: aaedb
CALL rdsadmin.create_database('aaedb',32768,'UTF-8','US' );

--- Comment out all SQL stored procedures below when you are creating the database.
--- Once the database is created, comment out the create_database stored procedure statement and uncomment the below statements and execute them.
--- Creation of the Database can take some time, Please wait for a few minutes before executing the statements below.

-- Create bufferpool
CALL rdsadmin.create_bufferpool('aaedb','DBASBBP',1024,'Y','Y',32768,0,32);

-- Create table spaces
CALL rdsadmin.create_tablespace('aaedb','AAEENG_TS','DBASBBP',32768,NULL,NULL,'U','AUTOMATIC');
CALL rdsadmin.create_tablespace('aaedb','AAEENG_TEMP_TS','DBASBBP',32768,NULL,NULL,'T','AUTOMATIC');

-- Create role for the database with the role name of BAA
CALL rdsadmin.create_role('aaedb','BAA');
-- Create a user
CALL rdsadmin.add_user('<username>','<password>',null);
CALL rdsadmin.grant_role(?,'aaedb','BAA','USER <username>','N');
CALL rdsadmin.dbadm_grant(?,'aaedb','DBADM','USER <username>');

--- Execute the below statement after the admin user is connected to the newly created Database
GRANT SELECT ON SYSIBM.SYSVERSIONS TO USER <username>;
GRANT SELECT ON SYSCAT.DATATYPES TO USER <username>;
GRANT SELECT ON SYSCAT.INDEXES TO USER <username>;
GRANT SELECT ON SYSIBM.SYSDUMMY1 TO USER <username>;
GRANT USAGE ON WORKLOAD SYSDEFAULTUSERWORKLOAD TO USER <username>;
GRANT IMPLICIT_SCHEMA ON DATABASE TO USER <username>;
CREATE SCHEMA <username> AUTHORIZATION <username>;
GRANT EXECUTE ON PACKAGE NULLID.SYSSH200 TO USER <username>;

-- Done creating and tuning DB named: aaedb
