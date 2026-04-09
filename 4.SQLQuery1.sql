/*
Retrieve all data from customers and orders in two different results
*/

SELECT *
FROM customers;

SELECT *
FROM orders;

SELECT 
c.first_name, c.country,o.order_id,o.order_date,o.sales
FROM customers AS c
JOIN orders AS o
ON c.id = o.customer_id;


/*
Get all customers along with their orders, but
only for customers who have placed an order
*/

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id;

/*
Get all customers along with their orders, including those
without orders
*/

SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id;








