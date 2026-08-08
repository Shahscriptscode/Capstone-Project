# Part 1 -- SQL Data Exploration, Data Cleaning & Outlier Analysis

## Project Overview

Part 1 uses the Northwind database for SQL data exploration,
relationship and integrity checks, CSV export, and Python/Pandas data
cleaning and outlier analysis.

## Tools Used

-   SQLite
-   SQL
-   Google Colab
-   Python
-   Pandas
-   NumPy

## Dataset

The SQL analysis used the `Orders` and `Order Details` tables.

The final joined dataset exported to `task4_join_export.csv` contains:

-   **Rows:** 609,283
-   **Columns:** 7

Columns:

``` text
OrderID
CustomerID
OrderDate
ProductID
UnitPrice
Quantity
Discount
```

# SQL Analysis

## Task 1 -- Database Setup, Schema & Relationships

The Northwind database was inspected to understand its tables, columns,
data types, primary keys and relationships.

Foreign-key metadata was checked and the relationship between `Orders`
and `Order Details` through `OrderID` was used for the join analysis.

Foreign-key enforcement was also tested. An invalid relationship attempt
returned a foreign-key constraint error, confirming that referential
integrity was being enforced.

## Task 2 -- SQL Filtering & Query Operations

The required SQL filtering and query operations were completed.

The analysis covered:

-   `WHERE`
-   `IN`
-   `NOT IN`
-   `BETWEEN`
-   `ORDER BY`
-   `LIKE`
-   `NOT EXISTS`

### Task 2(a) -- WHERE with IN

Orders were filtered for selected shipping countries: Germany, France
and UK.

### Task 2(b) -- NOT IN

A `NOT IN` filter was used to exclude the required values.

### Task 2(c) -- BETWEEN

A `BETWEEN` condition was used for the required range filtering.

### Task 2(d) -- ORDER BY

The required results were sorted using `ORDER BY`.

### Task 2(e) -- NOT EXISTS

A `NOT EXISTS` condition was used for the required existence check.

### Task 2(f) -- LIKE

A `LIKE` condition was used for pattern-based text filtering.

All SQL queries for Tasks 1--6 are stored in `Part1_queries.sql`.

## Task 3 -- GROUP BY & HAVING

Customer/order aggregation was performed using `GROUP BY` and `HAVING`.

The analysis calculated customer-level order information and applied the
required `HAVING` threshold. Aggregate results were ordered as required.

## Task 4 -- SQL Joins

### Task 4(a) -- INNER JOIN

An `INNER JOIN` was performed between `Orders` and `Order Details`
using:

``` text
Orders.OrderID = Order Details.OrderID
```

The resulting dataset contained:

``` text
OrderID
CustomerID
OrderDate
ProductID
UnitPrice
Quantity
Discount
```

### Task 4(b) -- LEFT JOIN

A `LEFT JOIN` was used to investigate matching and unmatched records
between the order tables.

The final joined dataset contained **609,283 rows and 7 columns**.

## Task 5 -- Referential Integrity Checks

Referential-integrity checks were performed to identify child records
without matching parent records.

The orphan check used:

``` sql
SELECT
    od.OrderID,
    od.ProductID
FROM "Order Details" AS od
LEFT JOIN "Orders" AS o
    ON od.OrderID = o.OrderID
WHERE o.OrderID IS NULL
LIMIT 20;
```

No orphan records were identified by this check.

## Task 6 -- CSV Export

The joined SQL dataset was exported as:

``` text
task4_join_export.csv
```

The export contains **609,283 rows and 7 columns** and was used as the
input for the Python/Pandas stage.

# Python / Pandas Analysis

## Task 7 -- Data Loading, Cleaning & Quality Checks

### Task 7(a) -- Dataset Loading

The exported CSV was loaded into Google Colab using Pandas.

Result:

``` text
Rows: 609,283
Columns: 7
```

Data types:

  Column       Data Type
  ------------ -----------
  OrderID      int64
  CustomerID   object
  OrderDate    object
  ProductID    int64
  UnitPrice    float64
  Quantity     int64
  Discount     float64

### Task 7(b) -- Missing-Value Analysis

Missing values were inspected across the dataset before imputation.

### Task 7(c) -- Missing-Value Imputation

Missing values were handled according to column type:

-   Numeric columns: **Median**
-   Categorical columns: **Mode**

### Task 7(d) -- Verification After Imputation

The dataset was checked again after imputation.

**Missing values remaining: 0**

### Task 7(e) -- Duplicate Analysis

Duplicate rows were checked before and after duplicate handling.

``` text
Duplicate rows before removal: 0
Duplicate rows after removal: 0
Rows after duplicate removal: 609,283
```

Therefore, no duplicate records were present.

# Task 8 -- Outlier Analysis

The continuous numeric columns selected were:

``` text
UnitPrice
Quantity
Discount
```

Summary statistics:

  Column             Mean   Std. Dev.   Minimum   Maximum
  ----------- ----------- ----------- --------- ---------
  UnitPrice     28.850379   33.565470      2.00    263.50
  Quantity      25.503095   14.453939         1       130
  Discount       0.000199    0.005978      0.00      0.25

## Task 8(a) -- Continuous Numeric Columns

The following continuous numeric columns were selected:

-   `UnitPrice`
-   `Quantity`
-   `Discount`

Identifier columns such as `OrderID` and `ProductID` were not treated as
continuous analytical variables.

## Task 8(b) -- IQR Outlier Detection

The IQR method was used to identify potential outliers.

  Column           Q1      Q3     IQR   Lower Bound   Upper Bound   IQR Outliers
  ----------- ------- ------- ------- ------------- ------------- --------------
  UnitPrice     13.25   33.25   20.00        -16.75         63.25         31,622
  Quantity      13.00   38.00   25.00        -24.50         75.50             49
  Discount       0.00    0.00    0.00          0.00          0.00            838

For `Discount`, Q1 and Q3 were both zero, producing an IQR of zero.
Therefore, non-zero discount values were classified as outliers by the
IQR rule.

## Task 8(c) -- Z-Score Outlier Detection

A threshold of **\|Z\| \> 3** was used.

  Column             Mean   Standard Deviation   Threshold   Z-Score Outliers
  ----------- ----------- -------------------- ----------- ------------------
  UnitPrice     28.850379            33.565470           3              7,905
  Quantity      25.503095            14.453939           3                 77
  Discount       0.000199             0.005978           3                837

## Task 8(d) -- IQR vs Z-Score Comparison

  Column        IQR Outliers   Z-Score Outliers
  ----------- -------------- ------------------
  UnitPrice           31,622              7,905
  Quantity                49                 77
  Discount               838                837

The IQR method identified substantially more potential outliers for
`UnitPrice`. The two methods produced very similar results for
`Discount`.

**Outlier treatment:** Outliers were reported only and were **not
removed**.

# Final Part 1 Status

-   **Rows:** 609,283
-   **Columns:** 7
-   **Missing values remaining:** 0
-   **Duplicate rows:** 0
-   **Outliers:** Identified and reported, not removed

# Files Included

``` text
Part 1/
├── Part1_Data_Cleaning.ipynb
├── Part1_queries.sql
├── task4_join_export.csv
└── README.md
```

### `Part1_queries.sql`

Contains the SQL work for Tasks 1--6.

### `Part1_Data_Cleaning.ipynb`

Contains the Google Colab/Pandas work for Tasks 7--8, including loading,
missing-value handling, imputation, duplicate checks, descriptive
statistics and outlier analysis.

### `task4_join_export.csv`

Contains the joined dataset exported from SQLite and used for the
Python/Pandas analysis.

# How to Run

## SQL Stage

1.  Open the Northwind SQLite database.
2.  Run `Part1_queries.sql`.
3.  Complete the required joins and integrity checks.
4.  Export the joined dataset as `task4_join_export.csv`.

## Python / Google Colab Stage

1.  Open `Part1_Data_Cleaning.ipynb` in Google Colab.
2.  Upload `task4_join_export.csv` when prompted.
3.  Run the notebook cells from top to bottom.
4.  Review the data-cleaning, duplicate and outlier-analysis results.

# Conclusion

Part 1 established a workflow from relational database exploration and
SQL analysis through CSV export and Python/Pandas data cleaning.

The final dataset contains **609,283 records and 7 columns**. No
duplicate records were present and no missing values remained after
imputation.

Both IQR and Z-score methods were used to identify potential outliers.
The outliers were retained rather than removed so that the original
transaction observations remain available for subsequent analysis.
