USE retail_sales;
SELECT DATABASE();

CREATE TABLE customers (
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Region VARCHAR(50),
    City VARCHAR(50),
    Customer_Segment VARCHAR(30)
);

SHOW TABLES;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT *
FROM customers
LIMIT 10;

SELECT *
FROM customers
WHERE Customer_ID LIKE 'CUST90%';

SELECT
    s.Customer_ID,
    s.Customer_Name,
    c.Customer_Name
FROM sales_data s
INNER JOIN customers c
    ON s.Customer_ID = c.Customer_ID
LIMIT 10;
