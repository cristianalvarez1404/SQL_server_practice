-- NULL FUNCTIONS

-- Find the average scores of the customers
SELECT
CustomerID,
Score,
COALESCE(Score, 0) Score2,
AVG(Score) OVER() AvgScores,
AVG(COALESCE(Score,0)) OVER() AvgScores2
FROM Sales.Customers;