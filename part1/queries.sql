USE northwind;
SHOW CREATE TABLE customers;

SHOW CREATE TABLE orders;



-- TASK 1: 
SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'northwind' AND REFERENCED_TABLE_NAME IS NOT NULL;


  
 -- TASK 2
-- a. 
SELECT id, company, country_region FROM customers WHERE country_region IN ('USA','Germany','France');

-- b. 
SELECT id, company, country_region FROM customers WHERE country_region NOT IN ('USA','Germany','France');

-- c. 
SELECT id, customer_id, order_date FROM orders WHERE order_date BETWEEN '2006-01-01' AND '2006-12-31';

-- d. 
SELECT id, customer_id, order_date, shipping_fee FROM orders ORDER BY customer_id ASC, shipping_fee DESC;

-- e. 
SELECT c.id, c.company FROM customers c WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);

-- f. 
SELECT id, company FROM customers WHERE company LIKE '%Company%';



-- TASK 3
SELECT customer_id, COUNT(id) AS order_count, AVG(shipping_fee) AS avg_shipping_fee
FROM orders
GROUP BY customer_id
HAVING COUNT(id) > 2;



-- TASK 4
-- a: INNER JOIN
SELECT c.id, c.company, o.id AS order_id, o.order_date, o.shipping_fee
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id;

-- b: 
SELECT c.id, c.company, o.id AS order_id, o.order_date, o.shipping_fee
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id;



-- TASK 5
-- a: COUNT DISTINCT sanity check
SELECT COUNT(DISTINCT customer_id) AS distinct_customers_with_orders FROM orders;

-- b: grouped child-count
SELECT customer_id, COUNT(*) AS order_count FROM orders GROUP BY customer_id ORDER BY order_count DESC;

-- c: orphan check
SELECT o.id, o.customer_id FROM orders o
LEFT JOIN customers c ON o.customer_id = c.id
WHERE c.id IS NULL;