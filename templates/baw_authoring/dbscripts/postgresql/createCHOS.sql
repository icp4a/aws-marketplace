-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace chos_tbs owner <username> location '/pgsqldata/chos';
grant create on tablespace chos_tbs to <username>;

-- create database chos
create database chos owner <username> template template0 encoding UTF8 ;
revoke connect on database chos from public;
grant all privileges on database chos to <username>;
grant connect, temp, create on database chos to <username>;

-- create a schema for chos and set the default
-- connect to the respective database before executing the below commands
\connect chos;
CREATE SCHEMA IF NOT EXISTS AUTHORIZATION <username>;
SET ROLE <username>;
ALTER DATABASE chos SET search_path TO <username>;