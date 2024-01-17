-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace bawdos_tbs owner <username> location '/pgsqldata/bawdos';
grant create on tablespace bawdos_tbs to <username>;

-- create database bawdos
create database bawdos owner <username> tablespace bawdos_tbs template template0 encoding UTF8 ;
revoke connect on database bawdos from public;
grant all privileges on database bawdos to <username>;
grant connect, temp, create on database bawdos to <username>;

-- create a schema for bawdos and set the default
-- connect to the respective database before executing the below commands
\connect bawdos;
CREATE SCHEMA IF NOT EXISTS AUTHORIZATION <username>;
SET ROLE <username>;
ALTER DATABASE bawdos SET search_path TO <username>;