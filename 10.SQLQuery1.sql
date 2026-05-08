-- NULL FUNCTIONS

-- Find the average scores of the customers
SELECT
CustomerID,
Score,
COALESCE(Score, 0) Score2,
AVG(Score) OVER() AvgScores,
AVG(COALESCE(Score,0)) OVER() AvgScores2
FROM Sales.Customers;

-- Display the full name of customers in a single field
SELECT
*
FROM Sales.Customers;

SELECT
CONCAT(FirstName,' ',LastName) AS name1,
CONCAT(COALESCE(FirstName,'Unknown'),' ',COALESCE(LastName,'Unknown')) AS name2,
score,
score + 10 AS score2,
COALESCE(score,0) + 10 AS score3
FROM Sales.Customers;

-- Sort the customers from lowest to highest scores,
-- with nulls appearing last

SELECT
CustomerID,
Score,
--ISNULL(Score,999999),
CASE WHEN Score IS NULL THEN 1 ELSE 0 END Flag
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score

-- Find the sales price for each order by dividing sales by quantity
SELECT
Sales / NULLIF(Quantity,0) AS price
FROM Sales.Orders;



