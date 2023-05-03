-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- create database gcddb
create database gcddb owner <username> template template0 encoding UTF8 ;
revoke connect on database gcddb from public;
grant all privileges on database gcddb to <username>;
grant connect, temp, create on database gcddb to <username>;

-- please modify location follow your requirement
create tablespace gcddb_tbs owner <username> location '/pgsqldata/gcd';
grant create on tablespace gcddb_tbs to <username>;  