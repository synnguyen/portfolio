/* use youtube_db

1. Define the variables
2. Create a CTE that rounds the average views per video
3. Select the columns that are required for the analysis
4. Filter the results by the Youtube channels with the highest subscriber bases
5. Order by new_profit (from highest to lowest)

*/

-- 1. 
DECLARE @conversionRate FLOAT = 0.02;		-- The conversion rate @ 2%
DECLARE @productCost FLOAT = 5.0;			-- The product cost @ $5
DECLARE @campaignCost FLOAT = 50000.0;		-- The campaign cost @ $50,000	


-- 2.  
WITH ChannelData AS (
    SELECT 
        channel_name,
        total_views,
        total_videos,
        ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
    FROM 
        youtube_db.dbo.view_us_youtubers_2024
)

--SELECT * 
--FROM ChannelData;

-- getting rounded_avg_views_per_video of top 3 channels for Analysis Excel column 
--SELECT * from  ChannelData
--where channel_name in ('MrBeast', 'Cocomelon - Nursery Rhymes', 'Vlad and Niki')


-- 3. 
SELECT 
    channel_name,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    ((rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost) AS net_profit
FROM 
    ChannelData

-- 4.
WHERE channel_name in ('MrBeast', 'Cocomelon - Nursery Rhymes', 'Vlad and Niki')

-- 5.  
ORDER BY
	net_profit DESC