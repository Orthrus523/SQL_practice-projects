CREATE TABLE employer (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    salary NUMERIC
);

INSERT INTO employer (name, salary)
VALUES ('A', 50000), ('B', 60000);

INSERT INTO employer (emp_id, name)
VALUES (1, 'C');  --tried to violate -> ERROR:  duplicate key value violates unique constraint "employer_pkey"

INSERT INTO employer (emp_id, name)
VALUES (NULL, 'D'); --tried violating not null constraint

select * from employer

CREATE TABLE emp_transactions (
    customer_id INT,
    txn_id INT,
    amount NUMERIC,
    PRIMARY KEY (customer_id, txn_id)  --now this makes together must be unique!!
);
INSERT INTO emp_transactions VALUES
(1, 101, 500),
(1, 102, 300),
(2, 101, 700);


INSERT INTO emp_transactions VALUES (1, 101, 800); --violating now!!

ALTER TABLE employer
ADD CONSTRAINT employer_pk PRIMARY KEY (name,salary);  --tried adding constraint after creating table

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE  --tried for unique
);

INSERT INTO users (email) VALUES ('a@gmail.com');
INSERT INTO users (email) VALUES ('a@gmail.com');  --violated as duplicate key value violates unique constraint "users_email_key"

INSERT INTO users (email) VALUES (NULL);
INSERT INTO users (email) VALUES (NULL);  --nulls are allowed

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_amount NUMERIC NOT NULL CHECK (order_amount > 0), --here i made amount is mandatory to enter that ll be in postive using check >0
    order_status VARCHAR(20) CHECK (order_status IN ('NEW','SHIPPED','CANCELLED')), --checks status are must from the mentioned
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id --using fk i mapped customers table cust_id to this order
);   
select * from customers

INSERT INTO orders (customer_id, order_amount, order_status)
VALUES (1, 5000, 'NEW');

INSERT INTO orders (customer_id, order_amount, order_status)
VALUES (2, 12000, 'SHIPPED');

INSERT INTO orders (customer_id, order_amount, order_status)
VALUES (3, 3000, 'CANCELLED');

select * from orders

INSERT INTO orders (customer_id, order_amount, order_status)
VALUES (99, 4000, 'NEW');  --violated ..as cust id doesn exist in customers

FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
ON DELETE CASCADE;


