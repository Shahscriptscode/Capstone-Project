# Part 2 – Statistical EDA, Hypothesis Testing & Visualization

## Project Overview

This project performs exploratory data analysis on the Northwind order data exported 
from Part 1. Using Python, NumPy, and Pandas, the dataset was inspected statistically, 
a new feature was engineered, data was grouped and segmented, correlations were 
analyzed, a hypothesis test was conducted, and four visualizations were produced to 
communicate the findings.

---

# Dataset

**Source file:** orders_export.csv (from Part 1)

**Columns used:** id, order_id, company, shipping_fee, order_date

---

# Tools Used

- Google Colab
- Python
- Pandas
- NumPy
- SciPy
- Matplotlib
- Seaborn

---

# Task 1 – Initial Inspection

The dataset was loaded into a Pandas DataFrame and inspected using `df.info()` and 
`df.describe(include='all')` to understand its structure, data types, and summary 
statistics.

---

# Task 2 – NumPy Fundamentals

- Converted the `shipping_fee` column to a NumPy array.
- Applied a vectorized 10% increase across the entire array with no loop.
- Filtered rows using two combined Boolean conditions (`shipping_fee > 10 & shipping_fee < 50`).

---

# Task 3 – Descriptive Statistics

Using NumPy, the following statistics were computed for `shipping_fee` and `id`:

- Mean
- Median
- Standard deviation
- Variance
- 90th percentile

---

# Task 4 – Feature Engineering

A new column, `fee_per_day`, was created by dividing `shipping_fee` by 
`days_since_start` (days elapsed since the earliest order date). This derived metric 
estimates the shipping cost relative to order recency.

---

# Task 5 – Grouped Analysis

- Pivot Table 1: average shipping fee per company.
- Pivot Table 2: order count per company.
- Multi-aggregation groupby: sum and mean of shipping fee per company, computed in a 
  single `.agg()` call.

---

# Task 6 – Bucket Segmentation

A custom function was written to classify `shipping_fee` values into three labeled 
buckets — **Low**, **Medium**, and **High** — and applied across the dataset using 
`.apply()`.

---

# Task 7 – Correlation Analysis

A Pearson correlation matrix was computed across all numeric columns using `df.corr()`.

- **Highest absolute correlation:** `order_id` and `days_since_start` (0.92) — order 
  IDs are assigned sequentially over time, so they naturally track together.
- **Lowest absolute correlation:** `id` and `order_id` (0.0005) — a customer's ID is 
  an arbitrary identifier unrelated to order timing.
- No ties or NaN values were present in the matrix.

---

# Task 8 – Hypothesis Test Framing

**Business claim:** The average shipping fee for orders differs from a benchmark 
value of 40.

- **H0 (null hypothesis):** The average shipping fee equals 40.
- **H1 (alternate hypothesis):** The average shipping fee does not equal 40.
- **Significance level:** 0.05

---

# Task 9 – Running the Hypothesis Test

A one-sample t-test (`scipy.stats.ttest_1samp`) was used to compare the sample mean 
shipping fee against the benchmark of 40.

- **t-statistic:** 0.403
- **p-value:** 0.689
- **Decision:** Fail to reject H0 — there is not enough evidence that the average 
  shipping fee differs from 40.

**Assumption checked:** Approximate normality of `shipping_fee`, visually assessed 
via the histogram in `histogram.png`.

---

# Task 10 – Visualizations

Four labelled visualizations were produced and saved as `.png` files:

- `heatmap.png` — Seaborn correlation heatmap (annot=True)
- `scatter.png` — Scatter plot of shipping fee vs. days since start, colored by fee bucket
- `barplot.png` — Bar plot of average shipping fee by bucket
- `histogram.png` — Distribution of shipping fee values

---

# Task 11 – Insights and Recommendations

1. **Insight:** The average shipping fee is approximately $44.54, with a 90th 
   percentile of [28.0] — a small share of orders carry 
   notably higher shipping costs.
   **Recommendation:** Negotiate bulk/flat shipping rates for customers whose orders 
   regularly exceed the 90th percentile threshold.

2. **Insight:** `order_id` and `days_since_start` showed the highest correlation 
   (0.92), while `id` and `order_id` showed almost none (0.0005).
   **Recommendation:** `order_id` can be used as a reliable proxy for order recency 
   in future reporting, reducing reliance on full date parsing.

3. **Insight:** The hypothesis test failed to reject H0 (p = 0.689), showing no 
   significant difference between the actual average shipping fee and the $40 benchmark.
   **Recommendation:** No immediate pricing adjustment is needed; revisit the 
   benchmark only if future data shows a real deviation.

---

# Files Included


---

# How to Run

1. Open `part2_eda.ipynb` in Google Colab.
2. Upload `orders_export.csv` when prompted.
3. Run all notebook cells from top to bottom.

---

# Conclusion

This project demonstrates a complete exploratory data analysis workflow — from 
initial inspection and statistical summarization, through feature engineering, 
grouped analysis, correlation analysis, and hypothesis testing, to clear visual 
communication of findings. The results provide actionable insights into shipping 
cost patterns within the Northwind order data.