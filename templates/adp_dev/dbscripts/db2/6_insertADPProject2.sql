connect to adpbase ;
set schema <username> ;
insert into TENANTINFO (tenantid,ontology,tenanttype,dailylimit,rdbmsengine,bacaversion,connstring,dbname,dbuser,tenantdbversion,featureflags) values ( 'proj2', 'ont1', 0, 0, 'DB2', '23.0.2','DSN=proj2;UID=<username>;Security=SSL;','proj2','<username>','23.0.2',154366) ;
connect reset ;
