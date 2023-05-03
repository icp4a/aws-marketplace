-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- create database chos
create database chos owner <username> template template0 encoding UTF8 ;
revoke connect on database chos from public;
grant all privileges on database chos to <username>;
grant connect, temp, create on database chos to <username>;

-- please modify location follow your requirement
create tablespace chos_tbs owner <username> location '/pgsqldata/chos';
grant create on tablespace chos_tbs to <username>;  