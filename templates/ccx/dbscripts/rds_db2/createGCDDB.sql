-- Creating DB named: GCDDB
CALL rdsadmin.create_database('GCDDB',32768,'UTF-8','US' );

--- Comment out all SQL stored procedures below when you are creating the database.
--- Once the database is created, comment out the create_database stored procedure statement and uncomment the below statements and execute them.
--- Creation of the Database can take some time, Please wait for a few minutes before executing the statements below.

-- Create bufferpool
CALL rdsadmin.create_bufferpool('GCDDB','GCDDB_1_32K',1024,'Y','Y',32768,0,32);
CALL rdsadmin.create_bufferpool('GCDDB','GCDDB_2_32K',1024,'Y','Y',32768,0,32);

-- Create table spaces
CALL rdsadmin.create_tablespace('GCDDB','GCDDATA_TS','GCDDB_1_32K',32768,NULL,NULL,'U','AUTOMATIC');
CALL rdsadmin.create_tablespace('GCDDB','GCDDB_TMP_TBS','GCDDB_2_32K',32768,NULL,NULL,'T','AUTOMATIC');

-- Create role for the database GCDDB with the role name of FNCM
CALL rdsadmin.create_role('GCDDB','FNCM');
-- Create a user
CALL rdsadmin.add_user('<username>','<password>',null);
CALL rdsadmin.grant_role(?,'GCDDB','FNCM','USER <username>','N');
CALL rdsadmin.update_db_param('GCDDB','LOCKTIMEOUT','30');

--- Execute the below statement after the admin user is connected to the newly created Database
GRANT CREATETAB,CONNECT ON DATABASE TO USER <username>;
GRANT USE OF TABLESPACE GCDDATA_TS TO USER <username>;
GRANT USE OF TABLESPACE GCDDB_TMP_TBS TO USER <username>;
GRANT SELECT ON SYSIBM.SYSVERSIONS TO USER <username>;
GRANT SELECT ON SYSCAT.DATATYPES TO USER <username>;
GRANT SELECT ON SYSCAT.INDEXES TO USER <username>;
GRANT SELECT ON SYSIBM.SYSDUMMY1 TO USER <username>;
GRANT USAGE ON WORKLOAD SYSDEFAULTUSERWORKLOAD TO USER <username>;
GRANT IMPLICIT_SCHEMA ON DATABASE TO USER <username>;
CREATE SCHEMA <username> AUTHORIZATION <username>;
GRANT SQLADM ON DATABASE TO USER <username>;
GRANT EXECUTE ON PACKAGE NULLID.SYSSH200 TO USER <username>;
GRANT EXECUTE ON PACKAGE NULLID.SYSSN200 TO USER <username>;

-- Done creating and tuning DB named: GCDDB
