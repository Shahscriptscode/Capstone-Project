# Part 1 – SQL Extraction, Cleaning & Outlier Audit

## Project Overview

This project focuses on extracting, cleaning, and validating data from the Northwind database. SQL queries were written and executed in MySQL Workbench to retrieve and analyze data from the `customers` and `orders` tables. The extracted data was then exported to a CSV file and cleaned in Google Colab using Python. Finally, an outlier audit was performed using two statistical methods.

---

# Dataset

**Database:** Northwind

**Tables Used:**
- customers
- orders

The two tables are related through the `customer_id` field, which allows customer information to be linked with their corresponding orders.

---

# Tools Used

- MySQL Workbench
- Google Colab
- Python
- Pandas
- NumPy

---

# Task 1 – Verify Database Structure

The database structure was examined to confirm the relationship between the `customers` and `orders` tables.

Activities completed:

- Verified the primary key of the `customers` table.
- Verified the foreign key in the `orders` table.
- Confirmed the one-to-many relationship between customers and orders using `SHOW CREATE TABLE` and the `INFORMATION_SCHEMA.KEY_COLUMN_USAGE` table.

---

# Task 2 – SQL Query Practice

The following SQL queries were completed:

- Used `WHERE IN` to retrieve customers from selected countries.
- Used `WHERE NOT IN` to retrieve customers outside the selected countries.
- Used `BETWEEN` to filter orders within a date range.
- Used `ORDER BY` to sort orders by customer and shipping fee.
- Used a `NOT EXISTS` subquery to find customers who have not placed any orders.
- Used `LIKE` with wildcard characters to search customer names.

---

# Task 3 – GROUP BY and HAVING

Aggregate functions were used to summarize order information.

The query included:

- `COUNT()`
- `AVG()`
- `GROUP BY`
- `HAVING`

This was used to identify customers with multiple orders and calculate their average shipping fee.

---

# Task 4 – Table Joins

Two join operations were performed.

### INNER JOIN

Combined customer and order information for customers who have placed orders.

### LEFT JOIN

Displayed all customers, including those who have not placed any orders.

---

# Task 5 – Referential Integrity Check

The following checks were completed to verify data consistency.

- Counted the number of distinct customers with orders.
- Counted the total number of orders for each customer.
- Checked for orphan records (orders without a matching customer).

The orphan check returned **0 records**, confirming that referential integrity was maintained.

---

# Task 6 – Data Export

The joined SQL results were exported as:

**orders_export.csv**

This file was then used for the data-cleaning stage in Google Colab.

---

# Task 7 – Data Cleaning

The exported CSV file was cleaned using Pandas.

The following steps were completed:

- Loaded the dataset into a DataFrame.
- Checked for missing values.
- Filled missing values in the `shipping_fee` column using the median.
- Filled missing values in the `company` column using the mode.
- Removed duplicate rows.
- Verified the cleaned dataset before analysis.

---

# Task 8 – Outlier Audit

Outlier detection was performed on the `shipping_fee` column using two statistical methods.

### IQR (Interquartile Range)

- **Outliers Detected:** 6

### Z-score Method

- **Outliers Detected:** 2

The IQR method detected more outliers than the Z-score method because it is more sensitive to observations outside the interquartile range. The Z-score method only identifies values that are several standard deviations away from the mean. Comparing both methods provided a better understanding of the distribution of the shipping fee values.

---

# Files Included

```
Part1_SQL/
│
├── queries.sql
├── orders_export.csv
├── part1_cleaning.ipynb
└── README.md
```

---

# How to Run

1. Open MySQL Workbench.
2. Connect to the Northwind database.
3. Execute all SQL queries in `queries.sql`.
4. Export the joined dataset as `orders_export.csv`.
5. Open `part1_cleaning.ipynb` in Google Colab.
6. Upload the exported CSV file.
7. Run all notebook cells from top to bottom.

---

# Conclusion

This project demonstrates the complete workflow of extracting relational data using SQL, validating relationships between tables, exporting data for analysis, cleaning the dataset using Python, and detecting outliers using statistical methods. The cleaned dataset provides a reliable foundation for further analysis in Part 2.