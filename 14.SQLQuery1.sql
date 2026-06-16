
-- Ranking windows function

-- Rank the orders based on their sales from highest to lowest
SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row,
	RANK()		 OVER(ORDER BY Sales DESC) AS SalesRank_Rank,
	DENSE_RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Dense
FROM Sales.orders;

-- Find the top highest sales for each product
SELECT
*
FROM
(SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) SalesRank
FROM Sales.Orders
) t WHERE SalesRank = 1;

-- Find the lowest 2 customers based on their total sales

SELECT *
FROM (
SELECT
	CustomerID,
	SUM(Sales) TotalSales,
	ROW_NUMBER() OVER(ORDER BY SUM(Sales)) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID
) t WHERE RankCustomers <= 2;

-- Asign unique IDs to the rows of the 'Orders Archive'
SELECT
ROW_NUMBER() OVER(ORDER BY OrderID, OrderDate) UniqueID,
*
FROM Sales.OrdersArchive;

-- Identify duplicate rows in the table 'Orders Archive' 
-- and return a clean result without any duplicates

SELECT
*
FROM (
SELECT
ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) AS rn ,
*
FROM Sales.OrdersArchive
) t WHERE rn > 1;


SELECT
	OrderID,
	Sales,
	NTILE(2) OVER(ORDER BY Sales DESC) TwoBucket,
	NTILE(3) OVER(ORDER BY Sales DESC) ThreeBucket
FROM Sales.Orders

-- Segment all orders into 3 categories: high, medium and low sales.

SELECT
*,
 CASE
	WHEN Buckets = 1 THEN 'High'
	WHEN Buckets = 2 THEN 'Medium'
	WHEN Buckets = 3 THEN 'Low'
 END AS SalesSegmentation
FROM (
SELECT
	OrderID,
	Sales,
	NTILE(3) OVER(ORDER BY Sales DESC) Buckets
FROM Sales.Orders
) t 























