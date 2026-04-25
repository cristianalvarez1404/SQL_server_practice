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



