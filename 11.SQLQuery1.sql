-- Case statement
SELECT
Category,
SUM(Sales) AS TotalSales
FROM(
SELECT
OrderId,
Sales,
CASE
	WHEN Sales > 50 THEN 'High'
	WHEN Sales > 20 THEN 'Medium'
	ELSE 'Low'
END AS Category
FROM Sales.Orders
)t
GROUP BY Category
ORDER BY TotalSales DESC
;

-- Retrive employee details with gender displayed as full text
SELECT
EmployeeID,
FirstName,
LastName,
Gender,
CASE
	WHEN Gender = 'F' THEN 'Female'
	WHEN Gender = 'M' THEN 'Male'
	ELSE 'Not available'
END AS GenderFullText
FROM Sales.Employees;

-- Retrive customers details with abbreviated country code
SELECT
	CustomerID,
	FirstName,
	LastName,
	Country,
	CASE
		WHEN Country = 'USA' THEN 'US'
		WHEN Country = 'Germany' THEN 'DE'
		ELSE 'n/a'
	END AS Country_abbrevation
FROM Sales.Customers;