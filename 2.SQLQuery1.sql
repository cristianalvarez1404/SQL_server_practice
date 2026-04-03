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

