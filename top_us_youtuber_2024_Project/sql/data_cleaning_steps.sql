/*
# Data cleaning steps

1. Remove unnecessary columns by only selecting the ones we need
2. Extracting the Youtube channel names from the first columns
3. Rename the column names

*/


-- Remove unnecessary columns by only selecting the ones we need

select 
	Name, 
	total_subscribers, 
	total_views, 
	total_videos
from dbo.top_us_youtubers_2024;

-- Extracting the Youtube channel names from the first columns

-- CHARINDEX --> to get the index of character
--select CHARINDEX('@', Name) as position_index_of_@_in_name_column, Name
--from dbo.top_us_youtubers_2024;

--SUBSTRING --> to get the string from nth index to nth index
select 
	CAST(SUBSTRING(Name, 1, CHARINDEX('@', Name)-1) as varchar(100)) as channel_name,
	total_subscribers, 
	total_views, 
	total_videos
from dbo.top_us_youtubers_2024;

-- Creating view for the table above

CREATE VIEW view_us_youtubers_2024 AS

select 
	CAST(SUBSTRING(Name, 1, CHARINDEX('@', Name)-1) as varchar(100)) as channel_name,
	total_subscribers, 
	total_views, 
	total_videos
from dbo.top_us_youtubers_2024;