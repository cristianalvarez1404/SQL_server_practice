-- Ranking windows function

-- Rank the orders based on their sales from highest to lowest
SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row,
	RANK()		 OVER(ORDER BY Sales DESC) AS SalesRank_Rank,
	DENSE_RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Dense
FROM Sales.orders;

-- Find the top highest sales for each product
SELECT
*
FROM
(SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) SalesRank
FROM Sales.Orders
) t WHERE SalesRank = 1;


