-- Please ensure you already have existing oracle instance or pluggable database (PDB). If not, please create one firstly

-- create tablespace
-- Change DATAFILE/TEMPFILE as required by your configuration
CREATE TABLESPACE AWSDOCSDATATS DATAFILE '/home/oracle/orcl/AWSDOCSDATATS.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 20M EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO ONLINE PERMANENT;
CREATE TEMPORARY TABLESPACE AWSDOCSDATATSTEMP TEMPFILE '/home/oracle/orcl/AWSDOCSDATATSTEMP.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 20M EXTENT MANAGEMENT LOCAL;

-- create a new user for AWSDOCS
CREATE USER AWSDOCS PROFILE DEFAULT IDENTIFIED BY "<password>" DEFAULT TABLESPACE AWSDOCSDATATS TEMPORARY TABLESPACE AWSDOCSDATATSTEMP ACCOUNT UNLOCK;

-- provide quota on all tablespaces with BPM tables
ALTER USER AWSDOCS QUOTA UNLIMITED ON AWSDOCSDATATS;
ALTER USER AWSDOCS DEFAULT TABLESPACE AWSDOCSDATATS;
ALTER USER AWSDOCS TEMPORARY TABLESPACE AWSDOCSDATATSTEMP;

-- allow the user to connect to the database
GRANT CONNECT TO AWSDOCS;
GRANT ALTER session TO AWSDOCS;

-- grant privileges to create database objects
GRANT CREATE SESSION TO AWSDOCS;
GRANT CREATE TABLE TO AWSDOCS;
GRANT CREATE VIEW TO AWSDOCS;
GRANT CREATE SEQUENCE TO AWSDOCS;
GRANT CREATE PROCEDURE TO AWSDOCS;

-- grant access rights to resolve XA related issues
GRANT SELECT on pending_trans$ TO AWSDOCS;
GRANT SELECT on dba_2pc_pending TO AWSDOCS;
GRANT SELECT on dba_pending_transactions TO AWSDOCS;
GRANT SELECT on DUAL TO AWSDOCS;
GRANT SELECT on product_component_version TO AWSDOCS;
GRANT SELECT on USER_INDEXES TO AWSDOCS;
GRANT EXECUTE ON DBMS_XA TO AWSDOCS;
EXIT;
