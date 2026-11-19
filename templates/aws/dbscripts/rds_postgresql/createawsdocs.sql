-- create user <username>
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';
-- please modify location follow your requirement
create tablespace awsdocs_tbs owner <username> location '/pgsqldata/awsdocs';
grant create on tablespace awsdocs_tbs to <username>;  
-- create database awsdocs
create database awsdocs owner <username> tablespace awsdocs_tbs template template0 encoding UTF8 ;
-- Connect to your database and create schema
\c awsdocs;
CREATE SCHEMA IF NOT EXISTS <username> AUTHORIZATION <username>;
GRANT ALL ON schema <username> to <username>;
-- create a schema for awsdocs and set the default
-- connect to the respective database before executing the below commands
SET ROLE <username>;
ALTER DATABASE awsdocs SET search_path TO <username>;
revoke connect on database awsdocs from public;
