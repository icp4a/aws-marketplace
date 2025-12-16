-- Please ensure you already have existing oracle instance or pluggable database (PDB). If not, please create one first

-- NOTE: The tablespace creation command below uses file-based storage.  
-- If your Oracle environment uses ASM (Automatic Storage Management),  
-- update the 'DATAFILE' and 'TEMPFILE' paths to reflect your ASM configuration.  
-- Additionally, ensure that database object names (e.g., tablespace, user, etc.)  
-- match the expected naming conventions. Any deviations may cause issues.

-- create a new user
CREATE USER BASDB IDENTIFIED BY <password>;

-- allow the user to connect to the database
GRANT CONNECT TO BASDB;

-- Note:
-- 1. /home/oracle/orcl is a folder in the PV.
-- 2. You must specify the DATAFILE or TEMPFILE clause unless you have enabled Oracle Managed Files by setting a value for the DB_CREATE_FILE_DEST initialization parameter. 
CREATE TABLESPACE BASDBTS
     DATAFILE '/home/oracle/orcl/BASDBTS.dbf' SIZE 200M REUSE
     AUTOEXTEND ON NEXT 20M
     EXTENT MANAGEMENT LOCAL
     SEGMENT SPACE MANAGEMENT AUTO
     ONLINE
     PERMANENT
;
CREATE TEMPORARY TABLESPACE BASDBTS_TEMP
     TEMPFILE '/home/oracle/orcl/BASDBTS_TEMP.dbf' SIZE 200M REUSE
     AUTOEXTEND ON NEXT 20M
     EXTENT MANAGEMENT LOCAL
;

ALTER USER BASDB QUOTA UNLIMITED ON BASDBTS;
 
ALTER USER BASDB
     DEFAULT TABLESPACE BASDBTS
     TEMPORARY TABLESPACE BASDBTS_TEMP;

-- Grant the privileges to create database objects.
GRANT  CREATE TABLE TO BASDB;
GRANT  CREATE PROCEDURE TO BASDB;
GRANT  CREATE SEQUENCE TO BASDB;
GRANT  CREATE VIEW TO BASDB;

-- grant access rights to resolve lock issues
GRANT EXECUTE ON DBMS_LOCK TO BASDB;

-- grant access rights to resolve XA related issues
GRANT SELECT ON PENDING_TRANS$ TO BASDB;
GRANT SELECT ON DBA_2PC_PENDING TO BASDB;
GRANT SELECT ON DBA_PENDING_TRANSACTIONS TO BASDB;
GRANT EXECUTE ON DBMS_XA TO BASDB;
EXIT;