-- Please ensure you already have existing oracle instance or pluggable database (PDB). If not, please create one firstly

-- create a new user
CREATE USER APPDB IDENTIFIED BY "<password>";

-- grant privileges to system and objects
GRANT CREATE SESSION TO APPDB;
GRANT ALTER SESSION TO APPDB;
GRANT CREATE TABLE TO APPDB;
-- Note:
-- 1. /home/oracle/orcl is a folder in the PV.
-- 2. You must specify the DATAFILE or TEMPFILE clause unless you have enabled Oracle Managed Files by setting a value for the DB_CREATE_FILE_DEST initialization parameter. 
CREATE TABLESPACE APPDBTS
   DATAFILE '/home/oracle/orcl/APPDBTS.dbf' SIZE 200M REUSE
   AUTOEXTEND ON NEXT 20M
   EXTENT MANAGEMENT LOCAL
   SEGMENT SPACE MANAGEMENT AUTO
   ONLINE
   PERMANENT
 ;
CREATE TEMPORARY TABLESPACE APPDBTS_TEMP
   TEMPFILE '/home/oracle/orcl/APPDBTS_TEMP.dbf' SIZE 200M REUSE
   AUTOEXTEND ON NEXT 20M
   EXTENT MANAGEMENT LOCAL
;
ALTER USER APPDB QUOTA UNLIMITED ON APPDBTS;
ALTER USER APPDB DEFAULT TABLESPACE APPDBTS TEMPORARY TABLESPACE APPDBTS_TEMP;

GRANT SELECT ANY TABLE TO APPDB;
GRANT UPDATE ANY TABLE TO APPDB;
GRANT INSERT ANY TABLE TO APPDB;
GRANT DROP ANY TABLE TO APPDB;
EXIT;