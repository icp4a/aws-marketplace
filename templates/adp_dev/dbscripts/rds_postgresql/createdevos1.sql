-- create user <username>
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- please modify location follow your requirement
create tablespace devos1_tbs owner <username> location '/pgsqldata/devos1';

grant create on tablespace devos1_tbs to <username>;

-- create database devos1
create database devos1 owner <username> tablespace devos1_tbs template template0 encoding UTF8 ;

-- Connect to your database and create schema
\c devos1;

CREATE SCHEMA IF NOT EXISTS <username> AUTHORIZATION <username>;
GRANT ALL ON schema <username> to <username>;

-- create a schema for devos1 and set the default
-- connect to the respective database before executing the below commands
SET ROLE <username>;
ALTER DATABASE devos1 SET search_path TO <username>;
revoke connect on database devos1 from public;
