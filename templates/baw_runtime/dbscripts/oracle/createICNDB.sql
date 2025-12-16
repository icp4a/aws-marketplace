-- Please ensure you already have existing oracle instance or pluggable database (PDB). If not, please create one first

-- NOTE: The tablespace creation command below uses file-based storage.  
-- If your Oracle environment uses ASM (Automatic Storage Management),  
-- update the 'DATAFILE' and 'TEMPFILE' paths to reflect your ASM configuration.  
-- Additionally, ensure that database object names (e.g., tablespace, user, etc.)  
-- match the expected naming conventions. Any deviations may cause issues.

-- create a new user
CREATE USER ICNDB IDENTIFIED BY <password>;

-- allow the user to connect to the database
GRANT CONNECT TO ICNDB;

-- provide quota on all tablespaces with tables
GRANT UNLIMITED TABLESPACE TO ICNDB;

-- grant privileges to create database objects:
GRANT RESOURCE TO ICNDB;
GRANT CREATE VIEW TO ICNDB;

-- grant access rights to resolve lock issues
GRANT EXECUTE ON DBMS_LOCK TO ICNDB;

-- grant access rights to resolve XA related issues:
GRANT SELECT ON PENDING_TRANS$ TO ICNDB;
GRANT SELECT ON DBA_2PC_PENDING TO ICNDB;
GRANT SELECT ON DBA_PENDING_TRANSACTIONS TO ICNDB;
GRANT EXECUTE ON DBMS_XA TO ICNDB;

-- Create tablespaces
-- Please make sure you change the DATAFILE and TEMPFILE to your Oracle database.
CREATE TABLESPACE ICNDBTS
    DATAFILE '/home/oracle/orcl/ICNDBTS.dbf' SIZE 200M REUSE
    AUTOEXTEND ON NEXT 20M
    EXTENT MANAGEMENT LOCAL
    SEGMENT SPACE MANAGEMENT AUTO
    ONLINE
    PERMANENT
;

CREATE TEMPORARY TABLESPACE ICNDBTSTEMP
    TEMPFILE '/home/oracle/orcl/ICNDBTSTEMP.dbf' SIZE 200M REUSE
    AUTOEXTEND ON NEXT 20M
    EXTENT MANAGEMENT LOCAL
;


-- Alter existing schema

ALTER USER ICNDB
    DEFAULT TABLESPACE ICNDBTS 
    TEMPORARY TABLESPACE ICNDBTSTEMP;

GRANT CONNECT, RESOURCE to ICNDB;
GRANT UNLIMITED TABLESPACE TO ICNDB;
GRANT CREATE TRIGGER TO ICNDB;
EXIT;