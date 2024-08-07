-- Creating DB named: os1db
CREATE DATABASE os1db AUTOMATIC STORAGE YES USING CODESET UTF-8 TERRITORY US PAGESIZE 32 K;

CONNECT TO os1db;

-- Create bufferpool
CREATE BUFFERPOOL os1db_1_32K IMMEDIATE SIZE 1024 PAGESIZE 32K;
CREATE BUFFERPOOL os1db_2_32K IMMEDIATE SIZE 1024 PAGESIZE 32K;
CREATE BUFFERPOOL os1db_3_32K IMMEDIATE SIZE 1024 PAGESIZE 32K;

-- Create table spaces
CREATE LARGE TABLESPACE OSDATA_TS PAGESIZE 32 K MANAGED BY AUTOMATIC STORAGE BUFFERPOOL os1db_1_32K;
CREATE LARGE TABLESPACE VWDATA_TS PAGESIZE 32 K MANAGED BY AUTOMATIC STORAGE BUFFERPOOL os1db_2_32K;
CREATE USER TEMPORARY TABLESPACE os1db_TMP_TBS PAGESIZE 32 K MANAGED BY AUTOMATIC STORAGE BUFFERPOOL os1db_3_32K;

-- Grant permissions to DB user
GRANT CREATETAB,CONNECT ON DATABASE TO USER <username>;
GRANT USE OF TABLESPACE OSDATA_TS TO USER <username>;
GRANT USE OF TABLESPACE VWDATA_TS TO USER <username>;
GRANT USE OF TABLESPACE os1db_TMP_TBS TO USER <username>;
GRANT SELECT ON SYSIBM.SYSVERSIONS TO USER <username>;
GRANT SELECT ON SYSCAT.DATATYPES TO USER <username>;
GRANT SELECT ON SYSCAT.INDEXES TO USER <username>;
GRANT SELECT ON SYSIBM.SYSDUMMY1 TO USER <username>;
GRANT USAGE ON WORKLOAD SYSDEFAULTUSERWORKLOAD TO USER <username>;
GRANT IMPLICIT_SCHEMA ON DATABASE TO USER <username>;
CREATE SCHEMA <username> AUTHORIZATION <username>;

-- Apply DB tunings
UPDATE DB CFG FOR os1db USING LOCKTIMEOUT 30;
UPDATE DB CFG FOR os1db USING LOGFILSIZ 6000; 

-- Notes: Please verify below environment configuration settings were applied to the Db2 server.
-- db2set DB2_WORKLOAD=FILENET_CM
-- db2set DB2_MINIMIZE_LISTPREFETCH=YES

CONNECT RESET;

-- Done creating and tuning DB named: os1db
