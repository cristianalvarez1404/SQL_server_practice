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

/*
Get all customers along with their orders, including orders without
matching customers
*/

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id;

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id;


-- Get all customers and all orders, even if there's no match
SELECT *
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id;

/* ANTI JOINS */


-- Get all customers who haven't placed any order
SELECT *
FROM customers as c
LEFT JOIN orders as o
ON c.id = o.customer_id
WHERE o.order_id IS NULL;

SELECT *
FROM customers as c
RIGHT JOIN orders as o
ON c.id = o.customer_id
WHERE c.id IS NULL;

SELECT *
FROM orders as o 
LEFT JOIN customers as c
ON c.id = o.customer_id
WHERE c.id IS NULL;

SELECT *
FROM customers as c
FULL JOIN orders as o
ON c.id = o.customer_id
WHERE o.order_id IS NULL OR c.id IS NULL;

/*
Get all customers along with their orders,
but only for customers who have placed an order
whithout using INNER JOIN
*/

SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.order_id IS NOT NULL;














