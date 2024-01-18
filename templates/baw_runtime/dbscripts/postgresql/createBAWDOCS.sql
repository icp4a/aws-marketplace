-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace bawdocs_tbs owner <username> location '/pgsqldata/bawdocs';
grant create on tablespace bawdocs_tbs to <username>;

-- create database bawdocs
create database bawdocs owner <username> tablespace bawdocs_tbs template template0 encoding UTF8 ;
revoke connect on database bawdocs from public;
grant all privileges on database bawdocs to <username>;
grant connect, temp, create on database bawdocs to <username>;

-- create a schema for bawdocs and set the default
-- connect to the respective database before executing the below commands
\connect bawdocs;
CREATE SCHEMA IF NOT EXISTS AUTHORIZATION <username>;
SET ROLE <username>;
ALTER DATABASE bawdocs SET search_path TO <username>;