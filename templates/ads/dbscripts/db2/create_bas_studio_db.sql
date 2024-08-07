-- Creating DB named: BASDB 
CREATE DATABASE BASDB AUTOMATIC STORAGE YES USING CODESET UTF-8 TERRITORY US PAGESIZE 32768;

-- connect to the created database:
CONNECT TO BASDB;

-- A user temporary tablespace is required to support stored procedures in BAStudio.
CREATE USER TEMPORARY TABLESPACE USRTMPSPC1;

UPDATE DB CFG FOR BASDB USING LOGFILSIZ 16384 DEFERRED;
UPDATE DB CFG FOR BASDB USING LOGSECOND 64 IMMEDIATE;

GRANT CONNECT ON DATABASE TO USER <username>; 
CREATE SCHEMA <username> AUTHORIZATION <username>;

GRANT CREATETAB ON DATABASE TO USER <username>;
GRANT USE OF TABLESPACE USRTMPSPC1 TO USER <username>;

CONNECT RESET;
-- Done creating and tuning DB named: BASDB