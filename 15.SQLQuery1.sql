-- Analize the month-over-month performance by finding the percentage change
-- In sales between the current and previous months

SELECT
	--OrderID,
	--OrderDate,
	MONTH(OrderDate) AS OrderMonth,
	SUM(Sales) AS CurrentMonthSales,
	LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
FROM Sales.Orders
GROUP BY
	MONTH(OrderDate);