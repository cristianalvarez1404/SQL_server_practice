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

-- Multiple queries
CREATE PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA'
AS
BEGIN
  SELECT
    COUNT(*) AS TotalCustomers,
    AVG(Score) AS AvgScore
  FROM Sales.Customers
  WHERE Country = @Country;
  
  -- Find the total Nr. of Orders and Total Sales
  SELECT
    COUNT(OrderID) AS TotalOrders,
    SUM(Sales) AS TotalSales
  FROM Sales.Orders AS o
  JOIN Sales.Customers AS c
  ON c.CustomerID = o.CustomerID
  WHERE c.Country = @Country;
END

EXEC GetCustomerSummary;

-- Stored procedure => Variables
-- We use TSQL print for messages
ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA'
AS
BEGIN
  DECLARE @TotalCustomers INT, @AvgScore FLOAT;
  SELECT
    @TotalCustomers = COUNT(*),
    @AvgScore = AVG(Score)
  FROM Sales.Customers
  WHERE Country = @Country;
  
  PRINT 'Total Customers from ' + @Country + ' : ' + CAST(@TotalCustomers AS NVARCHAR);
  PRINT 'Average Score from ' + @Country + ' : ' + CAST(@AvgScore AS NVARCHAR);

  -- Find the total Nr. of Orders and Total Sales
  SELECT
    COUNT(OrderID) AS TotalOrders,
    SUM(Sales) AS TotalSales
  FROM Sales.Orders AS o
  JOIN Sales.Customers AS c
  ON c.CustomerID = o.CustomerID
  WHERE c.Country = @Country;
END
GO
EXEC GetCustomerSummary;


-- Stored procedure => Variables, IF-ELSE
-- We use TSQL print for messages 
ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA'
AS
BEGIN
  BEGIN TRY
    DECLARE @TotalCustomers INT, @AvgScore FLOAT;
    -- Prepare & Cleanup Data
    --SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = 'USA'
    IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
    BEGIN
      PRINT('Updating NULL Scores to 0');
      UPDATE Sales.Customers
      SET Score = 0
      WHERE Score IS NULL AND Country = @Country;
    END

    ELSE
    BEGIN
      PRINT('No NULL Scores found');
    END;
    -- Generating Reports
    SELECT
      @TotalCustomers = COUNT(*),
      @AvgScore = AVG(Score)
    FROM Sales.Customers
    WHERE Country = @Country;
    
    PRINT 'Total Customers from ' + @Country + ' : ' + CAST(@TotalCustomers AS NVARCHAR);
    PRINT 'Average Score from ' + @Country + ' : ' + CAST(@AvgScore AS NVARCHAR);

    -- Find the total Nr. of Orders and Total Sales
    SELECT
      COUNT(OrderID) AS TotalOrders,
      SUM(Sales) AS TotalSales,
      1/10
    FROM Sales.Orders AS o
    JOIN Sales.Customers AS c
    ON c.CustomerID = o.CustomerID
    WHERE c.Country = @Country;
  END TRY
  BEGIN CATCH
    PRINT('An error occured.');
    PRINT('Error Message: ' + ERROR_MESSAGE());
    PRINT('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
    PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
    PRINT('Error Procedure ' + ERROR_PROCEDURE());
  END CATCH
END
GO
EXEC GetCustomerSummary;
