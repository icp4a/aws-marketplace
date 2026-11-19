-- create user <username>
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace adsruntimedb_tbs owner <username> location '/pgsqldata/adsruntimedb';
grant create on tablespace adsruntimedb_tbs to <username>;

-- create database adsruntimedb
create database adsruntimedb owner <username> tablespace adsruntimedb_tbs template template0 encoding UTF8 ;
-- Connect to your database and create schema
\c adsruntimedb;
CREATE SCHEMA IF NOT EXISTS ads AUTHORIZATION <username>;
GRANT ALL ON schema ads to <username>;

-- create a schema for adsruntimedb and set the default
-- connect to the respective database before executing the below commands
SET ROLE <username>;
ALTER DATABASE adsruntimedb SET search_path TO ads;
revoke connect on database adsruntimedb from public;
