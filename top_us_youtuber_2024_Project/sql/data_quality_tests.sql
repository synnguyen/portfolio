/*
Use youtube_db
# Data quality tests

1. The data needs to be 50 records of YouTube channels (row count test)	--- (passed!!!)
2. The data needs 4 fields (column count test)								--- (passed!!!)
3. The channel name column must be string format, and the other columns must be numerical data types (data type check)    --- (passed!!!)
4. Each record must be unique in the dataset (duplicate count check)  --- (passed!!!)

Row count - 50
Column count - 4

Data types

channel_name = VARCHAR
total_suncribers = INTEGER
toatl_views = INTEGER
toatl_videos = INTEGER

Duplicate count = 0 

*/

-- 1. Row count check

select COUNT(*) as row_count
from view_us_youtubers_2024;

-- 2. Column count check
select COUNT(*) as column_count
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'view_us_youtubers_2024';

-- 3. Data type check
select 
	COLUMN_NAME,
	DATA_TYPE
from 
	INFORMATION_SCHEMA.COLUMNS
where 
	TABLE_NAME = 'view_us_youtubers_2024';

-- 4. Duplicate count check
select 
	channel_name,
	COUNT(*) as duplicate_count
	from view_us_youtubers_2024
	group by channel_name
	having COUNT(*) > 1;