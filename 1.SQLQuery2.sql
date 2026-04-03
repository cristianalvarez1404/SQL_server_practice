-- Retrive all customer data
SELECT * FROM customers;

-- Retrive all order data
SELECT * FROM orders;

-- Retrive each customer's name, country and score
SELECT 
	first_name,
	country,
	score 
FROM customers;

-- Retrive customers with a score not equal to 0
SELECT * FROM customers WHERE score <> 0;

	
-- Retrive customers from Germany
SELECT first_name, country FROM customers WHERE country = 'Germany';

-- Retrive all customers and sort the results by the highest score first
SELECT * FROM customers ORDER BY score DESC;

-- Retrive all customers and sort the result by the country and then by the highest score
SELECT * FROM customers ORDER BY  country, score DESC;

-- Find the total score for each country

SELECT 
	country,
	first_name,
	SUM(score) AS total_score
FROM customers
GROUP BY country,first_name;

-- Find the total score and total number of customers for each country
SELECT
	country,
	COUNT(id) AS total_customers,
	SUM(score) AS total_score
FROM customers
GROUP BY country;

/*
Find the average score for each country considering only customers with a score not equal
to 0 and return only those countries with an average score greater than 430
*/

SELECT
	country,
	AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430;

-- Return unique list of all countries

SELECT DISTINCT country 
FROM customers;

-- Retrive only 3 customers with the highest score

SELECT TOP 3 * 
FROM customers 
ORDER BY score DESC;

-- Retrive the lowest 2 customers based on the score

SELECT TOP 2 * 
FROM customers
ORDER BY score;

-- Get the two most recent orders

SELECT TOP 2 * 
FROM orders
ORDER BY order_date DESC;

-- Multiple queries
SELECT * 
FROM customers;

SELECT *
FROM orders;

-- Static fixed values

SELECT 123 AS static_number;
SELECT 'Hello' AS static_string;

SELECT
id,
first_name,
'New Customer' AS customer_type
FROM customers;

-- Highlight & Execute
SELECT *
FROM customers
WHERE country = 'Germany';


SELECT * FROM orders;




