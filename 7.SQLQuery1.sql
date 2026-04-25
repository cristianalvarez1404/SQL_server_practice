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
SELECT 
	first_name,
	LEN(first_name) AS len_name,
	LEN(TRIM(first_name)) AS len_trim,
	LEN(first_name) - LEN(TRIM(first_name)) AS flag
FROM customers
WHERE first_name <> TRIM(first_name);

-- Remove dashes (-) from a phone number
SELECT
'123-456-7890' AS phone,
REPLACE('123-456-7890','-','/') AS clean_phone

-- Replace file extence from txt to csv
SELECT
'report.txt' AS old_filename, 
REPLACE('report.txt','.txt','.csv') AS new_filename

-- Calculate the length of each customer's first name.
SELECT
	first_name,
	LEN(first_name) AS len_name
FROM customers

-- Retrieve the first two characters of each first name.
SELECT
	first_name,
	LEFT(TRIM(first_name), 2) AS first_2_char,
	RIGHT(TRIM(first_name), 2) AS first_3_char
FROM customers;

-- Retrieve a list of customers' first names after removing the first character.

SELECT
	first_name,
	SUBSTRING(TRIM(first_name),2,LEN(first_name)) AS first_name_2
FROM customers;

/* NUM FUNCTIONS */

SELECT
	3.516,
	ROUND(3.516,2) AS round_2,
	ROUND(3.516,1) AS round_1,
	ROUND(3.516,0) AS round_0

SELECT
	-10,
	ABS(-10),
	ABS(10);








