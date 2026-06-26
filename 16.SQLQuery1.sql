-- Subqueries
SELECT
*
FROM INFORMATION_SCHEMA.COLUMNS;

SELECT
DISTINCT TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS;


--- Result tyes ---
-- Scalar query => Single value
SELECT
AVG(Sales)
FROM Sales.Orders

-- Row subquery => Multiple rows, single column
SELECT
CustomerID
FROM Sales.Orders

--Table subquery => Multiple rows and multiple columns
SELECT
OrderID,
OrderDate
FROM Sales.Orders

-- Find the products that have a price higher than the average price of all products.

SELECT
*
FROM
(
	SELECT
		ProductID,
		Price,
		AVG(Price) OVER() AVGPrice
	FROM Sales.Products
) t WHERE Price > AVGPrice




