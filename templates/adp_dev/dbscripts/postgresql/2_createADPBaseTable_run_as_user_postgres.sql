--
-- IMPORTANT: Run this script as the Postgres user <username>
--

\c "adpbase";

CREATE SCHEMA "<username>" ;

set search_path to "<username>" ;

CREATE TABLE TENANTINFO
      (tenantid varchar(128) NOT NULL,
      ontology varchar(128) not null,
      tenanttype smallint not null default 0,
      dailylimit smallint not null default 0,
      rdbmsengine varchar(128)  not null,
      dbname varchar(255) not null,
      dbuser varchar(255) not null,
      bacaversion varchar(1024) not null,
      featureflags bigint not null default 0,
      tenantdbversion varchar(255),
      last_job_run_time BIGINT not null default 0,
      dbstatus smallint not null default 0,
      project_guid VARCHAR(256),
      bas_id VARCHAR(256),
      last_updated_ts timestamp not null default current_timestamp,
      connstring varchar(1024),
      project_type smallint NULL,
      CONSTRAINT tenantinfo_pkey PRIMARY KEY (tenantid, ontology)
      );

CREATE TABLE project_usage
      (project_guid VARCHAR(256),
      num_docs  integer,
      num_pages integer,
      year smallint,
      month smallint,
      day_of_month smallint,
      day_of_week smallint,
      status smallint,
      created_ts timestamp default CURRENT_TIMESTAMP
      );

create index ix_project_usage_year_mon ON project_usage(year,month);

CREATE TABLE base_options
(
      schema_version  varchar(255),
      flags bigint not null default 0
);

INSERT INTO base_options(schema_version) values('23.0.2');

CREATE OR REPLACE FUNCTION last_updated_ts_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_updated_ts = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_tenantinfo_last_updated_ts BEFORE UPDATE ON tenantinfo FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
