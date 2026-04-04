--DDL => Data definition lenguage (create, alter,drop)

/* Create a new table called persons with columns: id, person_name, birth_date, and phone
*/

CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id)
);

SELECT * FROM persons;

ALTER TABLE persons 
ADD email VARCHAR(50) NOT NULL;

ALTER TABLE persons
DROP COLUMN phone;

DROP TABLE persons;

-- DML => Data manipulation lenguage (insert,update,delete)

INSERT INTO customers (id, first_name,country,score)
VALUES 
	(6, 'Anna', 'USA', NULL),
	(7, 'Sam', NULL, 100);
SELECT * FROM customers;

INSERT INTO customers
VALUES 
	(8, 'Max','USA',NULL);

INSERT INTO customers
VALUES 
	(9, 'Andreas','Germany',NULL);

-- Insert using select
-- Insert data from 'customers' into 'persons'

INSERT INTO persons (id,person_name,birth_date,phone)
	SELECT
		id,
		first_name,
		NULL,
		'Unknown'
	FROM customers;

SELECT * FROM persons;

-- Change the score of customer with ID 6 to 0
SELECT * FROM customers;
UPDATE customers 
	SET score = 0 
	WHERE id = 6;

-- Change the score of customer with ID 10 to 0 and update the country to UK

INSERT INTO customers
VALUES (
	10,
	'Sahra',
	NULL,
	NULL
);

UPDATE customers 
SET score = 0, country = 'UK' 
WHERE id = 10;

SELECT * FROM customers;

-- Update all coustomers with a NULL score by setting their score to 0
UPDATE customers
SET score = 0
WHERE score IS NULL;

SELECT * FROM customers;

-- Delete all customers with an ID greater than 5
SELECT * FROM customers WHERE id > 5;

DELETE FROM customers 
WHERE id > 5;

-- Delete all data from the persons table
SELECT * FROM persons;
DELETE FROM persons;
TRUNCATE TABLE persons;







