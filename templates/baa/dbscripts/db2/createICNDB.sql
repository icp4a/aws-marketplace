-- Creating DB named: ICNDB

CREATE DATABASE ICNDB AUTOMATIC STORAGE YES USING CODESET UTF-8 TERRITORY US PAGESIZE 32 K;
CONNECT TO ICNDB;
GRANT DBADM ON DATABASE TO USER <username>;
CONNECT RESET;