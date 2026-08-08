PART 1 — NORTHWIND SQL ANALYSIS

TASK 2: SQL FILTERING QUERIES

Task 2(a): WHERE + IN
SELECT OrderID, CustomerID, OrderDate, ShipCountry
FROM "Orders"
WHERE ShipCountry IN ('Germany', 'France', 'UK')
LIMIT 20;

Task 2(b): WHERE + NOT IN
SELECT OrderID, CustomerID, OrderDate, ShipCountry
FROM "Orders"
WHERE ShipCountry NOT IN ('Germany', 'France', 'UK')
LIMIT 20;

Task 2(c): BETWEEN
SELECT OrderID, CustomerID, OrderDate, ShipCountry
FROM "Orders"
WHERE OrderDate BETWEEN '2016-07-01' AND '2016-12-31'
ORDER BY OrderDate;

Task 2(d): ORDER BY
SELECT OrderID, CustomerID, ShipCountry, Freight
FROM "Orders"
ORDER BY ShipCountry ASC, Freight DESC
LIMIT 20;

Task 2(e): NOT EXISTS
SELECT c.CustomerID, c.CompanyName, c.Country
FROM "Customers" AS c
WHERE NOT EXISTS (
SELECT 1
FROM "Orders" AS o
WHERE o.CustomerID = c.CustomerID
);

Task 2(f): LIKE
SELECT CustomerID, CompanyName, Country
FROM "Customers"
WHERE CompanyName LIKE '%a%'
LIMIT 20;


TASK 3: GROUP BY + HAVING
SELECT
CustomerID,
COUNT(*) AS order_count,
SUM(Freight) AS total_freight
FROM "Orders"
GROUP BY CustomerID
HAVING COUNT(*) > 10
ORDER BY order_count DESC;


TASK 4: JOINS

Task 4(a): INNER JOIN

SELECT
o.OrderID,
o.CustomerID,
o.OrderDate,
od.ProductID,
od.UnitPrice,
od.Quantity,
od.Discount
FROM "Orders" AS o
INNER JOIN "Order Details" AS od
ON o.OrderID = od.OrderID;

Task 4(b): LEFT JOIN
SELECT
o.OrderID,
o.CustomerID,
o.OrderDate,
od.ProductID,
od.UnitPrice,
od.Quantity,
od.Discount
FROM "Orders" AS o
LEFT JOIN "Order Details" AS od
ON o.OrderID = od.OrderID
LIMIT 20;


TASK 5: REFERENTIAL-INTEGRITY CHECKS

Task 5(a)
SELECT COUNT(DISTINCT o.OrderID) AS distinct_orders
FROM "Orders" AS o
JOIN "Order Details" AS od
ON o.OrderID = od.OrderID;

Task 5(b)
SELECT
o.OrderID,
COUNT(od.OrderID) AS detail_count
FROM "Orders" AS o
LEFT JOIN "Order Details" AS od
ON o.OrderID = od.OrderID
GROUP BY o.OrderID
ORDER BY detail_count ASC
LIMIT 20;

Task 5(c)
SELECT
od.OrderID,
od.ProductID
FROM "Order Details" AS od
LEFT JOIN "Orders" AS o
ON od.OrderID = o.OrderID
WHERE o.OrderID IS NULL
LIMIT 20;


TASK 6: CSV EXPORT

Export query used for task4_join_export.csv

SELECT
o.OrderID,
o.CustomerID,
o.OrderDate,
od.ProductID,
od.UnitPrice,
od.Quantity,
od.Discount
FROM "Orders" AS o
INNER JOIN "Order Details" AS od
ON o.OrderID = od.OrderID;