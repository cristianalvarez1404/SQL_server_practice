SELECT
FORMAT(OrderDate,'MMM yy') OrderDate,
COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate,'MMM yy');

-- Convert => convert values
SELECT
--CONVERT(INT, '123') AS [String to Int CONVERT],
--CONVERT(DATE, '2025-08-20') AS [String to Date CONVERT],
CreationTime,
CONVERT(DATE, CreationTime) AS [Datetime to Date CONVERT],
CONVERT(VARCHAR, CreationTime, 32) AS [USA Std. Style: 32],
CONVERT(VARCHAR, CreationTime, 34) AS [EURO Std. Style: 34]
FROM Sales.Orders;

SELECT
CAST('123' AS INT) AS [String to Int],
CAST(123 AS VARCHAR) AS [Int to String],
CAST('2025-08-20' AS DATE) AS [String to Date],
CAST('2025-08-20' AS DATETIME) AS [String to Datetime],
CreationTime,
CAST(CreationTime AS DATE) AS [Datetime to Date]
FROM Sales.Orders;

------------------------------------------------------------------

SELECT
OrderID,
OrderDate,
DATEADD(DAY, -10,OrderDate) AS TenDaysBefore,
DATEADD(MONTH, 3, OrderDate) AS ThreeMonthsLater,
DATEADD(YEAR, 2, OrderDate) AS TwoYearsLater
FROM Sales.Orders;

-- Calculate the age of employees

SELECT
EmployeeID,
BirthDate,
DATEDIFF(YEAR,BirthDate, GETDATE()) AS Age
FROM Sales.Employees	 

-- Find the average shipping duration in days for each month
SELECT
--OrderID,
MONTH(OrderDate) AS OrderDate,
--ShipDate,
AVG(DATEDIFF(DAY, OrderDate, ShipDate)) AS Day2Ship
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

-- Find the number of days between each order and the previous order
SELECT
OrderID,
OrderDate AS CurrentOrderDate,
DATEDIFF(DAY, LAG(OrderDate) OVER (ORDER BY OrderDate),OrderDate) AS previousOrderDay
FROM Sales.Orders;

SELECT 
ISDATE('123') DateCheck1,
ISDATE('2025-08-20') DateCheck2,
ISDATE('20-08-2025') DateCheck3,
ISDATE('2025') DateCheck4,
ISDATE('08') DateCheck5;

SELECT
 --CAST(OrderDate AS DATE) OrderDate,
 OrderDate,
 ISDATE(OrderDate),
 CASE WHEN ISDATE(OrderDate) = 1 
	THEN CAST(OrderDate AS DATE)
	ELSE '9999-01-01'
	END AS NewOrder
FROM 
(
	SELECT
	'2025-08-20' AS OrderDate
	UNION
	SELECT
	'2025-08-21'
	UNION
	SELECT
	'2025-08-23'
	UNION
	SELECT
	'2025-08'
)t
WHERE ISDATE(OrderDate) = 0;








