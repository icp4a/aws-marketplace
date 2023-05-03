-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- create database aeos
create database aeos owner <username> template template0 encoding UTF8 ;
revoke connect on database aeos from public;
grant all privileges on database aeos to <username>;
grant connect, temp, create on database aeos to <username>;

-- please modify location follow your requirement
create tablespace aeos_tbs owner <username> location '/pgsqldata/aeos';
grant create on tablespace aeos_tbs to <username>;  