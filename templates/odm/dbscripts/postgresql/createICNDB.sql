-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace icndb_tbs owner <username> location '/pgsqldata/icndb';
grant create on tablespace icndb_tbs to <username>;

-- create database icndb
create database icndb owner <username> tablespace icndb_tbs template template0 encoding UTF8 ;
revoke connect on database icndb from public;
grant all privileges on database icndb to <username>;
grant connect, temp, create on database icndb to <username>;

-- create a schema for icndb and set the default
-- connect to the respective database before executing the below commands
\connect icndb;
CREATE SCHEMA IF NOT EXISTS AUTHORIZATION <username>;
SET ROLE <username>;
ALTER DATABASE icndb SET search_path TO <username>;