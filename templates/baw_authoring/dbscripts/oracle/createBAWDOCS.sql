-- Please ensure you already have existing oracle instance or pluggable database (PDB). If not, please create one firstly

-- create tablespace
-- Change DATAFILE/TEMPFILE as required by your configuration
CREATE TABLESPACE BAWDOCSDATATS DATAFILE '/home/oracle/orcl/BAWDOCSDATATS.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 20M EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO ONLINE PERMANENT;
CREATE TEMPORARY TABLESPACE BAWDOCSDATATSTEMP TEMPFILE '/home/oracle/orcl/BAWDOCSDATATSTEMP.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 20M EXTENT MANAGEMENT LOCAL;

-- create a new user for BAWDOCS
CREATE USER BAWDOCS PROFILE DEFAULT IDENTIFIED BY <password> DEFAULT TABLESPACE BAWDOCSDATATS TEMPORARY TABLESPACE BAWDOCSDATATSTEMP ACCOUNT UNLOCK;

-- provide quota on all tablespaces with BPM tables
ALTER USER BAWDOCS QUOTA UNLIMITED ON BAWDOCSDATATS;
ALTER USER BAWDOCS DEFAULT TABLESPACE BAWDOCSDATATS;
ALTER USER BAWDOCS TEMPORARY TABLESPACE BAWDOCSDATATSTEMP;

-- allow the user to connect to the database
GRANT CONNECT TO BAWDOCS;
GRANT ALTER session TO BAWDOCS;

-- grant privileges to create database objects
GRANT CREATE SESSION TO BAWDOCS;
GRANT CREATE TABLE TO BAWDOCS;
GRANT CREATE VIEW TO BAWDOCS;
GRANT CREATE SEQUENCE TO BAWDOCS;
GRANT CREATE PROCEDURE TO BAWDOCS;

-- grant access rights to resolve XA related issues
GRANT SELECT on pending_trans$ TO BAWDOCS;
GRANT SELECT on dba_2pc_pending TO BAWDOCS;
GRANT SELECT on dba_pending_transactions TO BAWDOCS;
GRANT SELECT on DUAL TO BAWDOCS;
GRANT SELECT on product_component_version TO BAWDOCS;
GRANT SELECT on USER_INDEXES TO BAWDOCS;
GRANT EXECUTE ON DBMS_XA TO BAWDOCS;
EXIT;