-- Window basics
/*
	Perform calculation(e.g aggregation)
	on a specific subset of data,
	without losing the level of details of rows.
*/

-- Find the total sales across all orders
USE SalesDB

SELECT
SUM(Sales) AS total_sales
FROM Sales.Orders;

-- Find the total sales for each product
SELECT
	ProductID,
	SUM(Sales) AS total_sales
FROM Sales.Orders
GROUP BY ProductID;

-- Find the total sales for each product, additionally provide
-- details such order id & order date
SELECT
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) AS total_sales
FROM Sales.Orders
GROUP BY OrderID,OrderDate,ProductID;

SELECT
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) AS total_sales_by_product
FROM Sales.Orders;







