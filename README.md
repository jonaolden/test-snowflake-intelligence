# test-snowflake-intelligence

1. copy sql from 1_setup.sql and run in Snowsight to set up required objects
2. copy sql from 2_ingest_data.sql and run in Snowsight to ingest sample data from this repository into Snowflake tables
3. copy from 3_create_semantic_view and run in Snowsight to create semantic model view
4. configure semantic model in Snowsight, connect it to an agent and run queries against it