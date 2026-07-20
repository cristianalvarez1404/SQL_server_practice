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
FROM V_Monthly_Summary;

DROP VIEW V_Monthly_Summary;

---------------------------------------------------------
IF OBJECT_ID('Sales.V_Monthly_Summary', 'V') IS NOT NULL
	DROP VIEW Sales.V_Monthly_Summary;
GO

CREATE VIEW Sales.V_Montly_Summary AS
(
	SELECT
	DATETRUNC(month, OrderDate) OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders
	FROM Sales.Orders
	GROUP BY DATETRUNC(month, OrderDate)
)

-- Provide a view that combines details from orders, products, customers, and employees.
CREATE VIEW V_order_Details AS 
(
	SELECT 
		o.OrderID,
		o.OrderDate,
		p.Product,
		p.Category,
		COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName,'') AS CustomerName,
		c.Country AS CustomerCountry,
		COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName,'') AS SalesName,
		e.Department,
		o.Sales,
		o.Quantity
	FROM Sales.Orders AS o
	LEFT JOIN Sales.Products AS p
	ON o.ProductID = p.ProductID
	LEFT JOIN Sales.Customers AS c
	ON o.CustomerID = c.CustomerID
	LEFT JOIN Sales.Employees AS e
	ON o.SalesPersonID = e.EmployeeID
);

SELECT * FROM V_order_Details;

-- Provide a view for EU Sales Team
-- That combines details from All tables
-- And Excludes Data related to the USA

CREATE VIEW Sales.V_Order_Details_EU AS 
(
	SELECT 
		o.OrderID,
		o.OrderDate,
		p.Product,
		p.Category,
		COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName,'') AS CustomerName,
		c.Country AS CustomerCountry,
		COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName,'') AS SalesName,
		e.Department,
		o.Sales,
		o.Quantity
	FROM Sales.Orders AS o
	LEFT JOIN Sales.Products AS p
	ON o.ProductID = p.ProductID
	LEFT JOIN Sales.Customers AS c
	ON o.CustomerID = c.CustomerID
	LEFT JOIN Sales.Employees AS e
	ON o.SalesPersonID = e.EmployeeID
	WHERE c.Country <> 'USA'
);

SELECT * FROM Sales.V_Order_Details_EU;




