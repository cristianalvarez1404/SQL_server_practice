-- find the running total of sales for each month

--CTE
WITH CTE_Montly_Summary AS (
	SELECT
		DATETRUNC(MONTH, OrderDate) AS OrderMonth,
		SUM(Sales) AS TotalSales,
		COUNT(OrderID) AS TotalOrders,
		SUM(Quantity) AS TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(MONTH, OrderDate)
)
SELECT
OrderMonth,
TotalSales,
SUM(TotalSales) OVER(ORDER BY OrderMonth) AS RunningTotal
FROM CTE_Montly_Summary;


-- VIEW
CREATE VIEW V_Monthly_Summary AS
(
	SELECT
		DATETRUNC(MONTH, OrderDate) AS OrderMonth,
		SUM(Sales) AS TotalSales,
		COUNT(OrderID) AS TotalOrders,
		SUM(Quantity) AS TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(MONTH, OrderDate)
);

SELECT
*
FROM dbo.V_Monthly_Summary;