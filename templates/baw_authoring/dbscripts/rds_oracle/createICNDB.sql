-- Please ensure you already have an existing Oracle instance or pluggable database (PDB).

-- create a new user
CREATE USER ICNDB IDENTIFIED BY "<password>";

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
EXEC rdsadmin.rdsadmin_util.grant_sys_object('PENDING_TRANS$', 'ICNDB', 'SELECT');
EXEC rdsadmin.rdsadmin_util.grant_sys_object('DBA_2PC_PENDING', 'ICNDB', 'SELECT');
EXEC rdsadmin.rdsadmin_util.grant_sys_object('DBA_PENDING_TRANSACTIONS', 'ICNDB', 'SELECT');
EXEC rdsadmin.rdsadmin_util.grant_sys_object('DBMS_XA', 'ICNDB', 'EXECUTE');

-- create tablespaces
CREATE TABLESPACE ICNDBTS DATAFILE SIZE 200M AUTOEXTEND ON NEXT 20M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO ONLINE PERMANENT;
CREATE TEMPORARY TABLESPACE ICNDBTSTEMP TEMPFILE SIZE 200M AUTOEXTEND ON NEXT 20M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL;

ALTER USER ICNDB DEFAULT TABLESPACE ICNDBTS TEMPORARY TABLESPACE ICNDBTSTEMP;

GRANT CONNECT, RESOURCE TO ICNDB;
GRANT UNLIMITED TABLESPACE TO ICNDB;
GRANT CREATE TRIGGER TO ICNDB;
EXIT;
