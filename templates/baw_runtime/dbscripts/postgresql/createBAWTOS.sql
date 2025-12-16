-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace bawtos_tbs owner <username> location '/pgsqldata/bawtos';

grant create on tablespace bawtos_tbs to <username>;

-- create database bawtos
create database bawtos owner <username> tablespace bawtos_tbs template template0 encoding UTF8 ;

-- Connect to your database and create schema
\c bawtos;

CREATE SCHEMA IF NOT EXISTS <username> AUTHORIZATION <username>;
GRANT ALL ON schema <username> to <username>;

-- create a schema for bawtos and set the default
-- connect to the respective database before executing the below commands
SET ROLE <username>;
ALTER DATABASE bawtos SET search_path TO <username>;
revoke connect on database bawtos from public;