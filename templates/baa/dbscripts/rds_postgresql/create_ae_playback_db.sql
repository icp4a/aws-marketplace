-- create a new user
CREATE USER <username> WITH PASSWORD '<password>';
-- create database appdb
CREATE DATABASE appdb OWNER <username>;
-- The following grant is used for databases
GRANT ALL PRIVILEGES ON DATABASE appdb TO <username>;
