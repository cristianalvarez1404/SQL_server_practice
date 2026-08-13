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