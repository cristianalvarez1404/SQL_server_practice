
-- Retrive all customers from Germany
SELECT * FROM customers
WHERE country = 'Germany';

-- Retrive all customers not from Germany
SELECT * FROM customers
WHERE country != 'Germany';

-- Retrive all customers with a score greater than 500
SELECT * FROM customers
WHERE score > 500;

-- Retrive all customers with a score of 500 or more
SELECT * FROM customers
WHERE score >= 500;

-- Retrive all customers with score less than 500 or more
SELECT * FROM customers
WHERE score < 500;

-- Retrive all customers with score less than or equal 500 or more
SELECT * FROM customers
WHERE score <= 500;

/*2:17*/



