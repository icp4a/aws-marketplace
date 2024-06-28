-- Creating DB named: aaedb 
CREATE DATABASE aaedb AUTOMATIC STORAGE YES USING CODESET UTF-8 TERRITORY US PAGESIZE 32768;

-- connect to the created database:
CONNECT TO aaedb;

-- Create bufferpool and tablespaces
CREATE BUFFERPOOL DBASBBP IMMEDIATE SIZE 1024 PAGESIZE 32K;
CREATE REGULAR TABLESPACE AAEENG_TS PAGESIZE 32 K MANAGED BY AUTOMATIC STORAGE DROPPED TABLE RECOVERY ON BUFFERPOOL DBASBBP;
CREATE USER TEMPORARY TABLESPACE AAEENG_TEMP_TS PAGESIZE 32 K MANAGED BY AUTOMATIC STORAGE BUFFERPOOL DBASBBP;

-- grant access rights to the tablespaces
GRANT USE OF TABLESPACE AAEENG_TS TO user <username>;
GRANT USE OF TABLESPACE AAEENG_TEMP_TS TO user <username>;

-- The following grant is used for databases without enhanced security.
-- For more information, review the IBM documentation for enhancing security for DB2.
GRANT DBADM ON DATABASE TO USER <username>;

CONNECT RESET;
-- Done creating and tuning DB named: aaedb
