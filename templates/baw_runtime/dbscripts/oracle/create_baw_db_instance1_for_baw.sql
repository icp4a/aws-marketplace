-- Create a new user.
CREATE USER BAWDB IDENTIFIED BY <password>;

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
GRANT SELECT ON PENDING_TRANS$ TO BAWDB;
GRANT SELECT ON DBA_2PC_PENDING TO BAWDB;
GRANT SELECT ON DBA_PENDING_TRANSACTIONS TO BAWDB;
GRANT EXECUTE ON DBMS_XA TO BAWDB;
EXIT;