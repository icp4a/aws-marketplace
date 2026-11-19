-- create a new user
CREATE USER <username> WITH PASSWORD '<password>';
-- create database aaedb
CREATE DATABASE aaedb OWNER <username>;
-- The following grant is used for databases
GRANT ALL PRIVILEGES ON DATABASE aaedb TO <username>;
