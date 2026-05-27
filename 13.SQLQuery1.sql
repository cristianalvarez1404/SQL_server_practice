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

-- Find the total sales across all orders
-- Additionally provide details such order ID, order date

SELECT
OrderID,
OrderDate,
SUM(Sales) OVER() AS TotalSales
FROM Sales.Orders;

-- Find the total sales for each product, additionally privide
-- details such order id & order date

SELECT
	OrderID,
	OrderDate,
	ProductId,
	SUM(Sales) OVER(PARTITION BY productID) AS TotalSales
FROM Sales.Orders;

-- Find the total sales across all orders
-- Find the total sales for each product
-- Additionally provide details such order Id, order date

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	SUM(Sales) OVER() TotalSales,
	SUM(Sales) OVER (PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders;

-- Find the total sales across all orders
-- Find the total sales for each product
-- Find the total sales for each combination of product and order status
-- Additionally provide details such order Id, order date

SELECT
	OrderID,
	OrderDate,
	Sales,
	ProductID,
	OrderStatus,
	SUM(Sales) OVER() TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) SalesByProducts,
	SUM(Sales) OVER(PARTITION BY ProductID,OrderStatus) SalesByProductsAndStatus
FROM Sales.Orders; 


SELECT
*
FROM Sales.Orders;

-- Rank each order based on their sales from highest to lowest
-- Additionally provide details such order Id, order date

SELECT
	OrderID,
	OrderDate,
	Sales,
	RANK() OVER (ORDER BY Sales DESC) AS RankSales
FROM Sales.Orders;


SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate 
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM Sales.Orders;

--shortcut

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate 
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) TotalSales
FROM Sales.Orders;


SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) TotalSales
FROM Sales.Orders;

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate 
ROWS UNBOUNDED PRECEDING) TotalSales
FROM Sales.Orders;

/*----------------------------------------------------------*/

SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
ORDER BY SUM(Sales) OVER(PARTITION BY OrderStatus)

-- Rank customers based on their total sales
SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	ProductID,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE ProductID IN (101, 102);


SELECT
	CustomerID,
	SUM(Sales) TotalSales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers 
FROM Sales.Orders
GROUP BY CustomerID

SELECT
	CustomerID,
	SUM(Sales) TotalSales,
	RANK() OVER(ORDER BY CustomerID DESC) RankCustomers 
FROM Sales.Orders
GROUP BY CustomerID


--Aggregate windows functions
--Find the total of orders

SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	COUNT(*) OVER(PARTITION BY OrderStatus) TotalOrders
FROM Sales.Orders;

































