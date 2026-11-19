-- Please ensure you already have existing oracle instance or pluggable database (PDB). If not, please create one firstly

-- Create a new user.
CREATE USER AWSDB IDENTIFIED BY "<password>";

-- Allow the user to connect to the database.
GRANT CONNECT TO AWSDB;

-- Note:
-- 1. /home/oracle/orcl is a folder in the PV.
-- 2. You must specify the DATAFILE or TEMPFILE clause unless you have enabled Oracle Managed Files by setting a value for the DB_CREATE_FILE_DEST initialization parameter. 
CREATE TABLESPACE AWSDBTS
     DATAFILE '/home/oracle/orcl/AWSDBTS.dbf' SIZE 200M REUSE
     AUTOEXTEND ON NEXT 20M
     EXTENT MANAGEMENT LOCAL
     SEGMENT SPACE MANAGEMENT AUTO
     ONLINE
     PERMANENT
;
CREATE TEMPORARY TABLESPACE AWSDBTS_TEMP
     TEMPFILE '/home/oracle/orcl/AWSDBTS_TEMP.dbf' SIZE 200M REUSE
     AUTOEXTEND ON NEXT 20M
     EXTENT MANAGEMENT LOCAL
;

ALTER USER AWSDB QUOTA UNLIMITED ON AWSDBTS;
 
ALTER USER AWSDB
     DEFAULT TABLESPACE AWSDBTS
     TEMPORARY TABLESPACE AWSDBTS_TEMP;

-- Grant the privileges to create database objects.
GRANT  CREATE TABLE TO AWSDB;
GRANT  CREATE PROCEDURE TO AWSDB;
GRANT  CREATE SEQUENCE TO AWSDB;
GRANT  CREATE VIEW TO AWSDB;

-- Grant the access rights to resolve lock issues.
GRANT EXECUTE ON DBMS_LOCK TO AWSDB;

-- Grant the access rights to resolve XA related issues.
GRANT SELECT ON PENDING_TRANS$ TO AWSDB;
GRANT SELECT ON DBA_2PC_PENDING TO AWSDB;
GRANT SELECT ON DBA_PENDING_TRANSACTIONS TO AWSDB;
GRANT EXECUTE ON DBMS_XA TO AWSDB;
EXIT;
