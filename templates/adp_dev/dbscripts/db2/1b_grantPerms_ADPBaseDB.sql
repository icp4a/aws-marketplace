CONNECT TO adpbase ;
GRANT CONNECT,DATAACCESS ON DATABASE TO USER <username> ;
GRANT USE OF TABLESPACE USERSPACE1 TO USER <username> ;
CONNECT RESET;