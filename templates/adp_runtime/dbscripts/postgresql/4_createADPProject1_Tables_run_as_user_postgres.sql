--
-- IMPORTANT: Run this script as the Postgres user <username>
--

\c "proj1" ;

CREATE SCHEMA "ont1" ;

-- Create tables 

\c "proj1" ;

set search_path to "ont1" ;

--
-- Licensed Materials - Property of IBM
-- 5737-I23
-- Copyright IBM Corp. 2018 - 2022. All Rights Reserved.
-- U.S. Government Users Restricted Rights:
-- Use, duplication or disclosure restricted by GSA ADP Schedule
-- Contract with IBM Corp.
--



-- doc_class_name  is symbolic_name for document class
create table doc_class
(
    doc_class_id VARCHAR (128) NOT NULL,
    doc_class_name VARCHAR (512) NOT NULL,
    comment varchar(1024),
    trained smallint NOT NULL default 0,
    created_ts timestamp default current_timestamp,
    last_updated_ts timestamp not null default current_timestamp,
    opt_flags bigint not null default 0,
    display_name varchar(1024) NOT NULL,
    localization_names TEXT,
    config TEXT,
    classification_training_data_update_ts timestamp default CURRENT_TIMESTAMP,
    extraction_training_data_update_ts timestamp default CURRENT_TIMESTAMP,
    CONSTRAINT doc_class_pkey PRIMARY KEY (doc_class_id),

    CONSTRAINT doc_class_doc_class_name_key UNIQUE (doc_class_name)
);
create index ix_doc_class_created_ts ON doc_class(created_ts);
create unique index ix_doc_class_name_ts ON doc_class(REPLACE(doc_class_name,' ',''));

create table doc_alias
(
    doc_alias_id VARCHAR (128) NOT NULL,
    doc_class_id VARCHAR (128) NOT NULL,
    doc_alias_name VARCHAR (512) NOT NULL,
    language VARCHAR(32) NOT NULL,

    CONSTRAINT doc_alias_pkey PRIMARY KEY (doc_alias_id),

    CONSTRAINT doc_alias_class_id_alias_name UNIQUE (doc_class_id,doc_alias_name),

    CONSTRAINT doc_alias_doc_class_id_fkey FOREIGN KEY (doc_class_id) REFERENCES doc_class (doc_class_id)
    ON UPDATE RESTRICT ON DELETE CASCADE
);

-- tables for object type library
-- name  is display name 
create table object_type
(
    object_type_id VARCHAR (128) NOT NULL,
    name VARCHAR (512) NOT NULL,
    symbolic_name VARCHAR (512) NOT NULL,
    scope VARCHAR (512) NOT NULL,
    type VARCHAR (128) NOT NULL,
    parent_type VARCHAR (128) NOT NULL,
    flags INTEGER,
    version INTEGER,
    description VARCHAR(1024),
    config TEXT NOT NULL default '{}',
    created_ts timestamp default current_timestamp,
    last_updated_ts timestamp not null default current_timestamp,
    localization_names TEXT,

    CONSTRAINT object_type_object_type_id_key UNIQUE (object_type_id),
    CONSTRAINT object_type_pkey PRIMARY KEY (scope, symbolic_name)
);
create index ix_object_type_created_ts ON object_type(created_ts);
create UNIQUE index ix_scope_symbolic_name ON object_type(LOWER(scope),LOWER(symbolic_name));


-- key_class_name  is symbolic_name for key class
create table key_class
(
    key_class_id VARCHAR (128) NOT NULL,
    doc_class_id VARCHAR (128) NOT NULL,
    key_class_name VARCHAR (512) NOT NULL,
    datatype VARCHAR (128) NOT NULL,
    mandatory INTEGER NOT NULL,
    sensitive BOOLEAN,
    comment VARCHAR(1024),
    config TEXT NOT NULL,
    flags SMALLINT NOT NULL default 0,
    parent_id VARCHAR (128) NOT NULL default 0,
    created_ts timestamp default CURRENT_TIMESTAMP,
    last_updated_ts timestamp not null default current_timestamp,
    opt_flags bigint not null default 0,
    display_name varchar(1024) NOT NULL,
    localization_names TEXT,

    CONSTRAINT key_class_pkey PRIMARY KEY (key_class_id),

    CONSTRAINT key_class_doc_class_id_key_class_name_parent_id UNIQUE (doc_class_id, key_class_name, parent_id),

    CONSTRAINT key_class_doc_class_id_fkey FOREIGN KEY (doc_class_id) REFERENCES doc_class (doc_class_id)
    ON UPDATE RESTRICT ON DELETE CASCADE,

    CONSTRAINT key_class_object_type_fkey FOREIGN KEY (datatype) REFERENCES object_type (object_type_id)
    ON UPDATE RESTRICT ON DELETE CASCADE
);
create index ix_key_class_created_ts ON key_class(created_ts);
create unique index ix_key_class_name_ts ON key_class(doc_class_id, REPLACE(key_class_name,' ',''), parent_id);

create table key_alias
(
    key_alias_id VARCHAR (128) NOT NULL,
    doc_class_id VARCHAR (128) NOT NULL,
    key_class_id VARCHAR (128) NOT NULL,
    key_alias_name VARCHAR (2048) NOT NULL,
    language VARCHAR(32),

    CONSTRAINT key_alias_pkey PRIMARY KEY (key_alias_id),

    CONSTRAINT key_alias_key_class_id_fkey FOREIGN KEY (key_class_id) REFERENCES key_class (key_class_id)
    ON UPDATE RESTRICT ON DELETE CASCADE,

    CONSTRAINT key_alias_doc_class_id_fkey FOREIGN KEY (doc_class_id) REFERENCES doc_class (doc_class_id)
    ON UPDATE RESTRICT ON DELETE CASCADE,

    CONSTRAINT key_alias_doc_class_id_key_alias_name_key UNIQUE (doc_class_id,key_alias_name),

    CONSTRAINT key_alias_doc_class_id_key_class_id_alias_name UNIQUE (doc_class_id,key_class_id,key_alias_name)

);

create UNIQUE index ix_alias_doc_id ON KEY_ALIAS(LOWER(key_alias_name),doc_class_id);

create UNIQUE index ix_alias_doc_id_key_id ON KEY_ALIAS(LOWER(key_alias_name),doc_class_id,key_class_id);

-- table to store the aliases of attribute instances inside key class
create table attribute_alias
(
    key_class_id VARCHAR (128) NOT NULL,
    alias_name VARCHAR (512) NOT NULL,
    language VARCHAR(32) NOT NULL,
    parent_id VARCHAR (128) NOT NULL,
    created_ts timestamp default CURRENT_TIMESTAMP,
    last_updated_ts timestamp not null default current_timestamp,

    CONSTRAINT alias_pkey PRIMARY KEY (key_class_id, alias_name),

    CONSTRAINT alias_parent_id_alias_name_key UNIQUE (parent_id, alias_name),

    CONSTRAINT alias_key_class_id_fkey FOREIGN KEY (key_class_id) REFERENCES key_class (key_class_id)
    ON UPDATE RESTRICT ON DELETE CASCADE,

    CONSTRAINT alias_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES key_class (key_class_id)
    ON UPDATE RESTRICT ON DELETE CASCADE
);
create index ix_attribute_alias_created_ts ON attribute_alias(created_ts);

create UNIQUE index ix_alias_parent_id ON attribute_alias(parent_id,LOWER(alias_name));

create table cword
(
    cword_id VARCHAR (128) NOT NULL,
    doc_class_id VARCHAR (128) NOT NULL,
    cword_name VARCHAR (512) NOT NULL,

    CONSTRAINT cword_pkey PRIMARY KEY (cword_id),

    CONSTRAINT cword_doc_class_id_name UNIQUE (doc_class_id,cword_name),

    CONSTRAINT cword_doc_class_id_fkey FOREIGN KEY (doc_class_id) REFERENCES doc_class (doc_class_id)
    ON UPDATE RESTRICT ON DELETE CASCADE

);

create table heading
(
    heading_id VARCHAR (128) NOT NULL,
    doc_class_id VARCHAR (128) NOT NULL,
    heading_name VARCHAR (512) NOT NULL,
    comment VARCHAR(1024),

    CONSTRAINT heading_pkey PRIMARY KEY (heading_id),

    CONSTRAINT heading_doc_class_id_name UNIQUE (doc_class_id,heading_name),

    CONSTRAINT heading_doc_class_id_fkey FOREIGN KEY (doc_class_id) REFERENCES doc_class (doc_class_id)
    ON UPDATE RESTRICT ON DELETE CASCADE
);

create table heading_alias
(
    heading_alias_id VARCHAR (128) NOT NULL,
    heading_id VARCHAR (128) NOT NULL,
    heading_alias_name VARCHAR (512) NOT NULL,

    CONSTRAINT heading_alias_pkey PRIMARY KEY (heading_alias_id),

     CONSTRAINT heading_alias_heading_id_alias_name UNIQUE (heading_id,heading_alias_name),

    CONSTRAINT heading_alias_doc_class_id_fkey FOREIGN KEY (heading_id) REFERENCES heading (heading_id)
    ON UPDATE RESTRICT ON DELETE CASCADE
);

create table user_detail
(
    user_id VARCHAR (128) NOT NULL,
    email VARCHAR(1024) NOT NULL,
    first_name VARCHAR(512) NOT NULL,
    last_name VARCHAR(512) NOT NULL,
    phone VARCHAR(256),
    company VARCHAR(512),
    expire INTEGER,
    expiry_date BIGINT,
    token BIT(1024) DEFAULT NULL,
    user_name VARCHAR(1024) NOT NULL,
    CONSTRAINT user_detail_pkey PRIMARY KEY (user_id),
    CONSTRAINT user_detail_email_key UNIQUE (email),
    CONSTRAINT user_name UNIQUE (user_name)
);

create table login_detail
(
    user_id VARCHAR (128) NOT NULL,
    role VARCHAR(32),
    status BOOLEAN,
    logged_in BOOLEAN DEFAULT FALSE,

    CONSTRAINT login_detail_user_id_fkey FOREIGN KEY (user_id) REFERENCES user_detail (user_id)
    ON UPDATE RESTRICT ON DELETE CASCADE
);

create table integration
(
    id VARCHAR (128) NOT NULL,
    type VARCHAR(32),
    url VARCHAR(1024),
    user_name VARCHAR(256) DEFAULT NULL,
    password BIT(512) DEFAULT NULL,
    label VARCHAR(256),
    status BOOLEAN,
    model_id VARCHAR(128),
    api_key BIT(1024) DEFAULT NULL,
    flag VARCHAR(64),
    doc_class_id VARCHAR (128),
    checked SMALLINT,

    CONSTRAINT integration_pkey PRIMARY KEY (id),

    CONSTRAINT integration_doc_class_id_fkey FOREIGN KEY (doc_class_id) REFERENCES doc_class (doc_class_id)
    ON UPDATE RESTRICT ON DELETE CASCADE

);

create table import_ontology
(
    id VARCHAR (128) NOT NULL,
    user_id VARCHAR (128) NOT NULL,
    operation SMALLINT NOT NULL,
    op_complete SMALLINT,
    op_failure SMALLINT,
    created_ts timestamp default CURRENT_TIMESTAMP,
    last_updated_ts timestamp not null default current_timestamp,
    op_response varchar(1024),

    CONSTRAINT import_ontology_pkey PRIMARY KEY (id)
);

create table api_integrations_objectsstore
(
    id VARCHAR (128) NOT NULL,
    user_id VARCHAR (128) NOT NULL,
    type VARCHAR(64),
    bucket_name VARCHAR(128) NOT NULL,
    endpoint VARCHAR(1024) NOT NULL,
    access_key BIT(1024) NOT NULL,
    access_id BIT(1024) NOT NULL,
    signatureversion VARCHAR(128) NOT NULL,
    forcestylepath boolean,

    CONSTRAINT api_integrations_objectsstore_id_pk PRIMARY KEY (id),

    CONSTRAINT api_integrations_objectsstore_user_detail_user_id_fk FOREIGN KEY (user_id) REFERENCES user_detail (user_id)
);

create table smartpages_options
(
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 NO CYCLE),
    outputname VARCHAR(6),
    company VARCHAR(512),
    selections VARCHAR(256),
    CONSTRAINT smartpages_options_pkey PRIMARY KEY (id)
);

--flags -0 user defined and default 1. will  be training set detected
--rank -relative importance number 0.0 to 1.0
create table feature
(
  doc_class_id VARCHAR (128) NOT NULL,
  name  VARCHAR (512) NOT NULL,
  flags SMALLINT NOT NULL DEFAULT  0,
  rank REAL DEFAULT 1.0,

  CONSTRAINT feature_doc_class_id_flags_name_key UNIQUE  (doc_class_id ,flags, name),

  CONSTRAINT feature_doc_class_id_fkey FOREIGN KEY (doc_class_id) REFERENCES doc_class (doc_class_id)
    ON UPDATE RESTRICT ON DELETE CASCADE

);

--1. initialized  2. running  3.error 4.trained
--createdby user
--major_version developer controled no auto increment. Update for each release (1.0)
--minor version in each release increment.Reset after new major version update.
--type Classification 0, Object detection(deep learning) 1, Data extraction 2,
--created_ts added to track timestamp
--flags added for feature use
create table training_log
(
  id VARCHAR (128) NOT NULL,
  status SMALLINT NOT NULL,
  created_date BIGINT NOT NULL,
  major_version SMALLINT NOT NULL,
  minor_version SMALLINT NOT NULL,
  error_info VARCHAR(1024),
  created_by VARCHAR (128) NOT NULL,
  json_model_input_detail TEXT,
  global_feature_vector BYTEA,
  selected_features VARCHAR(1024),
  type smallint NOT NULL default 0,
  last_updated_ts timestamp not null default current_timestamp,
  model_version SMALLINT NOT NULL default 1,
  created_ts timestamp default CURRENT_TIMESTAMP,
  flags BIGINT NOT NULL default 0,

  CONSTRAINT training_log_pkey PRIMARY KEY (id)
);
create index ix_training_log ON training_log(created_date);

--create a sequence for minor version
CREATE SEQUENCE MINOR_VER_SEQ AS SMALLINT START WITH 1 INCREMENT BY 1 NO CYCLE CACHE 1;

--version developer of classifier specifies
create table models
(
  id VARCHAR (128) NOT NULL,
  training_id VARCHAR (128) NOT NULL,
  displayname VARCHAR(1024) NOT NULL,
  algorithm SMALLINT NOT NULL,
  accuracy real,
  version SMALLINT,
  model_output BYTEA,
  json_feature_vector TEXT,
  json_report TEXT,
  created_ts timestamp default CURRENT_TIMESTAMP,
  last_updated_ts timestamp not null default current_timestamp,
  trainable_model_output BYTEA,

  CONSTRAINT models_pkey PRIMARY KEY (id),

  CONSTRAINT models_fkey FOREIGN KEY (training_id) REFERENCES training_log (id)
    ON UPDATE RESTRICT ON DELETE CASCADE
);
create index ix_models_created_ts ON models(created_ts);

create table templates
(
    template_id VARCHAR (128) NOT NULL,
    doc_class_id VARCHAR (128) NOT NULL,
    template_name VARCHAR (512),
    template_features TEXT,
    training_id VARCHAR (128) NOT NULL,
    last_updated_ts timestamp not null default current_timestamp,

    CONSTRAINT templates_ckey PRIMARY KEY (template_id),

    CONSTRAINT templates_fkey FOREIGN KEY (training_id) REFERENCES training_log (id)
    ON UPDATE RESTRICT ON DELETE CASCADE
);
create index ix_templates_doc_class_id ON templates(template_id,doc_class_id);

--published_status  active ,inactive
create table published_models
(
  vid VARCHAR (128) NOT NULL,
  default_model_id VARCHAR (128) NOT NULL,
  name VARCHAR(128) NOT NULL,
  published_status SMALLINT default 0,
  published_date BIGINT NOT NULL,
  published_user VARCHAR (128) NOT NULL,
  last_updated_ts timestamp not null default current_timestamp,
  adp_published SMALLINT default 0,	

  CONSTRAINT published_models_fkey FOREIGN KEY (default_model_id) REFERENCES models(id)
    ON UPDATE RESTRICT ON DELETE RESTRICT
);
create index ix_published_models_published_date ON published_models(published_date);

--Add columns for to store upto Day
--Add coumns to store upto Month
create table processed_file
(
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 NO CYCLE),
    transaction_id VARCHAR(256) NOT NULL,
    file_name VARCHAR(1024) NOT NULL,
    number_of_page INTEGER,
    date BIGINT,
    start_time BIGINT,
    end_time BIGINT,
    failed_ocr_pages INTEGER DEFAULT 0,
    failed_pages INTEGER DEFAULT 0,
    failed BOOLEAN DEFAULT FALSE,
    doc_class_id VARCHAR (128),
    model_id VARCHAR (128),
    confidence  real,
    num_kvp_defined SMALLINT,
    num_kvp_found SMALLINT,
    TUPTOHOUR BIGINT,
    TUPTODAY BIGINT,
    TUPTOMON BIGINT,
    API SMALLINT,

    CONSTRAINT processed_file_pkey PRIMARY KEY (id),
    CONSTRAINT processed_file_transaction_id_key UNIQUE (transaction_id)
);

create table error_log
(
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 NO CYCLE),
    transaction_id VARCHAR(256),
    error_code CHAR(32),
    description VARCHAR(1024),
    date BIGINT,

    CONSTRAINT error_log_pkey PRIMARY KEY (id),

    CONSTRAINT error_log_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES processed_file (transaction_id)
    ON UPDATE RESTRICT ON DELETE CASCADE
);

create table audit_ontology
(
    id VARCHAR (128) NOT NULL,
    username VARCHAR(1024),
    type VARCHAR(256),
    action VARCHAR(512),
    description VARCHAR(1024),
    date BIGINT,
    time_elapsed VARCHAR(128),
    error BOOLEAN DEFAULT FALSE,
    page VARCHAR(32) DEFAULT '',

    CONSTRAINT audit_ontology_pkey PRIMARY KEY (id)
);

create table audit_login_activity
(
    id VARCHAR (128) NOT NULL,
    username VARCHAR(1024),
    type VARCHAR(256),
    action VARCHAR(512),
    description VARCHAR(1024),
    date BIGINT,
    time_elapsed VARCHAR(128),
    error BOOLEAN DEFAULT FALSE,
    page VARCHAR(32) DEFAULT '',

    CONSTRAINT audit_login_activity_pkey PRIMARY KEY (id)
);

create table audit_processed_files
(
    id VARCHAR (128) NOT NULL,
    username VARCHAR(1024),
    type VARCHAR(256),
    action VARCHAR(512),
    description VARCHAR(1024),
    date BIGINT,
    time_elapsed VARCHAR(128),
    transaction_id VARCHAR(256),
    error BOOLEAN DEFAULT FALSE,
    page VARCHAR(32) DEFAULT '',

    CONSTRAINT audit_processed_files_pkey PRIMARY KEY (id)
);

create table audit_user_activity
(
    id VARCHAR (128) NOT NULL,
    username VARCHAR(1024),
    type VARCHAR(256),
    action VARCHAR(512),
    description VARCHAR(1024),
    date BIGINT,
    time_elapsed VARCHAR(128),
    error BOOLEAN DEFAULT FALSE,
    page VARCHAR(32) DEFAULT '',

    CONSTRAINT audit_user_activity_pkey PRIMARY KEY (id)
);

create table audit_api_activity
(
    id VARCHAR(128) NOT NULL,
    username  VARCHAR(1024),
    type  VARCHAR(256),
    action  VARCHAR(512),
    description  VARCHAR(1024),
    date BIGINT,
    time_elapsed  VARCHAR(128),
    error BOOLEAN DEFAULT FALSE,
    page  VARCHAR(32) DEFAULT '',

    CONSTRAINT audit_api_activity_pkey PRIMARY KEY (id)
);

create table  audit_system_activity
(
    id VARCHAR (128) NOT NULL,
    username  VARCHAR(1024),
    type  VARCHAR(256),
    action  VARCHAR(512),
    description  VARCHAR(1024),
    date BIGINT,
    time_elapsed  VARCHAR(128),
    error BOOLEAN DEFAULT FALSE,
    page  VARCHAR(32) DEFAULT '',

    CONSTRAINT audit_system_activity_pkey PRIMARY KEY (id)
);

create table audit_integration_activity
(
    id VARCHAR (128) NOT NULL,
    username VARCHAR(1024),
    type VARCHAR(256),
    action VARCHAR(512),
    description VARCHAR(1024),
    date BIGINT,
    time_elapsed VARCHAR(128),
    error BOOLEAN DEFAULT FALSE,
    page VARCHAR(32) DEFAULT '',

    CONSTRAINT audit_integration_activity_pkey PRIMARY KEY (id)
);

CREATE OR REPLACE VIEW audit_sys_report AS SELECT audit_ontology.username,
    audit_ontology.type,
    audit_ontology.action,
    audit_ontology.description,
    audit_ontology.date,
    audit_ontology.time_elapsed,
    audit_ontology.error,
    audit_ontology.page,
    'Ontology' AS details
   FROM audit_ontology
UNION
 SELECT audit_processed_files.username,
    audit_processed_files.type,
    audit_processed_files.action,
    audit_processed_files.description,
    audit_processed_files.date,
    audit_processed_files.time_elapsed,
    audit_processed_files.error,
    audit_processed_files.page,
    'Processed files' AS details
   FROM audit_processed_files
UNION
 SELECT audit_login_activity.username,
    audit_login_activity.type,
    audit_login_activity.action,
    audit_login_activity.description,
    audit_login_activity.date,
    audit_login_activity.time_elapsed,
    audit_login_activity.error,
    audit_login_activity.page,
    'Login activity' AS details
   FROM audit_login_activity
UNION
 SELECT audit_user_activity.username,
    audit_user_activity.type,
    audit_user_activity.action,
    audit_user_activity.description,
    audit_user_activity.date,
    audit_user_activity.time_elapsed,
    audit_user_activity.error,
    audit_user_activity.page,
    'User activity' AS details
   FROM audit_user_activity
UNION
 SELECT audit_system_activity.username,
    audit_system_activity.type,
    audit_system_activity.action,
    audit_system_activity.description,
    audit_system_activity.date,
    audit_system_activity.time_elapsed,
    audit_system_activity.error,
    audit_system_activity.page,
    'System activity' AS detailsimport_ontology
   FROM audit_system_activity
UNION
 SELECT audit_integration_activity.username,
    audit_integration_activity.type,
    audit_integration_activity.action,
    audit_integration_activity.description,
    audit_integration_activity.date,
    audit_integration_activity.time_elapsed,
    audit_integration_activity.error,
    audit_integration_activity.page,
    'Integration activity' AS details
   FROM audit_integration_activity
UNION
 SELECT audit_api_activity.username,
    audit_api_activity.type,
    audit_api_activity.action,
    audit_api_activity.description,
    audit_api_activity.date,
    audit_api_activity.time_elapsed,
    audit_api_activity.error,
    audit_api_activity.page,
    'API activity' AS details
   FROM audit_api_activity
;


-- impl_type: 1(keyExtractor), 2(valueExtractor), 3(validator)
-- extraction_tool: 1(regex), 2(dictionary) and so on
create table implementation
(
    impl_id VARCHAR (128) NOT NULL,
    name VARCHAR (512) NOT NULL,
    symbolic_name VARCHAR (512) NOT NULL,
    object_type_id VARCHAR (128) NOT NULL,
    impl_type SMALLINT NOT NULL,
    value_format SMALLINT NOT NULL DEFAULT 1,
    extraction_tool SMALLINT NOT NULL,
    flags SMALLINT NOT NULL,
    description VARCHAR(1024),
    config TEXT NOT NULL,
    created_ts timestamp default CURRENT_TIMESTAMP,
    last_updated_ts timestamp not null default current_timestamp,
    is_default SMALLINT default 0,

    CONSTRAINT implementation_pkey PRIMARY KEY (object_type_id, symbolic_name),

    CONSTRAINT implementation_object_type_id_fkey FOREIGN KEY (object_type_id) REFERENCES object_type (object_type_id)
    ON UPDATE RESTRICT ON DELETE CASCADE,

    CONSTRAINT implementation_impl_id_key UNIQUE (impl_id)
);

create index ix_implementation_created_ts ON implementation(created_ts);

create table implementation_kc
(
    impl_id VARCHAR (128) NOT NULL,
    key_class_id VARCHAR (128) NOT NULL,
    flags SMALLINT NOT NULL,
    created_ts timestamp default CURRENT_TIMESTAMP,
    last_updated_ts timestamp not null default current_timestamp,

    CONSTRAINT implementation_kc_pkey PRIMARY KEY (impl_id, key_class_id),

    CONSTRAINT implementation_kc_impl_id_fkey FOREIGN KEY (impl_id) REFERENCES implementation (impl_id)
    ON UPDATE RESTRICT,

    CONSTRAINT implementation_kc_key_class_id_fkey FOREIGN KEY (key_class_id) REFERENCES key_class (key_class_id)
    ON UPDATE RESTRICT ON DELETE CASCADE
);

create index ix_implementation_kc_created_ts ON implementation_kc(created_ts);

create table systemt_models
(
    model_id     VARCHAR (128) NOT NULL,
    model_name     VARCHAR (512) NOT NULL,
    model BYTEA NOT NULL,
    is_default SMALLINT NOT NULL default 0,
    version SMALLINT,
    created_ts timestamp default CURRENT_TIMESTAMP,
    last_updated_ts timestamp not null default current_timestamp,
    language BIGINT NOT NULL default 0,

    CONSTRAINT systemt_models_pkey PRIMARY KEY (model_id),

    CONSTRAINT systemt_models_model_name_key UNIQUE (model_name)
);
create index ix_systemt_models_created_ts ON systemt_models(created_ts);

create table systemt_model_metadata
(
    entity_id     VARCHAR (128) NOT NULL,
    model_id     VARCHAR (128) NOT NULL,
    output_type    VARCHAR (512) NOT NULL,
    entity_name VARCHAR (512) NOT NULL,
    created_ts timestamp default CURRENT_TIMESTAMP,
    last_updated_ts timestamp not null default current_timestamp,

    CONSTRAINT systemt_model_metadata_pkey PRIMARY KEY (entity_id),

    CONSTRAINT systemt_model_metadata_model_id_fkey FOREIGN KEY (model_id) REFERENCES systemt_models (model_id)
    ON UPDATE RESTRICT ON DELETE CASCADE,

    CONSTRAINT systemt_model_metadata_model_id_output_type_entity_name UNIQUE (model_id, output_type, entity_name)
);
create index ix_systemt_model_metadata_created_ts ON systemt_model_metadata(created_ts);

--- Indexes -------
create index ix_audit_api_activity_date ON audit_api_activity(date);
create index ix_audit_integration_activity_date ON audit_integration_activity(date);
create index ix_audit_login_activity_date ON audit_login_activity(date);
create index ix_audit_ontology_date ON audit_ontology(date);
create index ix_audit_processed_files_date ON audit_processed_files(date);
create index ix_audit_system_activity_date ON audit_system_activity(date);
create index ix_audit_user_activity_date ON audit_user_activity(date);
create index ix_error_log_date ON error_log(date);
create index ix_processed_file_date on processed_file(date);
create index ix_processed_file_tuptohour on processed_file(TUPTOHOUR);
create index ix_processed_file_tuptoday on processed_file(TUPTODAY);
create index ix_processed_file_tuptomon on processed_file(TUPTOMON);
--- End Indexes -------


--API -- 0 (UI),1(API) ,2(ML) etc
--DOC_CLASS_ID  DEFAULT '0'applies only for ML files.
-- when API is 2
-----MLPROCESSSTATUS 0.uploaded  1.processing 2.text (completed status) 3.error 4. trained Applied only for grouping files
-----kvp_status review status - 0  NOT REVIEWED. 1. REVIEW DONE and used run time Applied only for ML files
-----classification_dataset -Applied only for classification files -- when API is 2 this can be training(0) or test(1) 2 for blind set
-----extraction_dataset -Applied only for kvp  files -- when API is 2 this can be training(0) or test(1) file and 2 for blind set

-----ground_truth: added for data extraction model -> the latest user defined key and values for checking the KVP result accuracy
    -- "GroundTruth": [
    --     {
    --       "Value": "string",
    --       "KeyClassID": "string",
    --       "KeyClass": "string",
    --       "ComplexKVPStructure": {
    --         "Attributes": [
    --           {
    --             "Value": "string",
    --             "KeyClassID": "string",
    --          "KeyClass": "string",
    --           }
    --         ]
    --       }
    --     }
-----ground_truth_status - 0.NotReviewed  1.InProgress  2.Completed

--replace mongo DB2 tables
create table runtime_doc
(
    TRANSACTION_ID         VARCHAR(256) NOT NULL,
    INITIAL_START_TIME     BIGINT,
    FILE_NAME              VARCHAR(1024),
    ORG_CONTENT            BYTEA,
    UTF_CONTENT            BYTEA,
    PDF_CONTENT            BYTEA,
    WDS_CONTENT            TEXT,
    DOC_PARAMS             TEXT,
    FLAGS                  BIGINT       NOT NULL DEFAULT 0,
    API                    SMALLINT     NOT NULL DEFAULT 0,
    COMPLETED              SMALLINT     NOT NULL DEFAULT 0,
    FAILED                 SMALLINT     NOT NULL DEFAULT 0,
    DOCUMENTACCURACY       INTEGER      NOT NULL DEFAULT 0,
    COMPLETED_OCR_PAGES    INTEGER      NOT NULL DEFAULT 0,
    OCR_PAGES_VERIFIED     SMALLINT     NOT NULL DEFAULT 0,
    PROGRESS               DECIMAL(5,2),
    PARTIAL_COMPLETE_PAGES INTEGER      NOT NULL DEFAULT 0,
    COMPLETED_PAGES        INTEGER      NOT NULL DEFAULT 0,
    VERIFIED               SMALLINT     NOT NULL DEFAULT 0,
    USER_ID                VARCHAR (128) NOT NULL,
    PDF                    SMALLINT     NOT NULL DEFAULT 0,
    PDF_SUCCESS            SMALLINT     NOT NULL DEFAULT 0,
    PDF_ERROR_LIST         VARCHAR(1024),
    PDF_PARAMS             TEXT,
    UTF8                   SMALLINT     NOT NULL DEFAULT 0,
    UTF8_SUCCESS           SMALLINT     NOT NULL DEFAULT 0,
    UTF8_ERROR_LIST        VARCHAR(1024),
    UTF8_PARAMS            TEXT,
    TITLE_LIST             VARCHAR(32000),
    ALIAS_LIST             TEXT,
    DOC_CLASS_ID              VARCHAR (128) NOT NULL,
    NUM_PAGES                SMALLINT NOT NULL DEFAULT 0,
    MLPROCESSSTATUS          SMALLINT NOT NULL DEFAULT 0,
  classification_dataset SMALLINT NOT NULL,
  extraction_dataset     SMALLINT NOT NULL,
    KVP_STATUS             SMALLINT NOT NULL DEFAULT 0,
     MLERROR_INFO           VARCHAR(1024),
    json_for_clustering    TEXT,
    ground_truth           TEXT,
    ground_truth_status    SMALLINT default 0,
        template_id                   VARCHAR(128),
    annotations            TEXT,

    CONSTRAINT runtime_doc_pkey PRIMARY KEY (TRANSACTION_ID)

);

create index IX_RUNTIME_DOC_START_TIME ON runtime_doc(INITIAL_START_TIME);
create index IX_RUNTIME_DOC_API_CLDATASET ON runtime_doc(TRANSACTION_ID,API,classification_dataset);
create index IX_RUNTIME_DOC_API_EXTDATASET ON runtime_doc(TRANSACTION_ID,API,extraction_dataset);
create index IX_RUNTIME_DOC_DOC_CLASS_ID ON runtime_doc(DOC_CLASS_ID,API);

-- Modified processed_file to support kvpml feature
-- When user publishes model update model_id in this with model id from published_models.
create table kvp_model_detail
(
    TRANSACTION_ID     VARCHAR (128) NOT NULL,
    PAGE_ID            SMALLINT NOT NULL,
    template_check_sum VARCHAR(1024),
    num_kvp_defined    SMALLINT,
    num_kvp_found      SMALLINT,
    num_kvp_trained    SMALLINT,
    model_id           VARCHAR (128),
    kvp_json           TEXT,
    created_ts timestamp default CURRENT_TIMESTAMP,
    last_updated_ts timestamp not null default current_timestamp,
    doc_level_check_sum VARCHAR(1024),
    key_level_check_sum VARCHAR(1024),
    doc_class_id        varchar(128)
);
create index ix_kvp_model_detail_created_ts ON kvp_model_detail(created_ts);

create table runtime_page
(
    TRANSACTION_ID VARCHAR(256) NOT NULL,
    PAGE_ID        SMALLINT     NOT NULL,
    JPG_CONTENT    BYTEA,
    PAGE_UUID      VARCHAR(256),
    PAGE_PARAMS    TEXT,
    FLATTENEDJSON  TEXT,
    GOODLETTERS    INTEGER      NOT NULL DEFAULT 0,
    ALLLETTERS     INTEGER      NOT NULL DEFAULT 0,
    COMPLETE       SMALLINT     NOT NULL DEFAULT 0,
    OCR_CONFIDENCE VARCHAR(20),
    LANGUAGES      VARCHAR(256),
    FLAGS          BIGINT       NOT NULL DEFAULT 0,
    BAGOFWORDS     TEXT,
    HEADER_LIST    TEXT,
    FOUNDKEYLIST   VARCHAR(10240),
    DEFINEDKEYLIST VARCHAR(10240),
    PDF_CONTENT    BYTEA,
    IMAGE_HASH       VARCHAR(64),

    CONSTRAINT runtime_page_transaction_id_fkey FOREIGN KEY (TRANSACTION_ID) REFERENCES runtime_doc (TRANSACTION_ID)
    ON UPDATE RESTRICT ON DELETE CASCADE,

    CONSTRAINT runtime_page_pkey PRIMARY KEY (TRANSACTION_ID, PAGE_ID)
);
--End replace mongo DB2 tables

-- Datafixup and Classification feedback table
create table feedback
(
    model_type VARCHAR (128) NOT NULL,
    key_class_id VARCHAR (128),
    doc_class_id VARCHAR (128),
    original_value VARCHAR (1024) NOT NULL,
    corrected_value VARCHAR (1024) NOT NULL,
    is_value BOOLEAN DEFAULT TRUE,
        created_ts timestamp default CURRENT_TIMESTAMP

);
create index ix_feedback_created_ts ON feedback(created_ts);


--save the kvpTable json of testing files for each data estraction training
-- ground_truth - used for retrieving the historic ground truth by training id
create table models_testing_doc
(
  training_id VARCHAR (128) NOT NULL,
  transaction_id VARCHAR (128) NOT NULL,
  file_name varchar (1024) NOT NULL,
  doc_class_id VARCHAR (128) NOT NULL,
  num_pages  SMALLINT NOT NULL DEFAULT 0,
  kvptable TEXT,
  ground_truth   TEXT,

  CONSTRAINT models_testing_doc_training_log_fkey FOREIGN KEY (training_id) REFERENCES training_log (id)
    ON UPDATE RESTRICT ON DELETE CASCADE,

  CONSTRAINT models_testing_doc_runtime_doc_fkey FOREIGN KEY (transaction_id) REFERENCES RUNTIME_DOC (transaction_id)
          ON UPDATE RESTRICT ON DELETE CASCADE,

    CONSTRAINT models_testing_doc_pkey PRIMARY KEY (training_id, transaction_id)

);

-- Capture and store KeyClass value stats during data extraction training.
-- Attr(n) is the generic attribute names we use for storing the value stats.
create table value_metrics
(
    model_id VARCHAR (128) NOT NULL,
    key_class_id VARCHAR (128) NOT NULL,
    key_class_name VARCHAR (512) NOT NULL,
    doc_class_id VARCHAR (128) NOT NULL,
    template_id VARCHAR (128),
    attr1 DECIMAL(5,2),
    attr2 DECIMAL(5,2),
    attr3 DECIMAL(5,2),
    attr4 DECIMAL(5,2),
    attr5 DECIMAL(5,2),
    attr6 DECIMAL(5,2),
    attr7 DECIMAL(5,2),
    attr8 DECIMAL(5,2),
    attr9 DECIMAL(5,2),
    attr10 DECIMAL(5,2),
    attr11 DECIMAL(5,2),
    attr12 DECIMAL(5,2),
    attr13 DECIMAL(5,2),
    attr14 DECIMAL(5,2),
    attr15 DECIMAL(5,2),
    attr16 DECIMAL(5,2),
    attr17 DECIMAL(5,2),
    attr18 DECIMAL(5,2),
    attr19 DECIMAL(5,2),
    attr20 DECIMAL(5,2),
    attr21 DECIMAL(5,2),
    attr22 DECIMAL(5,2),
    attr23 DECIMAL(5,2),
    attr24 DECIMAL(5,2),
    attr25 DECIMAL(5,2),
    attr26 DECIMAL(5,2),
    attr27 DECIMAL(5,2),
    attr28 TEXT,
    flags SMALLINT NOT NULL default 0,

    CONSTRAINT value_metric_model_id_fkey FOREIGN KEY (model_id) REFERENCES MODELS (id)
        ON UPDATE RESTRICT ON DELETE CASCADE

);

CREATE TABLE system_options
      (
        config TEXT,
        opt_flags bigint not null default 0
      );

INSERT into system_options (config) values ('{"language": ["en"]}');


-- WEBHOOK definition
CREATE TABLE webhook
(
    ID VARCHAR(128) NOT NULL , 
    NAME VARCHAR(512) , 
    URL VARCHAR(2048) , 
    EVENT_TYPE VARCHAR(2048) , 
    RETRY_COUNT SMALLINT , 
    CONFIG TEXT default '{}', 
    CREATED_BY VARCHAR(128) NOT NULL , 
    CREATED_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    LAST_UPDATED_TS TIMESTAMP NOT NULL DEFAULT current_timestamp, 
    IS_ENABLED SMALLINT DEFAULT 1 ,
    COMMENT VARCHAR(1024) ,
    CONSTRAINT webhook_pkey PRIMARY KEY (ID)
);
-- create triiger for all last_updated_ts column for tables
CREATE OR REPLACE FUNCTION last_updated_ts_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_updated_ts = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_doc_class_last_updated_ts BEFORE UPDATE ON doc_class FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_object_type_last_updated_ts BEFORE UPDATE ON object_type FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_key_class_last_updated_ts BEFORE UPDATE ON key_class FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_attribute_alias_last_updated_ts BEFORE UPDATE ON attribute_alias FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_import_ontology_last_updated_ts BEFORE UPDATE ON import_ontology FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_training_log_last_updated_ts BEFORE UPDATE ON training_log FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_models_last_updated_ts BEFORE UPDATE ON models FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_published_models_last_updated_ts BEFORE UPDATE ON published_models FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_implementation_last_updated_ts BEFORE UPDATE ON implementation FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_implementation_kc_last_updated_ts BEFORE UPDATE ON implementation_kc FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_systemt_models_last_updated_ts BEFORE UPDATE ON systemt_models FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_systemt_model_metadata_last_updated_ts BEFORE UPDATE ON systemt_model_metadata FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_kvp_model_detail_last_updated_ts BEFORE UPDATE ON kvp_model_detail FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_templates_last_updated_ts BEFORE UPDATE ON templates FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
CREATE TRIGGER update_webhook_last_updated_ts BEFORE UPDATE ON webhook FOR EACH ROW EXECUTE PROCEDURE  last_updated_ts_column();
