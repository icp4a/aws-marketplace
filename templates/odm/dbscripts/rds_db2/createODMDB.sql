-- Creating DB named: odmdb
CALL rdsadmin.create_database('odmdb',32768,'UTF-8','US' );

--- Comment out all SQL stored procedures below when you are creating the database.
--- Once the database is created, comment out the create_database stored procedure statement and uncomment the below statements and execute them.
--- Creation of the Database can take some time, Please wait for a few minutes before executing the statements below.

-- Create bufferpool
CALL rdsadmin.create_bufferpool('odmdb','odmdb_BP32K',1024,'Y','Y',32768,0,32);

-- Create table spaces
CALL rdsadmin.create_tablespace('odmdb','odmdb_RESDWTS','odmdb_BP32K',32768,NULL,NULL,'T','AUTOMATIC');
CALL rdsadmin.create_tablespace('odmdb','odmdb_RESDWTMPTS','odmdb_BP32K',32768,NULL,NULL,'S','AUTOMATIC');

-- Create role for the database with the role name of ODM
CALL rdsadmin.create_role('odmdb','ODM');
-- Create a user
CALL rdsadmin.add_user('<username>','<password>','odm_group');
CALL rdsadmin.grant_role(?,'odmdb','ODM','USER <username>','N');
CALL rdsadmin.dbadm_grant(?,'odmdb','DBADM','GROUP odm_group');

--- Execute the below statement after the admin user is connected to the newly created Database
GRANT CONNECT ON DATABASE TO GROUP odm_group;
GRANT CREATETAB ON DATABASE TO GROUP odm_group;
GRANT SELECT ON SYSIBM.SYSVERSIONS TO GROUP odm_group;
GRANT SELECT ON SYSCAT.DATATYPES TO GROUP odm_group;
GRANT SELECT ON SYSCAT.INDEXES TO GROUP odm_group;
GRANT SELECT ON SYSIBM.SYSDUMMY1 TO GROUP odm_group;
GRANT USAGE ON WORKLOAD SYSDEFAULTUSERWORKLOAD TO GROUP odm_group;
GRANT IMPLICIT_SCHEMA ON DATABASE TO GROUP odm_group;
CREATE SCHEMA <username> AUTHORIZATION <username>;
GRANT EXECUTE ON PACKAGE NULLID.SYSSH200 TO GROUP odm_group;
GRANT EXECUTE ON PACKAGE NULLID.SYSSN200 TO GROUP odm_group;
GRANT EXECUTE ON PACKAGE NULLID.SYSSN300 TO GROUP odm_group;
GRANT EXECUTE ON PROCEDURE SYSIBM.SQLGETTYPEINFO TO GROUP odm_group;
GRANT EXECUTE ON PROCEDURE SYSIBM.SQLTABLES TO GROUP odm_group;

-- Done creating and tuning DB named: odmdb
