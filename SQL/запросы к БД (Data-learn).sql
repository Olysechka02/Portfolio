/* 1. Overview:
Total Sales
Total Profit
Profit Ratio
Profit per Order
Sales per Customer
Avg. Discount
Monthly Sales by Segment (табличка)
Monthly Sales by Product Category (табличка)

2. Sales by Product Category over time

3. Customer Analysis:
Sales and Profit by Customer
Customer Ranking - не поняла, что это
Sales per region */

-- 1.1
select 
sum (sales) as total_sales
from public.orders as o

-- 1.2
select 
sum (profit) as total_profit
from orders as o

-- 1.3
select 
sum (profit) / sum (sales) *100 as Profit_ratio
from orders as o

-- 1.4 
select 
sum (profit) / count(distinct o.order_id) as Profit_per_Order
from orders as o

-- 1.5 
select 
sum (sales) / count(distinct o.customer_id) as Sales_per_Customer
from orders as o

-- 1.6 
select 
avg (discount) as Avg_Discount 
FROM orders o

-- 1.7 Monthly Sales by Segment
select
distinct segment as segments,
EXTRACT(YEAR FROM order_date) AS year,
EXTRACT(MONTH FROM order_date) AS month,
SUM(sales) AS total_sales
FROM public.orders
GROUP BY segment, year, month
ORDER BY segment, year, month;

-- 1.8 Monthly Sales by Product Category 
select
distinct category as categorys,
EXTRACT(YEAR FROM order_date) AS year,
EXTRACT(MONTH FROM order_date) AS month,
SUM(sales) AS total_sales
FROM public.orders
GROUP BY category, year, month
ORDER BY category, year, month;

-- 2 Sales by Product Category over time
select 
category,
SUM(sales) AS total_sales
FROM public.orders
GROUP BY category
ORDER by category 

-- 3.1 Sales and Profit by Customer

/*select --793
distinct customer_id
from orders;*/

select
distinct customer_id,
SUM(sales) AS total_sales,
sum (profit) as total_profit
from orders
GROUP BY customer_id
ORDER by customer_id asc 

-- 3.2 Customer Ranking???

-- 3.3 Sales per region
select
distinct region,
SUM(sales) AS total_sales
from orders
GROUP BY region
ORDER by region asc 




