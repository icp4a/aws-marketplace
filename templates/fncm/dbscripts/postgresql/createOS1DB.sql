-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace os1db_tbs owner <username> location '/pgsqldata/os1db';
grant create on tablespace os1db_tbs to <username>; 

-- create database os1db
create database os1db owner <username> template template0 encoding UTF8 ;
revoke connect on database os1db from public;
grant all privileges on database os1db to <username>;
grant connect, temp, create on database os1db to <username>;

-- create a schema for os1db and set the default
-- connect to the respective database before executing the below commands
\connect os1db;
CREATE SCHEMA IF NOT EXISTS AUTHORIZATION <username>;
SET ROLE <username>;
ALTER DATABASE os1db SET search_path TO <username>;