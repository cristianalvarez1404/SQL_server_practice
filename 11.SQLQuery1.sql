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
	END AS CountryAbbr,
	CASE Country
		WHEN 'USA' THEN 'US'
		WHEN 'Germany' THEN 'DE'
		ELSE 'n/a'
	END AS CountryAbbr2
FROM Sales.Customers;

-- Find the average scores of customers and treat NULLS as 0
-- Additionally provide details such CustomerID and LastName
SELECT
CustomerID,
LastName,
Score,
CASE
	WHEN Score IS NULL THEN 0
	ELSE Score
END AS ScoreClean,

AVG(
	CASE
		WHEN Score IS NULL THEN 0
		ELSE Score
	END) OVER() AS AvgCustomerClean,
AVG(Score) OVER() AS AvgCustomer
FROM Sales.Customers;

-- Count how many times each customer has made an order with sales greater than 30
SELECT
	CustomerID,
--	OrderID,
	--Sales,
	SUM(CASE
		WHEN Sales > 30 THEN 1
		ELSE 0
	END) AS TotalOrdersHightSales,
	COUNT(*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID
--ORDER BY CustomerID


