create or replace pipe NYC_TAXI_DB.ANALYTICS.PIPE_LOAD_BUSINESS_STATS auto_ingest=true as COPY INTO STAGE.nyc_gold_business_stats
FROM @outbound_stage/outbound_business_stats/
FILE_FORMAT = (TYPE = PARQUET)
PATTERN = '.*\\.parquet'
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
ON_ERROR = CONTINUE;