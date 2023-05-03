-- Please ensure you already have existing oracle instance or pluggable database (PDB). If not, please create one firstly

-- create a new user
CREATE USER BASDB IDENTIFIED BY <password>;

-- allow the user to connect to the database
GRANT CONNECT TO BASDB;

-- provide quota on all tablespaces with BPM tables
GRANT UNLIMITED TABLESPACE TO BASDB;

-- grant privileges to create database objects
GRANT RESOURCE TO BASDB;
GRANT CREATE VIEW TO BASDB;

-- grant access rights to resolve lock issues
GRANT EXECUTE ON DBMS_LOCK TO BASDB;

-- grant access rights to resolve XA related issues
GRANT SELECT ON PENDING_TRANS$ TO BASDB;
GRANT SELECT ON DBA_2PC_PENDING TO BASDB;
GRANT SELECT ON DBA_PENDING_TRANSACTIONS TO BASDB;
GRANT EXECUTE ON DBMS_XA TO BASDB;
EXIT;