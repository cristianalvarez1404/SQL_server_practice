-- STEP 1: Write a Query
-- For US customers find the total number of customers and the average score

SELECT
  COUNT(*) AS TotalCustomers,
  AVG(Score) AS AvgScore
FROM Sales.Customers
WHERE Country = 'USA';


-- For German Customers find the total number of customers and the average score
CREATE PROCEDURE GetCustomerSummaryGermany AS
BEGIN
  SELECT
    COUNT(*) AS TotalCustomers,
    AVG(Score) AS AvgScore
  FROM Sales.Customers
  WHERE Country = 'Germany'; 
END

EXEC GetCustomerSummaryGermany;


-- STEP 2: Turning the Query Into a Stored Procedure

CREATE PROCEDURE GetCustomerSummary @Country NVARCHAR(50) AS
BEGIN
  SELECT
    COUNT(*) AS TotalCustomers,
    AVG(Score) AS AvgScore
  FROM Sales.Customers
  WHERE Country = @Country;
END

-- STEP 3: Execute the Stored Procedure
EXEC GetCustomerSummary @Country = 'USA';
EXEC GetCustomerSummary @Country = 'GERMANY';

DROP PRODUCEDURE GetCustomerSummaryGermany

-- Default Parameters
ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS
BEGIN
  SELECT
    COUNT(*) AS TotalCustomers,
    AVG(Score) AS AvgScore
  FROM Sales.Customers
  WHERE Country = @Country;
END

EXEC GetCustomerSummary;