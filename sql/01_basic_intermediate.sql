create database coffe_sales_database;
use coffe_sales_database;
select* from coffe_sales limit 10; 
desc coffe_sales;
update coffe_sales set date= str_to_date(date,'%d-%m-%Y');
alter table coffe_sales modify DATE DATE;

update coffe_sales set TIME = REPLACE(TIME,'.',':');
alter table coffe_sales modify time time;

select * from coffe_sales
where hour_of_day is null or cash_type is null or money is null or 
coffee_name is null or
Time_of_Day is null or
Weekday is null	or
Month_name is null or
Weekdaysort is null or
Monthsort is null or
Date is null or
Time is null;

-- Level 1: Basic & Intermediate
-- 1.What is the total revenue generated so far?
select round(sum(money),2) as Total_revenue from coffe_sales;

-- 2.How many total coffee orders have been placed in the entire dataset?
select count(*) as total_orders from coffe_sales;

-- 3. List all the unique types of coffee sold in the shop.
select distinct(coffee_name)from coffe_sales;

-- 4. Compare the total revenue generated from 'Card' versus 'Cash' payments.
select cash_type, sum(money) as total_revenue
from coffe_sales
group by cash_type;

--  5. Which specific coffee name has the highest number of total orders?
select coffee_name, count(*) as total_order
from coffe_sales
group by coffee_name
order by count(*) desc limit 1;

--  6. Which time of day (Morning, Afternoon, Night) is the most profitable in terms of total
-- revenue?
select time_of_day, sum(money) as total_revenue
from coffe_sales
group by time_of_day
order by total_revenue desc limit 1 ;

--  7. Calculate the total number of orders received for each day of the week (Weekday).
select weekday, count(*) as total_orders
from coffe_sales
group by WEEKDAY;

--  8. During which hour of the day (hour_of_day) do the highest sales occur?
select HOUR_OF_DAY, SUM(MONEY) as TOTAL_REVENUE
from coffe_sales
group by hour_of_day
order by total_revenue desc limit 1;

--  9. Provide a monthly breakdown of total sales revenue
select month_name, sum(money) as total_revenue
from coffe_sales
group by month_name
order by total_revenue desc;

-- 10. Identify the top 5 individual dates that generated the highest revenue.
select date, sum(money)as total_revenue
from coffe_sales
group by date
order by total_revenue desc limit 5;
