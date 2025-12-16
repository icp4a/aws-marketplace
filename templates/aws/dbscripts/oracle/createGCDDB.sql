-- Please ensure you already have existing oracle instance or pluggable database (PDB). If not, please create one first

-- NOTE: The tablespace creation command below uses file-based storage.  
-- If your Oracle environment uses ASM (Automatic Storage Management),  
-- update the 'DATAFILE' and 'TEMPFILE' paths to reflect your ASM configuration.  
-- Additionally, ensure that database object names (e.g., tablespace, user, etc.)  
-- match the expected naming conventions. Any deviations may cause issues.

-- create tablespace
-- Please make sure you change the DATAFILE and TEMPFILE to your Oracle database.
CREATE TABLESPACE GCDDBDATATS DATAFILE '/home/oracle/orcl/GCDDBDATATS.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 20M EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO ONLINE PERMANENT;
CREATE TEMPORARY TABLESPACE GCDDBDATATSTEMP TEMPFILE '/home/oracle/orcl/GCDDBDATATSTEMP.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 20M EXTENT MANAGEMENT LOCAL;

-- create a new user for GCDDB
CREATE USER GCDDB PROFILE DEFAULT IDENTIFIED BY "<password>" DEFAULT TABLESPACE GCDDBDATATS TEMPORARY TABLESPACE GCDDBDATATSTEMP ACCOUNT UNLOCK;
-- provide quota on all tablespaces with GCD tables
ALTER USER GCDDB QUOTA UNLIMITED ON GCDDBDATATS;
ALTER USER GCDDB DEFAULT TABLESPACE GCDDBDATATS;
ALTER USER GCDDB TEMPORARY TABLESPACE GCDDBDATATSTEMP;

-- allow the user to connect to the database
GRANT CONNECT TO GCDDB;
GRANT ALTER session TO GCDDB;

-- grant privileges to create database objects
GRANT CREATE SESSION TO GCDDB;
GRANT CREATE TABLE TO GCDDB;
GRANT CREATE VIEW TO GCDDB;
GRANT CREATE SEQUENCE TO GCDDB;

-- grant access rights to resolve XA related issues
GRANT SELECT on pending_trans$ TO GCDDB;
GRANT SELECT on dba_2pc_pending TO GCDDB;
GRANT SELECT on dba_pending_transactions TO GCDDB;
GRANT SELECT on DUAL TO GCDDB;
GRANT SELECT on product_component_version TO GCDDB;
GRANT SELECT on USER_INDEXES TO GCDDB;
GRANT EXECUTE ON DBMS_XA TO GCDDB;
EXIT;
