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