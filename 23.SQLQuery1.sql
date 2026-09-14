/*
  1.Partitions
  2.Groups
  3.Files
*/

-- Files
ALTER DATABASE SalesDB ADD FILE (
  NAME = P_2023,
  FILENAME = ''
) TO FILEGROUP FG_2023;

-- partition schema -- 4 partition: 4 filegroups
CREATE PARTITION SCHEMA SchemaPartitionByYear 
AS PARTITION PartitionByYear
TO (FG_2023, FG_2024, FG_2025, FG_2026);

-- Query lists all partition Schema
SELECT
  ps.name AS PartitionSchemaName,
  pf.name AS PartitionFunctionName,
  ds.destination_id AS PartitionNumber,
  fg.name AS FilegroupName
FROM sys.partition_schemas ps
JOIN sys.partition_functions pf ON ps.function_id = pf.function_id
JOIN sys.destination_data_spaces ds ON ps.data_space_id = ds.partition_schema_id
JOIN sys.filegroups fg ON ds.data_space_id = fg.data_space_id

-- create the partitioned table

CREATE TABLE Sales.Orders_Partitioned
(
  OrderID INT,
  OrderDate DATE,
  Sales INT
) ON SchemePartitionByYear (OrderDate);

-- Insert data into the partitioned table
INSERT INTO Sales.Orders_Partitioned VALUES (1, '2023-05-15', 100);
INSERT INTO Sales.Orders_Partitioned VALUES (2, '2024-07-20', 50);
INSERT INTO Sales.Orders_Partitioned VALUES (3, '2025-12-31', 20);
INSERT INTO Sales.Orders_Partitioned VALUES (4, '2026-01-01', 20);

SELECT * FROM Sales.Orders_Partitioned;


-- Tips
-- Select only what you need
SELECT CustomerID, FirstName, LastName FROM Sales.Customers;

-- Avoid unnecessary DISTINCT & ORDER BY
SELECT DISTINCT
  FirstName
FROM Sales.Customers
ORDER BY FirstName

SELECT 
  FirstName
FROM Sales.Customers

-- Limit Rows
SELECT TOP 10
  OrderID,
  Sales 
FROM Sales.Orders

-- Create nonclustered index on frequently used columns in WHERE clause
SELECT * FROM Sales.Orders WHERE OrderStatus = 'Delivered';

CREATE NONCLUSTERED INDEX Idx_Orders_OrderStatus ON Sales.Orders(OrderStatus);

-- Avoid applying functions to columns in WHERE clauses
SELECT * FROM Sales.Orders
WHERE LOWER(OrderStatus) = 'delivered'

-- BAB PRACTICE
SELECT *
FROM Sales.Customers
WHERE SUBSTRING(FirstName, 1, 1) = 'A'

-- GOOD PRACTICE
SELECT *
FROM Sales.Customers
WHERE FirstName LIKE 'A%';

--BAD PRACTICE
SELECT *
FROM Sales.Orders
WHERE YEAR(OrderDate) = 2025

--GOOD PRACTICE
SELECT *
FROM Sales.Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31'

/* Avoid leading wildcards as they prevent index usage*/
-- BAD PRACTICE
SELECT *
FROM Sales.Customers
WHERE LastName LIKE '%Gold%';

-- GOOD PRACTICE
SELECT *
FROM Sales.Customers
WHERE LastName LIKE 'Gold%';

/*Use IN instead of multiple OR*/

--BAD PRACTICE
SELECT *
FROM Sales.Orders
WHERE CustomerID = 1 OR CustomerID = 2 OR CustomerID = 3

--GOOD PRACTICE
SELECT *
FROM Sales.Orders
WHERE CustomerID IN (1,2,3)


/*JOINS BEST PRACTICE*/
-- Best performance
SELECT
  c.FirstName,
  o.OrderID
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID;

--Slighly slower performance
SELECT
  c.FirstName,
  o.OrderID
FROM Sales.Customers AS c
RIGHT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID;

SELECT
  c.FirstName,
  o.OrderID
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID;

-- Worst Performance
SELECT
  c.FirstName,
  o.OrderID
FROM Sales.Customers AS c
OUTER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID;

/*
  Use explicit JOIN (ANSI JOIN) instead of implicit JOIN (NON-ANSI JOIN)
*/

-- BAD PRACTICE
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c, Sales.Orders o
WHERE c.CustomerID = o.CustomerID;

-- GOOD PRACTICE
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON o.CustomerID = o.CustomerID;

/*
  Make sure to index the columns used in the ON clause
*/

SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON o.CustomerID = o.CustomerID;

CREATE NONCLUSTERED INDEX IX_Orders_CustomersID ON Sales.Orders(CustomerID)

/*
  Filter before joining (Big tables)
*/

-- Filter after JOIN (WHERE) -- FOR SMALL AND MEDIUM SIZE TABLES
SELECT c.FirstName, o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Delivered';

-- Filter During JOIN (AND)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
AND o.OrderStatus = 'Delivered'

-- Filter before JOIN (SUBQUERY) -- FOR LAGE TABLES
SELECT c.FirstName, o.OrderID
FROM Sales.Customers c
INNER JOIN (SELECT OrderID, CustomerID FROM Sales.Orders WHERE OrderStatus = 'Delivered') o
ON c.CustomerID = o.CustomerID

/*
  AGGREGATE BEFORE JOING (BIG TABLES)
*/

-- Best practices for small-medium tables
-- Grouping and joining
SELECT 
  c.CustomerID, 
  c.FirstName, 
  COUNT(o.OrderID) AS OrderCount
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName

-- Best practice for big tables
-- Pre-aggregated Subquery
SELECT 
  c.CustomerID, 
  c.FirstName, 
  o.OrderCount
FROM Sales.Customers AS c
INNER JOIN (
  SELECT 
    CustomerID,
    COUNT(OrderID) AS OrderCount
  FROM Sales.Orders
  GROUP BY CustomerID
) AS o
ON c.CustomerID = o.CustomerID

-- Bad practice
-- Correlated subquery
SELECT
  c.CustomerID,
  c.FirstName,
  (SELECT 
    COUNT(o.OrderID)
    FROM Sales.Orders o
    WHERE o.CustomerID = c.CustomerID
  ) AS OrderCount
FROM Sales.Customers AS c

-- User union instead of OR in Joins

-- Bad Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
OR c.CustomerID = o.SalesPersonID

-- Best practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
UNION
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.SalesPersonID

-- Check for nested loops and use SQL HINTS

SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID

-- Good practice for having big table & small table
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
OPTION(HASH JOIN)

-- UNION ALL instead of using UNION | duplicates are acceptable

-- Bad practice
SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive

-- Best practice
SELECT CustomerID FROM Sales.Orders
UNION ALL
SELECT CustomerID FROM Sales.OrdersArchive

-- USE UNION ALL + Distinct instead of using UNION | duplicates are not acceptable

-- Bad practice
SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive

-- Best practice
SELECT DISTINCT CustomerID
FROM (
  SELECT CustomerID FROM Sales.Orders
  UNION ALL
  SELECT CustomerID FROM Sales.OrdersArchive
) AS CombinedData


-- Use columnstore Index for Aggregations on large table

SELECT 
  CustomerID,
  COUNT(OrderID) AS OrderCount
FROM Sales.Orders
GROUP BY CustomerID

CREATE CLUSTERED COLUMNSTORE INDEX Idx_Orders_Columnstore ON Sales.Orders

-- Pre-Aggregate data and store it in new table for reporting

SELECT
  MONTH(OrderDate) AS OrderYear,
  SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

SELECT
  MONTH(OrderDate) AS OrderYear,
  SUM(Sales) AS TotalSales
INTO Sales.SalesSummary
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

/*TIPS SUBQUERIES*/

-- JOIN (BEST PRACTICE IF THE PERFORMANCE EQUALS TO EXISTS)
SELECT o.OrderID, o.Sales
FROM Sales.Orders o
INNER JOIN Sales.Customers c
ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA'

-- EXISTS (BEST PRACTICE: USE IT FOR LARGE TABLES)
SELECT o.OrderID, o.Sales
FROM Sales.Orders o
WHERE EXISTS (
  SELECT 1
  FROM Sales.Customers c
  WHERE c.CustomerID = o.CustomerID
  AND c.Country = 'USA'
)

-- IN - BAD PRACTICE(EVALUATE ALL ROWS)
SELECT o.OrderID, o.Sales
FROM Sales.Orders o
WHERE o.CustomerID IN (
  SELECT CustomerID
  FROM Sales.Customers
  WHERE Country = 'USA'
)

-- Avoid redundant logic in your query

-- Bad practice
SELECT 
  EmployeeID,
  FirstName,
  'Above Average' AS Status
FROM Sales.Employees
WHERE Salary > (SELECT AVG(Salary) FROM Sales.Employees)
UNION ALL
SELECT 
  EmployeeID,
  FirstName,
  'Below Average' AS Status
FROM Sales.Employees
WHERE Salary < (SELECT AVG(Salary) FROM Sales.Employees)

-- Good practice
SELECT
  EmployeeID,
  FirstName,
  CASE
    WHEN Salary > AVG(Salary) OVER() THEN 'Above Average'
    WHEN Salary < AVG(Salary) OVER() THEN 'Below Average'
    ELSE 'Average'
  END AS Status
FROM Sales.Employees

-- CREATING TABLES (DDL)

CREATE TABLE CustomersInfo (
  CustomerID INT,
  FirstName VARCHAR(MAX),
  LastName TEXT,
  Country VARCHAR(255),
  TotalPurchases FLOAT,
  Score VARCHAR(255),
  BirthDate VARCHAR(255),
  EmployeeID INT,
  CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
    REFERENCES Sales.Employees(EmployeeID)
)

CREATE TABLE CustomersInfo (
  CustomerID INT PRIMARY KEY CLUSTERED,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Country VARCHAR(50) NOT NULL,
  TotalPurchases FLOAT,
  Score INT,
  BirthDate DATE,
  EmployeeID INT,
  CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
    REFERENCES Sales.Employees(EmployeeID)
)


