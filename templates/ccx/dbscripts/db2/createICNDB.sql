-- Creating DB named: ICNDB
CREATE DATABASE ICNDB AUTOMATIC STORAGE YES USING CODESET UTF-8 TERRITORY US PAGESIZE 32 K;
CONNECT TO ICNDB;
CREATE Bufferpool ICNDB_BP IMMEDIATE SIZE AUTOMATIC PAGESIZE 32K;
CREATE Bufferpool ICNDB_TEMPBP IMMEDIATE SIZE 200 PAGESIZE 32K;

-- The default table space name is "ICNDB".
-- If use default table space name "ICNDB", you do not need to input the value for spec.navigator_configuration.icn_production_setting.icn_table_space.
-- If change table space name, you need to use same value for spec.navigator_configuration.icn_production_setting.icn_table_space in custom resource.
CREATE REGULAR TABLESPACE ICNDB PAGESIZE 32 K MANAGED BY AUTOMATIC STORAGE AUTORESIZE YES INITIALSIZE 20 M INCREASESIZE 20 M BUFFERPOOL ICNDB_BP;
GRANT USE OF TABLESPACE ICNDB TO user <username>;

CREATE USER TEMPORARY TABLESPACE ICNDB_TEMP PAGESIZE 32K MANAGED BY AUTOMATIC STORAGE BUFFERPOOL ICNDB_TEMPBP;
GRANT USE OF TABLESPACE ICNDB_TEMP TO user <username>;

GRANT CONNECT ON DATABASE TO USER <username>; 
CREATE SCHEMA <username> AUTHORIZATION <username>;

CONNECT RESET;
