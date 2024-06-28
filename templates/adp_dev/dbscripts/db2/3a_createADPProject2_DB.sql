CREATE DATABASE proj2 AUTOMATIC STORAGE YES USING CODESET UTF-8 TERRITORY DEFAULT COLLATE USING SYSTEM PAGESIZE 32768;

UPDATE DATABASE CONFIGURATION FOR proj2 USING LOGFILSIZ 7500 ;
UPDATE DATABASE CONFIGURATION FOR proj2 USING LOGPRIMARY 15;

UPDATE DATABASE CONFIGURATION FOR proj2 USING APPLHEAPSZ 2560; 
UPDATE DATABASE CONFIGURATION FOR proj2 USING STMTHEAP 8192;

CONNECT TO proj2 ;
DROP TABLESPACE USERSPACE1 ;
CREATE Bufferpool proj2BP IMMEDIATE SIZE -1 PAGESIZE 32K ;
CREATE Bufferpool proj2TEMPBP IMMEDIATE SIZE -1 PAGESIZE 32K ;
CREATE Bufferpool proj2SYSBP IMMEDIATE SIZE -1 PAGESIZE 32K ;
CONNECT RESET ;

CONNECT TO proj2;
CREATE LARGE TABLESPACE proj2DATA PAGESIZE 32K BUFFERPOOL proj2BP ;
CREATE USER TEMPORARY TABLESPACE USERTEMP1 PAGESIZE 32K BUFFERPOOL proj2TEMPBP ;
CREATE SYSTEM TEMPORARY TABLESPACE TEMPSYS1 PAGESIZE 32K BUFFERPOOL proj2SYSBP;
CONNECT RESET ;

CONNECT TO proj2;
REVOKE SELECT ON TABLE SYSCAT.COLAUTH  FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.CONTROLS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.DBAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.INDEXAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.LIBRARYAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.MODULEAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.PACKAGEAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.PASSTHRUAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.ROLEAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.ROUTINEAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.SCHEMAAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.SECURITYLABELACCESS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.SECURITYLABELCOMPONENTELEMENTS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.SECURITYLABELCOMPONENTS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.SECURITYLABELS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.SECURITYPOLICIES FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.SECURITYPOLICYCOMPONENTRULES FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.SECURITYPOLICYEXEMPTIONS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.SEQUENCEAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.SURROGATEAUTHIDS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.TABAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.TBSPACEAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.VARIABLEAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.WORKLOADAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSCAT.XSROBJECTAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SQLCOLPRIVILEGES FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SQLTABLEPRIVILEGES FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBMADM.AUTHORIZATIONIDS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBMADM.OBJECTOWNERS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBMADM.PRIVILEGES FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSCOLAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSCONTROLS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSDBAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSINDEXAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSLIBRARYAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSMODULEAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSPASSTHRUAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSPLANAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSROLEAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSROUTINEAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSSCHEMAAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSSECURITYLABELACCESS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSSECURITYLABELCOMPONENTELEMENTS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSSECURITYLABELCOMPONENTS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSSECURITYLABELS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSSECURITYPOLICIES FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSSECURITYPOLICYCOMPONENTRULES FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSSECURITYPOLICYEXEMPTIONS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSSEQUENCEAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSSURROGATEAUTHIDS FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSTABAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSTBSPACEAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSUSERAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSVARIABLEAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSWORKLOADAUTH FROM PUBLIC ;
REVOKE SELECT ON TABLE SYSIBM.SYSXSROBJECTAUTH FROM PUBLIC ;

CONNECT RESET;
