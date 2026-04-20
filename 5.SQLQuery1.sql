/*
Retrieve a list of all orders, along with
the related customer, product, and employee details.
*/
USE SalesDB;

SELECT 
	o.OrderID,
	o.Sales,
	c.FirstName AS customer_first_name,
	c.LastName AS customer_last_name,
	p.Product AS Product_name,
	p.Price,
	e.FirstName AS employee_first_name,
	e.LastName AS employee_last_name
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID 




