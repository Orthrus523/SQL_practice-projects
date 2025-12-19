select 
case
when 8>10 then 'true'
else 'false'
end as test  -- case when here by hard coding shows table as test with false coz 8 is smaller

SELECT *,
CASE
 WHEN quantity * price >= 50000 THEN 'HIGH_VALUE'
ELSE 'LOW_VALUE'
 END AS sale_type
FROM sales;

SELECT *,
CASE WHEN product IN ('Mouse','Keyboard','Headset') THEN 'ACCESSORY'  --we can seggregate with in also and or for multiple commparison
ELSE 'MAIN_PRODUCT'
END AS product_type
FROM sales;


--trying advanced with label and aggregatiion using when
SELECT 
    CASE
        WHEN quantity * price >= 60000 THEN 'HIGH'
        WHEN quantity * price >= 10000 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS revenue_category,
    COUNT(*) AS sales_count,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY revenue_category
ORDER BY total_revenue DESC;


--Now null handling!!
--def-?The COALESCE() function accepts multiple arguments and returns the first argument that is not null. 
--If all arguments are null, the COALESCE() function will return null.

SELECT COALESCE (1, 2);  --returns 1 

SELECT COALESCE (NULL, 2 , 1);  --returns 2 coz the first argument is NULL and the second argument is non-null so the func returns the second argument


CREATE TABLE items (  --lets create a dummy table and handle null
  id SERIAL PRIMARY KEY,
  product VARCHAR (100) NOT NULL,
  price NUMERIC NOT NULL,
  discount NUMERIC
);

INSERT INTO items (product, price, discount)
VALUES
  ('A', 1000, 10),
  ('B', 1500, 20),
  ('C', 800, 5),
  ('D', 500, NULL);

SELECT
product,
  (price - discount) AS net_price  --here D returns null because it involves NULL in the calculation.
FROM
  items;

SELECT
  product,
  (
    price - COALESCE(discount, 0)  --so here am using the coalesce to set the as 0 in opertaion
  ) AS net_price
FROM
  items;
-- we can also use case-when here

SELECT product,
(price - CASE WHEN discount IS NULL THEN 0 ELSE discount END) AS net_price --see ez?
FROM items;
--lessgo for String handling.

CREATE TABLE india_sales_raw (   --took a dummy table from internet to handle all  String handlings in topic wise
    txn_id SERIAL PRIMARY KEY,
    customer_name TEXT,
    phone TEXT,
    email TEXT,
    city TEXT,
    state TEXT,
    product TEXT,
    quantity INT,
    unit_price NUMERIC,
    payment_mode TEXT,
    order_status TEXT,
    order_date DATE
);



INSERT INTO india_sales_raw
(customer_name, phone, email, city, state, product, quantity, unit_price, payment_mode, order_status, order_date)
VALUES
('  Ramesh kumar ', '9876543210', 'RAMESH.K@GMAIL.COM ', 'chennai ', 'Tamil Nadu', 'wireless mouse', 2, 599, 'upi', 'delivered', '2025-01-02'),

('Anita  SHARMA', ' 9123456789', 'anita.sharma@yahoo.com', 'Bengaluru', 'Karnataka', 'Laptop - Dell', 1, 62000, 'Credit Card', 'DELIVERED', '2025-01-03'),

('mohammed ali', NULL, 'm.ali@outlook.com', ' Hyderabad', 'Telangana', 'Bluetooth Headset', 1, 2499, 'COD', 'returned', '2025-01-04'),

('Suresh', '9988776655', NULL, 'Madurai', 'Tamil Nadu', 'USB-C Cable', 3, 399, 'upi', 'Delivered', '2025-01-05'),

('PRIYA IYER', '9876501234', 'priya.iyer@gmail.com', 'Chennai', 'Tamil Nadu', 'Laptop - HP', 1, 58000, 'Net Banking', 'cancelled', '2025-01-05'),

('Rahul verma', '9876543210', 'rahul.verma@gmail.com', ' Delhi', 'Delhi', 'Wireless Mouse', 1, 699, 'UPI', 'delivered', '2025-01-06'),

('  ramesh kumar', '9876543210', 'ramesh.k@gmail.com', 'Chennai', 'Tamil Nadu', 'Keyboard', 1, 1299, 'upi', 'Delivered', '2025-01-07'),

('Neha Singh', '9000011111', 'neha.singh@gmail.com', 'Noida', 'Uttar Pradesh', 'Laptop Stand', 1, 1899, 'Credit Card', 'delivered', '2025-01-07'),

('Arjun reddy', NULL, 'arjun.reddy@gmail.com', 'Vijayawada', 'Andhra Pradesh', 'Wireless Earbuds', 1, 3499, 'upi', 'delivered', '2025-01-08'),

('Kavitha R', '9887766554', ' kavitha.r@gmail.com ', ' Coimbatore', 'Tamil Nadu', 'Laptop - Lenovo', 1, 61000, 'EMI', 'Delivered', '2025-01-08');

SELECT
    TRIM(LOWER(customer_name)) AS clean_name,  --so basically v tried func inside a fun lowering the cust names and trimed them
    TRIM(LOWER(city)) AS clean_city,
    UPPER(state) AS state_std  --v made all uppr
FROM india_sales_raw;

SELECT
    customer_name,
    COALESCE(phone, 'NO_PHONE') AS phone_filled  --we handled null here to mention  no phn in the data
FROM india_sales_raw;

SELECT email, LENGTH(email) AS email_length
FROM india_sales_raw;  --shows length of email

SELECT SUBSTRING(email FROM 1 FOR 5)  --filter first five letters as a sub STring 
FROM india_sales_raw;

SELECT SPLIT_PART(email, '@', 1) AS username  --we spliting into hald @ bfr n aftr giving one shows nithi 2 shows gmail.com
FROM india_sales_raw;

SELECT
    email,
    SPLIT_PART(TRIM(LOWER(email)), '@', 2) AS email_domain  --
FROM india_sales_raw;

SELECT customer_id || '-' || product AS customer_product  -- || this is postgres way additional
FROM sales;

SELECT CONCAT(customer_id, '-', product)  --common
FROM sales;

SELECT REPLACE(product, ' ', '_')
FROM india_sales_raw;  --wireless_mouse  

SELECT * FROM india_sales_raw
WHERE email LIKE '%@gmail.com';  --shows record of whomevr using gmail excludes yahoo n outlook

SELECT * FROM sales
WHERE product ILIKE 'lap%';  --this shows lap irrespective of casesensitive

SELECT POSITION('@' IN email)
FROM india_sales_raw;  --shows the position no of @ in there emails 

SELECT RPAD(city, 10, '^')  --chennai is7 letters remaming 3 filled with ^^^
FROM india_sales_raw;







