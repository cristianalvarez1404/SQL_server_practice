
/* SET OPERATORS*/

SELECT
FirstName,
LastName
FROM Sales.Customers

UNION

SELECT
FirstName,
LastName
FROM Sales.Employees;

-- UNION ALL => Return all rows from both queries, including duplicates.

-- Combine the data from employees and customers into one table

SELECT
	EmployeeID,
	FirstName,
	LastName
FROM Sales.Employees
UNION ALL
SELECT 
	CustomerID,
	FirstName,
	LastName
FROM Sales.Customers

-- Find employees who are not customers at the same time
SELECT
	FirstName,
	LastName
FROM Sales.Employees
EXCEPT
SELECT
	FirstName,
	LastName
FROM Sales.Customers

-- Intersect => Returns only the rows that are common in both queries
SELECT
	FirstName,
	LastName
FROM Sales.Employees
INTERSECT
SELECT
	FirstName,
	LastName
FROM Sales.Customers

-- USES
-- Combine similar information before analyzing the data

-- Orders data are stored in separte tables (Orders and OrdersArchive).
-- Combine all orders data into one report without duplicates.

SELECT
    'Orders' AS SourceTable,
	[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
UNION
SELECT
    'OrdersArchive' AS SourceTable,
	[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID;



















