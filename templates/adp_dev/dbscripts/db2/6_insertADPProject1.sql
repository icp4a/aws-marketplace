connect to adpbase ;
set schema <username> ;
insert into TENANTINFO (tenantid,ontology,tenanttype,dailylimit,rdbmsengine,bacaversion,connstring,dbname,dbuser,tenantdbversion,featureflags) values ( 'proj1', 'ont1', 0, 0, 'DB2', '24.0.0','DSN=proj1;UID=<username>;Security=SSL;','proj1','<username>','24.0.0',154366) ;
connect reset ;
