-- create user <username>
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace adsdesignerdb_tbs owner <username> location '/pgsqldata/adsdesignerdb';
grant create on tablespace adsdesignerdb_tbs to <username>;

-- create database adsdesignerdb
create database adsdesignerdb owner <username> tablespace adsdesignerdb_tbs template template0 encoding UTF8 ;
-- Connect to your database and create schema
\c adsdesignerdb;
CREATE SCHEMA IF NOT EXISTS ads AUTHORIZATION <username>;
GRANT ALL ON schema ads to <username>;

-- create a schema for adsdesignerdb and set the default
-- connect to the respective database before executing the below commands
SET ROLE <username>;
ALTER DATABASE adsdesignerdb SET search_path TO ads;
revoke connect on database adsdesignerdb from public;
