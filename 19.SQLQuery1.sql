-- CTAS => CREATE TABLE AS SELECT - More Quick than VIEW because copy table with fields choosed
/*
	-SQL-SERVER:
	
	SELECT
		INTO new_table
	FROM 
	WHERE

	-MYSQL-POSTGRESQL:
	
	CREATE TABLE AS 
	(
		SELECT
		FROM
		WHERE
	)
*/

SELECT
	DATENAME(MONTH, OrderDate) AS OrderMonth,
	COUNT(OrderID) AS TotalOrders
INTO Sales.MontlyOrder
FROM Sales.Orders
GROUP BY DATENAME(MONTH, OrderDate);

SELECT * FROM Sales.MontlyOrder;
DROP TABLE Sales.MontlyOrder;

-- Refresh CTAS => WE USE TSQL TRANSACT SQL (EXTENSION WHERE WE CAN USE PROGRAMMING INSIDE SQL)

IF OBJECT_ID('Sales.MontlyOrder', 'U') IS NOT NULL
	DROP TABLE Sales.MonthlyOrders;
GO
SELECT
	DATENAME(MONTH, OrderDate) AS OrderMonth,
	COUNT(OrderID) AS TotalOrders
INTO Sales.MontlyOrder
FROM Sales.Orders
GROUP BY DATENAME(MONTH, OrderDate);






