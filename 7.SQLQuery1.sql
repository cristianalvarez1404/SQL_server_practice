-- Functions
--STRINGS

SELECT
	first_name,
	country,
	TRIM(CONCAT(first_name, ' ', country)) AS name_country,
	TRIM(LOWER(first_name)) AS low_name,
	TRIM(UPPER(first_name)) AS upper_name
FROM customers;

-- Find customers whose first name contains leading or trailing spaces
SELECT * 
FROM customers
WHERE first_name <> TRIM(first_name);




