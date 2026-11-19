-- Please ensure you already have an existing Oracle instance or pluggable database (PDB).

-- Create a new user.
CREATE USER BAWDB IDENTIFIED BY "<password>";

-- Allow the user to connect to the database.
GRANT CONNECT TO BAWDB;

-- Provide a quota on all tablespaces with BPM tables.
GRANT UNLIMITED TABLESPACE TO BAWDB;

-- Grant the privileges to create database objects.
GRANT RESOURCE TO BAWDB;
GRANT CREATE VIEW TO BAWDB;

-- Grant the access rights to resolve lock issues.
GRANT EXECUTE ON DBMS_LOCK TO BAWDB;

-- Grant the access rights to resolve XA related issues.
EXEC rdsadmin.rdsadmin_util.grant_sys_object('PENDING_TRANS$', 'BAWDB', 'SELECT');
EXEC rdsadmin.rdsadmin_util.grant_sys_object('DBA_2PC_PENDING', 'BAWDB', 'SELECT');
EXEC rdsadmin.rdsadmin_util.grant_sys_object('DBA_PENDING_TRANSACTIONS', 'BAWDB', 'SELECT');
EXEC rdsadmin.rdsadmin_util.grant_sys_object('DBMS_XA', 'BAWDB', 'EXECUTE');
EXIT;
