---- create temperary table hotels which have all the tables 2018,2019,2020 combine

--with hotels as (
--	select * from dbo.['2018$']
--	union
--	select * from dbo.['2019$']
--	union
--	select * from dbo.['2020$'] )

--select * from hotels

---- output the revenue by adding stays_in_week_nights and stays_in_weekend_nights; Then multiply adr (hotel daily rate)

--with hotels as (
--	select * from dbo.['2018$']
--	union
--	select * from dbo.['2019$']
--	union
--	select * from dbo.['2020$'] )

--select (stays_in_week_nights + stays_in_weekend_nights)*adr as revenue 
--from hotels

-- see if the revenue of each hotel type increasing by year

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'] )

select 
arrival_date_year, hotel,
round(sum((stays_in_week_nights + stays_in_weekend_nights)*adr),2) as revenue 
from hotels
group by arrival_date_year, hotel;

--join table above with market_segment

with hotels as (
	select * from dbo.['2018$']
	union
	select * from dbo.['2019$']
	union
	select * from dbo.['2020$'] )

select * from hotels
left join dbo.market_segment$
on hotels.market_segment = market_segment$.market_segment
left join dbo.meal_cost$
on hotels.meal = meal_cost$.meal