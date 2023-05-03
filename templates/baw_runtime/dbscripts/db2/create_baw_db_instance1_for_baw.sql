-- Creating DB named: BAWDB 
CREATE DATABASE BAWDB AUTOMATIC STORAGE YES USING CODESET UTF-8 TERRITORY US PAGESIZE 32768;
-- connect to the created database:
CONNECT TO BAWDB;

-- A user temporary tablespace is required to support stored procedures in BPM.
CREATE USER TEMPORARY TABLESPACE USRTMPSPC1;
UPDATE DB CFG FOR BAWDB USING LOGFILSIZ 16384 DEFERRED;
UPDATE DB CFG FOR BAWDB USING LOGSECOND 64 IMMEDIATE;
GRANT DBADM ON DATABASE TO USER <username>;

CONNECT RESET;
-- Done creating and tuning DB named: BAWDB