-- Please ensure you already have existing oracle instance or pluggable database (PDB). If not, please create one firstly

-- create a new user
CREATE USER AAEDB IDENTIFIED BY <password>;

-- grant privileges to system and objects
GRANT CREATE SESSION TO AAEDB;
GRANT ALTER SESSION TO AAEDB;
GRANT CREATE TABLE TO AAEDB;
GRANT UNLIMITED TABLESPACE TO AAEDB;
GRANT SELECT ANY TABLE TO AAEDB;
GRANT UPDATE ANY TABLE TO AAEDB;
GRANT INSERT ANY TABLE TO AAEDB;
GRANT DROP ANY TABLE TO AAEDB;
EXIT;