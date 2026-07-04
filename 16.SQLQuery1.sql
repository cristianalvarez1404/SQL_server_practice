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

-- Rank customers based on their total amount of sales

SELECT
	DENSE_RANK() OVER(ORDER BY total_sales DESC) AS rank_customers,
	*
FROM (
SELECT
	CustomerID,
	Sales,
	SUM(Sales) OVER(PARTITION BY CustomerID) AS total_sales
FROM Sales.Orders
) t ;

SELECT
*,
RANK() OVER(ORDER BY TotalSales) CustomerRank
FROM
(
SELECT
	CustomerID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY CustomerID) t;

-- SELECT CLAUSE

-- Show the product IDs, names, prices and total number of orders.

SELECT 
	ProductID,
	Product,
	Price,
	(SELECT COUNT(*) FROM Sales.Orders) AS total_orders
FROM Sales.Products;

-- Join clause

-- Show all customer details and find the total orders of each customer
SELECT
c.*,
o.totalOrders
FROM Sales.Customers AS c
LEFT JOIN (
SELECT
	CustomerID,
	COUNT(*) AS totalOrders
	FROM Sales.Orders GROUP BY CustomerID
) AS o 
ON c.CustomerID = o.CustomerID

-- Find the products that have a price higher than the average price of all products
SELECT
ProductID,
Price,
(SELECT AVG(Price) FROM Sales.Products) AS AvgPrice
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products)

-- Show the datails of orders made by customers in Germany
SELECT
*
FROM Sales.Orders
WHERE CustomerID IN 
					(SELECT 
						CustomerID 
						FROM Sales.Customers 
						WHERE Country = 'Germany'
					);

-- Find female employees whose salaries are greater than the salaries of any male employees
SELECT
*
FROM Sales.Employees
WHERE Gender = 'F' AND 
Salary > ANY (
	SELECT
		Salary
		FROM Sales.Employees
	WHERE Gender = 'M'
)


/*Correlated subqueries(Dependet MANY QUERY and EXECUTE FOR EACH ROW) => IMPORTANT! */
-- Show all customer details and find the total orders of each customer
SELECT
	*,
	(SELECT COUNT(*) FROM Sales.Orders AS o WHERE o.CustomerID = c.CustomerID) TotalSales
FROM Sales.Customers c;

-- Show the details of orders made by customers in Germany
SELECT
*
FROM Sales.Orders AS o
WHERE EXISTS(SELECT 1
				FROM Sales.Customers AS c
				WHERE Country = 'Germany'
				AND o.CustomerID = c.CustomerID);

/*No Correlated subqueries(Independet MANY QUERY and EXECUTE ONCE and result is used by the main query) => IMPORTANT! */

-- Show the details of orders made by customers not in Germany
SELECT
*
FROM Sales.Orders
WHERE CustomerID NOT IN (SELECT
						CustomerID
						FROM Sales.Customers
						WHERE Country = 'Germany');










