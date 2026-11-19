-- create user
CREATE ROLE <username> WITH INHERIT LOGIN ENCRYPTED PASSWORD '<password>';

-- create database odmdb
create database odmdb owner <username> template template0 encoding UTF8 ;
revoke connect on database odmdb from public;
grant all privileges on database odmdb to <username>;
grant connect, temp, create on database odmdb to <username>;