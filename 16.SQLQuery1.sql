-- Subqueries
SELECT
*
FROM INFORMATION_SCHEMA.COLUMNS;

SELECT
DISTINCT TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS;


--- Result tyes ---
-- Scalar query => Single value
SELECT
AVG(Sales)
FROM Sales.Orders

-- Row subquery => Multiple rows, single column
SELECT
CustomerID
FROM Sales.Orders

--Table subquery => Multiple rows and multiple columns
SELECT
OrderID,
OrderDate
FROM Sales.Orders

-- Find the products that have a price higher than the average price of all products.

SELECT
*
FROM
(
	SELECT
		ProductID,
		Price,
		AVG(Price) OVER() AVGPrice
	FROM Sales.Products
) t WHERE Price > AVGPrice

-- Rank customers based on their total amount of sales

SELECT
	DENSE_RANK() OVER(ORDER BY total_sales DESC) AS rank_customers,
	*
FROM (
SELECT
	CustomerID,
	Sales,
	SUM(Sales) OVER(PARTITION BY CustomerID) AS total_sales
FROM Sales.Orders
) t ;

SELECT
*,
RANK() OVER(ORDER BY TotalSales) CustomerRank
FROM
(
SELECT
	CustomerID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY CustomerID) t;

-- SELECT CLAUSE

-- Show the product IDs, names, prices and total number of orders.

SELECT 
	ProductID,
	Product,
	Price,
	(SELECT COUNT(*) FROM Sales.Orders) AS total_orders
FROM Sales.Products;

-- Join clause

-- Show all customer details and find the total orders of each customer
SELECT
c.*,
o.totalOrders
FROM Sales.Customers AS c
LEFT JOIN (
SELECT
	CustomerID,
	COUNT(*) AS totalOrders
	FROM Sales.Orders GROUP BY CustomerID
) AS o 
ON c.CustomerID = o.CustomerID

















