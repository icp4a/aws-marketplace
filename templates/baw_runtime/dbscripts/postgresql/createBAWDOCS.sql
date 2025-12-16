-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace bawdocs_tbs owner <username> location '/pgsqldata/bawdocs';

grant create on tablespace bawdocs_tbs to <username>;

-- create database bawdocs
create database bawdocs owner <username> tablespace bawdocs_tbs template template0 encoding UTF8 ;

-- Connect to your database and create schema
\c bawdocs;

CREATE SCHEMA IF NOT EXISTS <username> AUTHORIZATION <username>;
GRANT ALL ON schema <username> to <username>;

-- create a schema for bawdocs and set the default
-- connect to the respective database before executing the below commands
SET ROLE <username>;
ALTER DATABASE bawdocs SET search_path TO <username>;
revoke connect on database bawdocs from public;
