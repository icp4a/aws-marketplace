-- Please ensure you already have an existing Oracle instance or pluggable database (PDB).

-- create a new user
CREATE USER BASDB IDENTIFIED BY "<password>";

-- allow the user to connect to the database
GRANT CONNECT TO BASDB;

CREATE TABLESPACE BASDBTS DATAFILE SIZE 200M AUTOEXTEND ON NEXT 20M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO ONLINE PERMANENT;
CREATE TEMPORARY TABLESPACE BASDBTS_TEMP TEMPFILE SIZE 200M AUTOEXTEND ON NEXT 20M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL;

ALTER USER BASDB QUOTA UNLIMITED ON BASDBTS;

ALTER USER BASDB
     DEFAULT TABLESPACE BASDBTS
     TEMPORARY TABLESPACE BASDBTS_TEMP;

-- Grant the privileges to create database objects.
GRANT CREATE TABLE TO BASDB;
GRANT CREATE PROCEDURE TO BASDB;
GRANT CREATE SEQUENCE TO BASDB;
GRANT CREATE VIEW TO BASDB;

-- grant access rights to resolve lock issues
GRANT EXECUTE ON DBMS_LOCK TO BASDB;

-- grant access rights to resolve XA related issues
EXEC rdsadmin.rdsadmin_util.grant_sys_object('PENDING_TRANS$', 'BASDB', 'SELECT');
EXEC rdsadmin.rdsadmin_util.grant_sys_object('DBA_2PC_PENDING', 'BASDB', 'SELECT');
EXEC rdsadmin.rdsadmin_util.grant_sys_object('DBA_PENDING_TRANSACTIONS', 'BASDB', 'SELECT');
EXEC rdsadmin.rdsadmin_util.grant_sys_object('DBMS_XA', 'BASDB', 'EXECUTE');
EXIT;
