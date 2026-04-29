-- DATE & TIME FUNCTIONS

SELECT
	OrderID,
	OrderDate,
	ShipDate,
	CreationTime
FROM Sales.Orders;

SELECT
	OrderID,
	CreationTime,
	'2025-08-20' AS HardCoded,
	GETDATE() AS Today 
FROM Sales.Orders;

SELECT
	OrderID,
	CreationTime,
	DATEPART(YEAR, CreationTime) AS Year_dp,
	DATEPART(MONTH, CreationTime) AS Month_dp,
	DATEPART(DAY, CreationTime) AS Day_dp,
	DATEPART(HOUR, CreationTime) AS Hour_dp,
	DATEPART(MINUTE, CreationTime) AS Minute_dp,
	DATEPART(SECOND, CreationTime) AS Second_dp,
	DATEPART(WEEK, CreationTime) AS Week_dp,
	DATEPART(QUARTER, CreationTime) AS quarter_dp,
	DATEPART(WEEKDAY, CreationTime) AS Week_day_dp,
	YEAR(CreationTime) AS creation_Year,
	MONTH(CreationTime) AS creation_Month,
	DAY(CreationTime) AS creation_Day
FROM Sales.Orders;

SELECT
	OrderID,
	CreationTime,
	DATENAME(MONTH, CreationTime) AS Month_dn,
	DATENAME(WEEKDAY, CreationTime) AS Month_dn
FROM Sales.Orders;

SELECT
	OrderID,
	CreationTime,
	DATETRUNC(MINUTE, CreationTime) AS reset_minut,
	DATETRUNC(HOUR, CreationTime) AS reset_hour,
	DATETRUNC(DAY, CreationTime) AS reset_day,
	DATETRUNC(MONTH, CreationTime) AS reset_month,
	DATETRUNC(YEAR, CreationTime) AS reset_year
FROM Sales.Orders;

SELECT
	DATETRUNC(MONTH, CreationTime) AS reset_month,
	COUNT(*) AS total_orders
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH, CreationTime);

SELECT
	DATETRUNC(YEAR, CreationTime) AS reset_year,
	COUNT(*) AS total_orders
FROM Sales.Orders
GROUP BY DATETRUNC(YEAR, CreationTime);

SELECT
	OrderID,
	CreationTime,
	EOMONTH(CreationTime) AS EndOfMonth,
	CAST(DATETRUNC(MONTH, CreationTime) AS DATE) AS StartOfMonth 
FROM Sales.Orders;

-- How many orders were placed each year?
SELECT
YEAR(OrderDate) AS OrderDate,
COUNT(*) AS NrOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate);

-- How many orders were placed each month?
SELECT
MONTH(OrderDate) AS OrderMonth,
COUNT(*) AS NrOfOrders
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

-- Show all orders that were placed during the month of febrery
SELECT
	*
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2

SELECT
	OrderID,
	CreationTime,
	FORMAT(CreationTime, 'MM-dd-yyyy') USA_Format,
	FORMAT(CreationTime, 'dd-MM-yyyy') EURO_Format,
	FORMAT(CreationTime,'dd') dd,
	FORMAT(CreationTime, 'ddd') ddd,
	FORMAT(CreationTime,'dddd') dddd,
	FORMAT(CreationTime, 'MM') MM,
	FORMAT(CreationTime,'MMM') MMM,
	FORMAT(CreationTime, 'MMMM') MMMM,
	FORMAT(CreationTime,'yy') y,
	FORMAT(CreationTime, 'yyyy') yyyy
FROM Sales.Orders

-- Show creationTime using the followig format:
-- Day Wed Jan Q1 2025 12:34:56 PM
SELECT	
	OrderID,
	CreationTime,
	'Day ' + FORMAT(CreationTime,'ddd MMM') + ' Q' + DATENAME(QUARTER, CreationTime) + ' ' + FORMAT(CreationTime, 'yyyy hh:mm:ss tt') AS CustomeFormat
FROM Sales.Orders




