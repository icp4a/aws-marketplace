-- Creating DB named: awsdb 
CREATE DATABASE awsdb AUTOMATIC STORAGE YES USING CODESET UTF-8 TERRITORY US PAGESIZE 32768;
-- connect to the created database:
CONNECT TO awsdb;

-- A user temporary tablespace is required to support stored procedures in BPM.
CREATE USER TEMPORARY TABLESPACE USRTMPSPC1;
UPDATE DB CFG FOR awsdb USING LOGFILSIZ 16384 DEFERRED;
UPDATE DB CFG FOR awsdb USING LOGSECOND 64 IMMEDIATE;

GRANT CONNECT ON DATABASE TO USER <username>; 
CREATE SCHEMA <username> AUTHORIZATION <username>;

GRANT CREATETAB ON DATABASE TO USER <username>;
GRANT USE OF TABLESPACE USRTMPSPC1 TO USER <username>;

CONNECT RESET;
-- Done creating and tuning DB named: awsdb