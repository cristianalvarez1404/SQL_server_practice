-- CTE => Common Table Expression

-- Step1: find the total sales per customer

WITH CTE_Total_Sales AS
(
SELECT
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
-- Main Query
SELECT
c.CustomerID,
c.FirstName,
c.LastName,
cts.TotalSales
FROM Sales.Customers AS c
LEFT JOIN CTE_Total_Sales AS cts
ON cts.CustomerID = c.CustomerID; 


-- Multiple Standalone CTE
WITH CTE_Total_Sales AS
(
SELECT
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
),
-- Step 2 - Find the last order date for each customer
CTE_Total_Sales2 AS (
SELECT
	CustomerID,
	MAX(OrderDate) AS Last_Order
FROM Sales.Orders
GROUP BY CustomerID
)
-- Main Query
SELECT
c.CustomerID,
c.FirstName,
c.LastName,
cts.TotalSales,
clo.Last_Order
FROM Sales.Customers AS c
LEFT JOIN CTE_Total_Sales AS cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Total_Sales2 AS clo
ON clo.CustomerID = c.CustomerID; 


-- Nested CTE
WITH CTE_Total_Sales AS
(
SELECT
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
),
-- Step 2 - Find the last order date for each customer
CTE_Total_Sales2 AS (
SELECT
	CustomerID,
	MAX(OrderDate) AS Last_Order
FROM Sales.Orders
GROUP BY CustomerID
),
-- Step 3 => Rank Customers based on total sales per customer
CTE_Customer_Rank AS (
	SELECT
		CustomerID,
		TotalSales,
		RANK() OVER(ORDER BY TotalSales DESC) AS CustomerRank
	FROM CTE_Total_Sales
),
-- Step 4 => Segment customers based on their total sales
CTE_Customer_segments AS
(
	SELECT
		CustomerID,
		CASE 
			WHEN TotalSales > 100 THEN 'High'
			WHEN TotalSales > 50 THEN 'Medium'
			ELSE 'Low'
		END CustomerSegments
	FROM CTE_Total_Sales
)
-- Main Query
SELECT
c.CustomerID,
c.FirstName,
c.LastName,
cts.TotalSales,
clo.Last_Order,
crk.CustomerRank,
ccs.CustomerSegments
FROM Sales.Customers AS c
LEFT JOIN CTE_Total_Sales AS cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Total_Sales2 AS clo
ON clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank AS crk
ON crk.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_segments AS ccs
ON ccs.CustomerID = c.CustomerID; 


-- Recursive CTE

-- Generate a Sequence of numbers from 1 to 20

WITH Series AS (
	-- Anchor Query
	SELECT
		1 AS MyNumber
	UNION ALL
	-- Recursive query
	SELECT
		MyNumber + 1
	FROM Series
	WHERE MyNumber < 20
)
-- Main Query
SELECT *
FROM Series
OPTION (MAXRECURSION 10)

-- Task: Show the employee hierarchy by displaying each employee's level within the organization
WITH CTE_Emp_Hierarchy AS 
(
	-- Anchor query
	SELECT
		EmployeeID,
		FirstName,
		ManagerID,
		1 AS Level
	FROM Sales.Employees
	WHERE ManagerID IS NULL
	UNION ALL
	-- Recursive Query
	SELECT
		e.EmployeeID,
		e.FirstName,
		e.ManagerID,
		Level + 1
	FROM Sales.Employees AS e
	INNER JOIN CTE_Emp_Hierarchy AS ceh
	ON e.ManagerID = ceh.EmployeeID
)
--Main Query
SELECT
*
FROM CTE_Emp_Hierarchy










