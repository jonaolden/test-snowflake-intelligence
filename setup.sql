


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
create or replace schema retail;

create or replace warehouse dash_wh_si with warehouse_size='large';

create database if not exists snowflake_intelligence;
create schema if not exists snowflake_intelligence.agents;

grant create agent on schema snowflake_intelligence.agents to role snowflake_intelligence_admin;

use database dash_db_si;
use schema retail;
use warehouse dash_wh_si;

create or replace file format swt_csvformat  
  skip_header = 1  
  field_optionally_enclosed_by = '"'  
  type = 'csv';  
  
-- create table marketing_campaign_metrics and load data from s3 bucket
create or replace stage swt_marketing_data_stage  
  file_format = swt_csvformat  
  url = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/marketing/';  
  
create or replace table marketing_campaign_metrics (
  date date,
  category varchar(16777216),
  campaign_name varchar(16777216),
  impressions number(38,0),
  clicks number(38,0)
);

copy into marketing_campaign_metrics  
  from @swt_marketing_data_stage;

-- create table products and load data from s3 bucket
create or replace stage swt_products_data_stage  
  file_format = swt_csvformat  
  url = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/product/';  
  
create or replace table products (
  product_id number(38,0),
  product_name varchar(16777216),
  category varchar(16777216)
);

copy into products  
  from @swt_products_data_stage;

-- create table sales and load data from s3 bucket
create or replace stage swt_sales_data_stage  
  file_format = swt_csvformat  
  url = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/sales/';  
  
create or replace table sales (
  date date,
  region varchar(16777216),
  product_id number(38,0),
  units_sold number(38,0),
  sales_amount number(38,2)
);

copy into sales  
  from @swt_sales_data_stage;

-- create table social_media and load data from s3 bucket
create or replace stage swt_social_media_data_stage  
  file_format = swt_csvformat  
  url = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/social_media/';  
  
create or replace table social_media (
  date date,
  category varchar(16777216),
  platform varchar(16777216),
  influencer varchar(16777216),
  mentions number(38,0)
);

copy into social_media  
  from @swt_social_media_data_stage;

-- create table support_cases and load data from s3 bucket
create or replace stage swt_support_data_stage  
  file_format = swt_csvformat  
  url = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/support/';  
  
create or replace table support_cases (
  id varchar(16777216),
  title varchar(16777216),
  product varchar(16777216),
  transcript varchar(16777216),
  date date
);

copy into support_cases  
  from @swt_support_data_stage;

ALTER ACCOUNT SET CORTEX_ENABLED_CROSS_REGION = 'AWS_US';

select 'Congratulations! Snowflake Intelligence setup has completed successfully!' as status;


create or replace api integration git_datasets_integration
api_provider = git_https_api
api_allowed_prefixes = ('https://github.com/')
--  allowed_authentication_secrets = (git_secret)
enabled = true;


create or replace git repository datasets
api_integration = git_datasets_integration
-- git_credentials = myco_git_secret
origin = 'https://github.com/jonaolden/test-snowflake-intelligence.git';

select $1 from @datasets/branches/master/employees.csv;