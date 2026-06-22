-- Analize the month-over-month performance by finding the percentage change
-- In sales between the current and previous months
SELECT
*,
CurrentMonthSales - PreviousMonthSales AS MoM_Change,
ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT) / PreviousMonthSales * 100, 1) AS MoM_Perc 
FROM (
SELECT
	--OrderID,
	--OrderDate,
	MONTH(OrderDate) AS OrderMonth,
	SUM(Sales) AS CurrentMonthSales,
	LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
FROM Sales.Orders
GROUP BY
	MONTH(OrderDate)
)t;


-- In order to analyze customer loyalty,
-- rank customers based on the average days between their orders
SELECT
CustomerID,
AVG(DaysUntilNextOrder) AS AvgDays,
RANK() OVER(ORDER BY COALESCE(AVG(DaysUntilNextOrder),999999)) AS RankAvg
FROM(
	SELECT
		OrderID,
		CustomerID,
		OrderDate AS CurrentOrder,
		LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrder,
		DATEDIFF(DAY,OrderDate,(LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate))) AS DaysUntilNextOrder 
	FROM Sales.Orders
) t
GROUP BY CustomerID;

-- Find the lowest and highest sales for each product
-- Find the difference in sales between the current and the lowest sales

SELECT
*
FROM (
SELECT
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS LowestSales,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales
	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS HighestSales,
	Sales - FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS SalesDiffence
	--FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS HighestSales2,
	--MIN(Sales) OVER(PARTITION BY ProductID) AS LowestSales,
	--MAX(Sales) OVER(PARTITION BY ProductID) AS HighestSales3
FROM Sales.Orders
) t;













