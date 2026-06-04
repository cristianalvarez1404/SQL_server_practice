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

-- Find the total number of Orders
-- Additionally provide details such order Id, order date

SELECT
	OrderID,
	OrderDate,
	CustomerID,
	COUNT(*) OVER() TotalOrders,
	COUNT(*) OVER(PARTITION BY CustomerID) OrdersByCustomers 
FROM Sales.Orders;

-- Find the total number of customers
-- Find the total number of scores for the customers
-- Additionally provide all customers details

SELECT
	*,
	COUNT(*) OVER() TotalCustomers,
	COUNT(Score) OVER() TotalScore
FROM Sales.Customers;

-- Check whether the table 'orders' contains any duplicate rows
SELECT
*
FROM (
	SELECT
		OrderID,
		COUNT(*) OVER(PARTITION BY OrderID) CheckPK
	FROM Sales.OrdersArchive
)t WHERE CheckPK > 1

-- Find the total sales across all orders
-- And the total sales for each product
-- Additionally provide details such order Id, order date

SELECT
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER() TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) AS totalSalesProduct
FROM Sales.Orders;

-- Find the percentage contribution of each product's sales to the total sales

SELECT
	OrderID,
	ProductID,
	Sales,
	SUM(Sales) OVER() TotalSales,
	ROUND((CAST (Sales AS FLOAT) / SUM(Sales) OVER() * 100), 2) PercentageOfTotal
FROM Sales.Orders;

-- Find the average sales across all orders
-- And find the average sales for each product
-- Additionally provide details such order ID, order date

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	AVG(COALESCE(Sales,0)) OVER(PARTITION BY ProductID) AvgByProduct
FROM Sales.Orders;

-- Find the average scores of customers
-- Additionally provide details such customerID and lastname

SELECT
	CustomerID,
	LastName,
	Score,
	AVG(COALESCE(Score,0)) OVER(PARTITION BY CustomerID) AvgCustomer
FROM Sales.Customers;

-- Find all orders where sales are higher than the average sales across all orders

SELECT
*
FROM (
	SELECT
		OrderID,
		ProductID,
		Sales,
		AVG(COALESCE(Sales, 0)) OVER() AS AvgSales
	FROM Sales.Orders
)t WHERE Sales > AvgSales
 
-- Find the highest and lowest sales of all orders
-- Find the highest and lowest sales for each product
-- Additionally provide details such order Id, order date

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MAX(Sales) OVER() HighestSales,
	MAX(Sales) OVER(PARTITION BY ProductID) AS HighestSalesByProduct,
	MIN(Sales) OVER() LowestSales,
	MIN(Sales) OVER(PARTITION BY ProductID) AS LowestSalesByProduct
FROM Sales.Orders


-- Show the employees who have the highest salaries

SELECT
*
FROM (
	SELECT
		*,
		MAX(Salary) OVER() HighestSalary
	FROM Sales.Employees;
) t WHERE Salary = HighestSalary;


































