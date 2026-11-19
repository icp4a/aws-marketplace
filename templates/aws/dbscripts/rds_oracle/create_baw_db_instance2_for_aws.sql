-- Please ensure you already have an existing Oracle instance or pluggable database (PDB).

-- Create a new user.
CREATE USER AWSDB IDENTIFIED BY "<password>";

-- Allow the user to connect to the database.
GRANT CONNECT TO AWSDB;

CREATE TABLESPACE AWSDBTS DATAFILE SIZE 200M AUTOEXTEND ON NEXT 20M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO ONLINE PERMANENT;
CREATE TEMPORARY TABLESPACE AWSDBTS_TEMP TEMPFILE SIZE 200M AUTOEXTEND ON NEXT 20M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL;

ALTER USER AWSDB QUOTA UNLIMITED ON AWSDBTS;

ALTER USER AWSDB
     DEFAULT TABLESPACE AWSDBTS
     TEMPORARY TABLESPACE AWSDBTS_TEMP;

-- Grant the privileges to create database objects.
GRANT CREATE TABLE TO AWSDB;
GRANT CREATE PROCEDURE TO AWSDB;
GRANT CREATE SEQUENCE TO AWSDB;
GRANT CREATE VIEW TO AWSDB;

-- Grant the access rights to resolve lock issues.
GRANT EXECUTE ON DBMS_LOCK TO AWSDB;

-- Grant the access rights to resolve XA related issues.
EXEC rdsadmin.rdsadmin_util.grant_sys_object('PENDING_TRANS$', 'AWSDB', 'SELECT');
EXEC rdsadmin.rdsadmin_util.grant_sys_object('DBA_2PC_PENDING', 'AWSDB', 'SELECT');
EXEC rdsadmin.rdsadmin_util.grant_sys_object('DBA_PENDING_TRANSACTIONS', 'AWSDB', 'SELECT');
EXEC rdsadmin.rdsadmin_util.grant_sys_object('DBMS_XA', 'AWSDB', 'EXECUTE');
EXIT;
