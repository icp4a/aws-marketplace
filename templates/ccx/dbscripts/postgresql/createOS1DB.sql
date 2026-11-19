-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace os1db_tbs owner <username> location '/pgsqldata/os1db';

grant create on tablespace os1db_tbs to <username>; 

-- create database os1db
create database os1db owner <username> tablespace os1db_tbs template template0 encoding UTF8 ;

-- Connect to your database and create schema
\c os1db;

CREATE SCHEMA IF NOT EXISTS <username> AUTHORIZATION <username>;
GRANT ALL ON schema <username> to <username>;

-- create a schema for os1db and set the default
-- connect to the respective database before executing the below commands
SET ROLE <username>;
ALTER DATABASE os1db SET search_path TO <username>;
revoke connect on database os1db from public;
