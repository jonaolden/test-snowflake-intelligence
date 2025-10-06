
-- create role and assign privileges to enable snowflake intelligence

use role accountadmin;

create or replace role snowflake_intelligence_admin;
grant create warehouse on account to role snowflake_intelligence_admin;
grant create database on account to role snowflake_intelligence_admin;
grant create integration on account to role snowflake_intelligence_admin;

set current_user = (select current_user());   
grant role snowflake_intelligence_admin to user identifier($current_user);
alter user set default_role = snowflake_intelligence_admin;
alter user set default_warehouse = dash_wh_si;

use role snowflake_intelligence_admin;
create or replace database dash_db_si;
create or replace schema hotel;

create or replace warehouse dash_wh_si with warehouse_size='large';

create database if not exists snowflake_intelligence;
create schema if not exists snowflake_intelligence.agents;

grant create agent on schema snowflake_intelligence.agents to role snowflake_intelligence_admin;


use database dash_db_si;
use schema hotel;
use warehouse dash_wh_si;


-- set up git integration

-- set up integration with github to allow snowflake communicating with github api
create or replace api integration git_datasets_integration
api_provider = git_https_api
api_allowed_prefixes = ('https://github.com/')
enabled = true;

-- create github repository integration pointing towards repo with demo files (csv)
create or replace git repository datasets
api_integration = git_datasets_integration
origin = 'https://github.com/jonaolden/test-snowflake-intelligence.git';

-- create file format to read source files
create or replace file format csv_format
type = csv
parse_header = true
field_optionally_enclosed_by = '"';

-- create internal stage to stage files
create stage files_stage;

u

-- create semantic view 

