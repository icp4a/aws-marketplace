-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- create database os1db
create database os1db owner <username> template template0 encoding UTF8 ;
revoke connect on database os1db from public;
grant all privileges on database os1db to <username>;
grant connect, temp, create on database os1db to <username>;

-- please modify location follow your requirement
create tablespace os1db_tbs owner <username> location '/pgsqldata/os1db';
grant create on tablespace os1db_tbs to <username>; 