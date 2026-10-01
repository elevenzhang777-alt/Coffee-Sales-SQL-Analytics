
use coffe_sales_database;

-- Level 2: Hard & Advanced Analytics
-- 11. For each 'Time_of_Day', find the top 2 best-selling coffees based on total revenue.
with temp as (
		select time_of_day, coffee_name, sum(money) as total_revenue,
		rank()over (partition by time_of_day order by sum(money) desc) as rnk
		from coffe_sales
		group by time_of_day ,coffee_name 
)
select time_of_day, coffee_name,total_revenue,rnk 
from temp
where rnk<=2;

--  12. Create a report showing the daily revenue alongside a cumulative (running) total of
-- revenue over time

with dailysales as (
		select date,sum(money) as dailysales
		from coffe_sales
		group by date)
select date,dailysales, sum(dailysales)over(order by date) as running_total
from dailysales
group by date;

-- 13. Calculate the percentage contribution of each coffee type to the total overall revenue of
 the shop
with temp as (
		select sum(money) as grand_total from coffe_sales)
select coffee_name, sum(money) as revenue, (sum(money)/(select grand_total from temp)*100) as percentcontrib
from coffe_sales 
group by coffee_name 
order by percentcontrib desc;


-- 14. Determine the Day-over-Day (DoD) growth percentage in total sales revenue for each
-- date
with daily_data as (
		select date,sum(money) as rev
		from coffe_sales
		group by date
)
select date,round(rev,2) as current_day_sales,
		LAG(rev) over(order by date) as previous_day_sales, 
		round(((rev-LAG(rev) over(order by date))/(LAG(rev) over(order by date))*100),2) as dod_growth_pct
from daily_data 
order by date;

--  15. Find all specific dates where the total daily sales exceeded the average daily sales of
-- their respective month.

with daily_sales as (
        select month_name, date, sum(money) as daily_rev
		from coffe_sales
		group by month_name, date),
month_avg as (
        select month_name,avg(daily_rev) as avg_monthly_daily_rev
        from daily_sales 
        group by month_name
)
select date, daily_rev,avg_monthly_daily_rev
		from daily_sales d
		join month_avg m
		on d.month_name = m.month_name 
		where d.daily_rev > m.avg_monthly_daily_rev;

-- 16. Calculate a 3-day moving average for the daily sales revenue to identify sales trends
with daily_sales as (
		select date, sum(money) as rev 
		from coffe_sales 
		group by date
)
select date, rev as daily_revenue, 
		avg(rev) over (order by date rows between 2 preceding and current row)
		as 3_day_moving_avg
		from daily_sales;

-- 17. Calculate the Median selling price for each type of coffee (not just the average)
with order_data as (
		select coffee_name, money, 
		row_number() over (partition by coffee_name order by money) as rnk,
		count(*) over (partition by coffee_name) as total_count
		from coffe_sales
)
select coffee_name, avg(money) as median_price
from order_data
where rnk in (floor((total_count+1)/2),ceil((total_count+1)/2))
group by coffee_name;

--  18. For every single date, identify the exact hour that was the most profitable
with hourly_daily as (
		select date, hour_of_day, sum(money) as rev,
		dense_rank() over (partition by date order by sum(money) desc) as rnk
		from coffe_sales
		group by date, hour_of_day
)
select date, hour_of_day, REV as hourly_revenue
from hourly_daily 
where rnk=1;

-- 19. Use NTILE or similar window functions to segment dates into 4 quartiles based on their
-- total revenue volume.
with daily_sales as (
		select date, sum(money) as rev
		from coffe_sales
		group by date
)
select date, rev,
	ntile(4) over (order by rev desc) as revenue_quartile_rank
from daily_sales;

--  20. Find the longest continuous streak of days where the daily revenue was strictly higher
-- than the previous day

with daily_sales as (
    select date, sum(money) as rev 
    from coffe_sales
    group by date
),
growth_data as (
    select date, rev, 
    case when rev > lag(rev) over (order by date)
    then 1 else 0 end as is_growth
    from daily_sales 
),
gaps_and_islands as (
    select date, rev, is_growth,
    row_number() over (order by date) - 
    row_number() over (partition by is_growth order by date) as grp
    from growth_data 
)
select min(date) as streak_start_date, 
       max(date) as streak_end_date,
       count(*) as continuous_growth_days
from gaps_and_islands 
where is_growth = 1  
group by grp 
order by continuous_growth_days desc
limit 1;


select date, sum(money)
from coffe_sales
group by date;









