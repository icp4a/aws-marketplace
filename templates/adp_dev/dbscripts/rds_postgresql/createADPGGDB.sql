-- create user <username>
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace adpggdb_tbs owner <username> location '/pgsqldata/adpggdb';
grant create on tablespace adpggdb_tbs to <username>;

-- create database adpggdb
create database adpggdb owner <username> tablespace adpggdb_tbs template template0 encoding UTF8 ;
-- Connect to your database and create schema
\c adpggdb;
CREATE SCHEMA IF NOT EXISTS <username> AUTHORIZATION <username>;
GRANT ALL ON schema <username> to <username>;

-- create a schema for adpggdb and set the default
-- connect to the respective database before executing the below commands
SET ROLE <username>;
ALTER DATABASE adpggdb SET search_path TO <username>;
revoke connect on database adpggdb from public;
