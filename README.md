# AWS Marketplace Templates for IBM Cloud Pak for Business Automation

This repo consists of AWS Marketplace artifacts for IBM Cloud Pak for Business Automation.

## Template layout

Each component under `templates/` follows the same structure:

- `propertyfiles` - property file templates. Replace all `<Required>` values before use.
- `dbscripts` - database creation scripts, grouped by database type. Before running a script, replace the `<username>` and `<password>` placeholders with the database user name and password you want to use.
  - `db2`, `mssql`, `oracle`, `postgresql` - scripts for self-managed databases.
  - `rds_db2`, `rds_mssql`, `rds_oracle`, `rds_postgresql` - scripts for Amazon RDS databases.

Not every component provides every database type. The sections below list the folders available for each component.

## Property files and Scripts

### Common property files
- `templates/common/propertyfiles`

### IBM Business Automation Workflow Authoring
- `templates/baw_authoring/propertyfiles`
- `templates/baw_authoring/dbscripts` (`db2`, `mssql`, `oracle`, `postgresql`, `rds_db2`, `rds_mssql`, `rds_oracle`, `rds_postgresql`)

### IBM Business Automation Workflow Runtime
- `templates/baw_runtime/propertyfiles`
- `templates/baw_runtime/dbscripts` (`db2`, `mssql`, `oracle`, `postgresql`, `rds_db2`, `rds_mssql`, `rds_oracle`, `rds_postgresql`)

### IBM Content Cortex
- `templates/ccx/propertyfiles`
- `templates/ccx/dbscripts` (`db2`, `mssql`, `oracle`, `postgresql`, `rds_db2`, `rds_mssql`, `rds_oracle`, `rds_postgresql`)

### IBM Content Cortex AI Services
- `templates/ccxai/propertyfiles`

### IBM Operational Decision Manager
- `templates/odm/propertyfiles`
- `templates/odm/dbscripts` (`db2`, `mssql`, `oracle`, `postgresql`, `rds_db2`, `rds_mssql`, `rds_oracle`, `rds_postgresql`)

### IBM Automation Decision Services
- `templates/ads/propertyfiles`
- `templates/ads/dbscripts` (`db2`, `mssql`, `oracle`, `postgresql`)

### IBM Business Automation Application
- `templates/baa/propertyfiles`
- `templates/baa/dbscripts` (`db2`, `mssql`, `oracle`, `postgresql`, `rds_db2`, `rds_mssql`, `rds_oracle`, `rds_postgresql`)

### IBM Automation Workstream Services
- `templates/aws/propertyfiles`
- `templates/aws/dbscripts` (`db2`, `mssql`, `oracle`, `postgresql`, `rds_db2`, `rds_mssql`, `rds_oracle`, `rds_postgresql`)

### IBM Automation Document Processing
Split into authoring (development) and runtime environments.

- Development
  - `templates/adp_dev/propertyfiles`
  - `templates/adp_dev/dbscripts` (`db2`, `postgresql`, `rds_db2`, `rds_postgresql`)
- Runtime
  - `templates/adp_runtime/propertyfiles`
  - `templates/adp_runtime/dbscripts` (`postgresql`, `rds_postgresql`)

### IBM Workflow Process Service Authoring
- `templates/wfpsa/propertyfiles`
- `templates/wfpsa/dbscripts` (`postgresql`)

### IBM Decision Intelligence Client Managed Software
- `templates/dicms/propertyfiles`
- `templates/dicms/dbscripts` (`postgresql`, `rds_postgresql`)
