-- Aggregate functions
-- Find the total number of orders

SELECT
COUNT(*) AS total_nr_orders
FROM orders;

-- Find the total sales of all orders
SELECT
SUM(sales) AS total_sales
FROM orders;

-- Find the average sales of all orders
SELECT
AVG(sales) AS avg_sales
FROM orders;

-- Find the highest sales of all orders
SELECT
MAX(sales) AS max_sale
FROM orders;

-- Find the lowest score among customers
SELECT
MIN(sales) AS min_sale
FROM orders;

SELECT
customer_id,
COUNT(*) AS total_nr_orders,
SUM(sales) AS total_sales,
AVG(sales) AS avg_sales,
MAX(sales) AS highest_sales,
MIN(sales) AS lowest_sales
FROM orders
GROUP BY customer_id



















