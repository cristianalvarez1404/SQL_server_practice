-- Indexes
-- Data structure provide quick access to data, optimizing the speed of your queries.

--Indexes
  -- Structure => How organice data -- cluster and non-cluster index
  -- Storage => How the data is store -- Rowstore-Columnstore index
  -- Functions => Improve our performance -- Unique index, filtered index

-- HEAD => TABLES WITHOUT CLUSTERED INDEX

/* 
  CLUSTER INDEX => SQL GOING TO PHYSICALLY SORT ALL THE DATA BASED ON THE COLUMN ID
                => CREATE A B TREE TO QUICKLY LOCATE DATA
*/


CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers(CustomerID);

CREATE CLUSTERED INDEX idx_DBCustomers_FirstName ON Sales.DBCustomers(FirstName);

DROP INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers

CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName ON Sales.DBCustomers(LastName);

CREATE INDEX idx_DBCustomers_CountryScore ON Sales.DBCustomers(Country, Score);

/*
ROWSTORE INDEX => -ORGANIZES AND STORES DATA ROW BY ROW
                  -LESS EFFICENT IN STORAGE
                  -FAIR SPEED FOR READ AND WRITE
                  -LOWER => RETRIVE ALL COLUMNS
COLUMNSTORE INDEX =>  -ORGANIZES AND STORES DATA COLUMN BY COLUMN
                      -HIGHLY EFFICENT WITH COMPRESION
                      -FAST READ PERFORMANCE,SLOW WRITE PERFORMANCE
                      -HIGHER => RETRIVE SPECIFIC COLUMNS
*/

CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS ON Sales.DBCustomers

DROP INDEX idx_DBCustomers_CS ON Sales.DBCustomers

CREATE NONCLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS ON Sales.DBCustomers_CS_FirstName ON Sales.DBCustomers(FirstName)

/*-----------------------------------------------------------*/

USE AdventureWorksDW2022

-- HEAP
SELECT *
INTO FactInternetSales_HP
FROM FactInternetSales

-- RowStore
SELECT *
INTO FactInternetSales_RS
FROM FactInternetSales

CREATE CLUSTERED INDEX idx_FactInternetSales_RS_PK
ON FactInternetSales_RS (SalesOrderNumber, SalesOrderLineNumber)


-- ColumnStore
SELECT *
INTO FactInternetSales_CS
FROM FactInternetSales

CREATE CLUSTERED COLUMNSTORE INDEX idx_FactInternetSales_CS_PK
ON FactInternetSales_CS 

/*--------------------------------------------------------------*/
--UNIQUE INDEX => NOT DUPLICATES -> The table must be empty

SELECT * FROM Sales.Products

CREATE UNIQUE NONCLUSTERED INDEX idx_Products_Product
ON Sales.Products(Product)

INSERT INTO Sales.Products(ProductID, Product) VALUES (106, 'Caps')

/*-----------------------------------------------------------------*/
-- FILTER INDEX => WE JUST ADD A WHERE. IN WHERE WE SPECIFIED THE CONDITION.
  -- We cannot create a filter index on a clustered index
  -- We cannot create a filter index on a columstore index

SELECT * FROM Sales.customers
WHERE Country = 'USA'

CREATE NONCLUSTERED INDEX idx_Customers_Country 
ON Sales.Customers(Country)
WHERE Country = 'USA' -- FILTER INDEX




