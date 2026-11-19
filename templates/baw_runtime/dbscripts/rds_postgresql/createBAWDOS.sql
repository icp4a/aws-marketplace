-- create user <username>
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace bawdos_tbs owner <username> location '/pgsqldata/bawdos';

grant create on tablespace bawdos_tbs to <username>;

-- create database bawdos
create database bawdos owner <username> tablespace bawdos_tbs template template0 encoding UTF8 ;

-- Connect to your database and create schema
\c bawdos;

CREATE SCHEMA IF NOT EXISTS <username> AUTHORIZATION <username>;
GRANT ALL ON schema <username> to <username>;

-- create a schema for bawdos and set the default
-- connect to the respective database before executing the below commands
SET ROLE <username>;
ALTER DATABASE bawdos SET search_path TO <username>;
revoke connect on database bawdos from public;
