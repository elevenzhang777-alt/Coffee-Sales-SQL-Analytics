Coffee Sales SQL Analytics

Overview
A practical MySQL data analytics project analyzing coffee shop transaction data, covering data cleaning, business analysis, and advanced SQL analytics.
The project contains 20 business questions, progressing from basic sales KPIs to advanced time-series and window-function analysis.

Dataset
Main table: coffe_sales
Key fields include:
Date · Time · money · coffee_name · cash_type · Time_of_Day · Weekday · Month_name · hour_of_day

Data Preparation
Converted raw date and time fields into proper MySQL data types
Standardized time formats
Checked for missing values across analytical fields
Inspected table structure and data quality

Analysis
Level 1 — Basic & Intermediate
Total revenue & order volume
Revenue by payment method
Best-selling coffee
Revenue by time of day and hour
Weekly and monthly sales analysis
Top 5 revenue-generating dates

Level 2 — Advanced Analytics
Top-N analysis using RANK()
Running revenue totals
Revenue contribution %
Day-over-Day growth using LAG()
Monthly average comparison
3-day moving averages
Median selling price
Most profitable hour by date
Revenue quartile segmentation using NTILE()
Longest continuous revenue growth streak using Gaps & Islands

SQL Skills Demonstrated
CTEs · Subqueries · Aggregations · Window Functions · RANK · DENSE_RANK · ROW_NUMBER · LAG · NTILE · Running Totals · Moving Averages · Median Calculation · Time-Series Analysis · Gaps & Islands

Project Structure
Coffee-Sales-SQL-Analytics/
├── README.md
├── coffee_sales_basic.sql
├── coffee_sales_advanced.sql
└── dataset/
    └── coffe_sales.csv
    
Tools
MySQL · SQL

Purpose
This project demonstrates practical SQL skills for Data Analyst / Business Analyst roles, with a focus on translating business questions into analytical SQL solutions.
