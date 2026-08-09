# Part 2 – Statistical EDA, Hypothesis Testing & Visualization

## Project Overview

This project performs statistical exploratory data analysis on the Northwind order-line data exported from Part 1. Using Python, NumPy, Pandas, SciPy, Matplotlib, and Seaborn, the dataset was inspected, transformed, segmented, analyzed for correlations, tested statistically, and visualized.

The Part 1 export was split into two CSV files because the original CSV was approximately 29 MB. Both files are loaded and combined in this Part so that the analysis uses the complete dataset.

## Dataset

**Source:** Part 1 joined/exported Northwind order-line data.

**Input files:**
- `task4_join_export_part1.csv`
- `task4_join_export_part2.csv`

The two files contain equal portions of the Part 1 export and are combined into one DataFrame.

**Combined dataset:** 609,284 rows × 7 columns.

**Columns used:**
- `OrderID`
- `CustomerID`
- `OrderDate`
- `ProductID`
- `UnitPrice`
- `Quantity`
- `Discount`

## Tools Used

- Google Colab
- Python
- Pandas
- NumPy
- SciPy
- Matplotlib
- Seaborn

Exact package versions are provided in `requirements.txt`.

---

# Task 1 – Initial Data Inspection

The two Part 1 CSV files were loaded and combined into a single DataFrame.

The combined dataset contains **609,284 rows and 7 columns** with no missing values in the analyzed columns.

Data types include:
- `OrderID`: integer
- `CustomerID`: object
- `OrderDate`: datetime
- `ProductID`: integer
- `UnitPrice`: float
- `Quantity`: integer
- `Discount`: float

The dataset covers order-line records from **2012-07-10 to 2023-10-28**.

---

# Task 2 – NumPy Fundamentals

## Task 2(a) – Vectorized Operation

A NumPy vectorized operation was used to increase `UnitPrice` values by **10%** without using a loop.

Example:

```text
Original UnitPrice:
[14.0, 9.8, 34.8, 18.6, 42.4, ...]

Adjusted UnitPrice:
[15.4, 10.78, 38.28, 20.46, 46.64, ...]
```

## Task 2(b) – Boolean-Indexed Filtering

Boolean indexing was used to filter records according to the required `UnitPrice` and `Quantity` conditions.

**Rows matching both conditions:** 126,277.

---

# Task 3 – NumPy Descriptive Statistics

NumPy was used to calculate descriptive statistics for `UnitPrice` and `Quantity`.

| Statistic | UnitPrice | Quantity |
|---|---:|---:|
| Mean | 28.85035 | 25.50307 |
| Median | 19.5 | 25.0 |
| 90th Percentile | 49.3 | 46.0 |
| Standard Deviation | 33.56542 | 14.45393 |
| Minimum | 2.0 | 1 |
| Maximum | 263.5 | 130 |

The difference between the mean and median for `UnitPrice`, together with its high maximum value, indicates a right-skewed distribution with some relatively high-priced products.

---

# Task 4 – Feature Engineering

A new column named `TotalValue` was created:

```text
TotalValue = Quantity × UnitPrice
```

This represents the value of each order line before considering discounts.

## TotalValue Statistics

- Count: 609,284
- Mean: 736.06966
- Median: 462.0
- Minimum: 2.5
- Maximum: 15,810.0

---

# Task 5 – Grouped Analysis

Three grouped analyses were performed.

## Task 5(a) – Customer Total Value

A pivot table was created to calculate total `TotalValue` by `CustomerID`.

The highest totals included:

| CustomerID | TotalValue |
|---|---:|
| BSBEV | 6,154,115.34 |
| HUNGC | 5,698,023.67 |
| RANCH | 5,559,110.08 |
| GOURL | 5,552,597.90 |
| ANATR | 5,534,356.65 |

## Task 5(b) – Product Statistics

A product-level pivot table calculated average `Quantity` and average `UnitPrice`.

Product 38 had the highest average UnitPrice among the displayed products:

- Average Quantity: 25.583049
- Average UnitPrice: 263.446667

## Task 5(c) – Multi-Aggregation GroupBy

A multi-aggregation `groupby` was used to calculate both sum and mean values for `TotalValue` and `Quantity`.

Product 38 produced the highest total `TotalValue` among the displayed products:

**53,274,482.70**

---

# Task 6 – Bucket Segmentation

`TotalValue` was segmented into three categories:

- **Low Value**
- **Medium Value**
- **High Value**

## Bucket Counts

| ValueBucket | Count |
|---|---:|
| Low Value | 206,873 |
| Medium Value | 279,707 |
| High Value | 122,704 |

The largest segment is **Medium Value**, containing 279,707 order-line records.

---

# Task 7 – Correlation Analysis

A Pearson correlation matrix was calculated across the numeric variables.

The correlation matrix was analyzed after excluding the diagonal values, because a variable's correlation with itself is always 1 and is not a meaningful pairwise relationship.

## Strongest Pairwise Correlation

**UnitPrice ↔ TotalValue = 0.801782**

This is a strong positive correlation. The relationship is expected because `TotalValue` is calculated directly using `UnitPrice × Quantity`.

## Weakest Pairwise Correlation

**Discount ↔ TotalValue = -0.000110**

This is effectively no linear correlation in this dataset.

Other notable relationships include:

- Quantity ↔ TotalValue = 0.389989
- ProductID ↔ TotalValue = -0.067856

No NaN values were present in the numeric variables used for the correlation analysis, so no special NaN replacement was required.

---

# Task 8 – Frame the Hypothesis Test

## Business Claim

The average `TotalValue` of order lines for **Product 38 differs from the average `TotalValue` for Product 29**.

## Hypotheses

**H0:** The mean `TotalValue` for Product 38 equals the mean `TotalValue` for Product 29.

**H1:** The mean `TotalValue` for Product 38 differs from the mean `TotalValue` for Product 29.

**Significance level:** α = 0.05

---

# Task 9 – Run the Hypothesis Test

## Sample Information

| | Product 38 | Product 29 |
|---|---:|---:|
| Sample size | 7,905 | 7,847 |
| Mean TotalValue | 6,739.34 | 3,138.8858 |

## Welch Two-Sample t-Test

- Test statistic: **76.0172**
- p-value: **0.0**

## Decision

**Reject H0.**

There is statistically significant evidence that the mean `TotalValue` differs between Product 38 and Product 29.

Welch's t-test was selected because it does not require equal population variances. The two groups contain many observations, so the test is reasonably robust to moderate departures from normality. Observations were treated as independent order-line records, and the distribution visualization was used to inspect distribution shape and skewness.

---

# Task 10 – Visualizations

Four visualizations were produced directly by the notebook and saved as PNG files using `plt.savefig()`:

1. `correlation_heatmap.png` – Pearson correlation heatmap
2. `unitprice_vs_totalvalue_scatter.png` – UnitPrice versus TotalValue scatter plot with ValueBucket as hue
3. `top10_products_totalvalue.png` – top 10 products by TotalValue
4. `totalvalue_distribution.png` – TotalValue distribution

These chart files should be committed to the Part 2 GitHub folder.

---

# Task 11 – Insights and Recommendations

## 1. UnitPrice → TotalValue

**Insight:** `UnitPrice` and `TotalValue` have a strong positive Pearson correlation of **0.801782**. Since `TotalValue` is calculated from `Quantity × UnitPrice`, higher unit prices are strongly associated with higher order-line values.

**Recommendation:** Monitor high-priced products closely and prioritize them in sales and product-performance reviews because their unit price has a strong relationship with order-line value.

## 2. Product 38 → Product Performance

**Insight:** Product 38 has an average `TotalValue` of **6,739.34**, compared with **3,138.8858** for Product 29. Product 38 also generated a total `TotalValue` of **53,274,482.70** in the grouped analysis.

**Recommendation:** Give Product 38 priority in inventory planning and sales monitoring, while investigating which factors contribute to its substantially higher order-line value.

## 3. Value Segmentation → Medium-Value Orders

**Insight:** The **Medium Value** segment is the largest group with **279,707** order-line records, compared with **206,873** Low Value and **122,704** High Value records.

**Recommendation:** Develop targeted offers or upselling strategies for the large Medium Value segment to encourage customers to move toward higher-value purchases.

## 4. Discount → TotalValue

**Insight:** `Discount` has an almost zero Pearson correlation with `TotalValue` at **-0.000110**, indicating essentially no linear relationship in this dataset.

**Recommendation:** Avoid assuming that increasing discounts will automatically increase order-line value. Evaluate discount strategies using additional business measures such as product category, customer segment, or sales volume before changing discount policies.

## 5. UnitPrice Distribution → Price Monitoring

**Insight:** `UnitPrice` has a mean of **28.85035**, a median of **19.5**, and a maximum of **263.5**. The difference between the mean and median indicates a right-skewed price distribution.

**Recommendation:** Review unusually high-priced products separately when performing pricing analysis so that a small number of high-price observations do not obscure the behavior of typical products.

---

# Key Findings

1. **UnitPrice and TotalValue have a strong positive correlation (0.801782).** This is consistent with the TotalValue feature being calculated from UnitPrice and Quantity.

2. **Product 38 has substantially higher average TotalValue than Product 29.** The Welch t-test produced a test statistic of 76.0172 and p-value of 0.0, providing strong statistical evidence against the null hypothesis.

3. **Medium-value order lines form the largest segment**, with 279,707 records, followed by Low Value with 206,873 and High Value with 122,704.

4. **Discount has almost no linear correlation with TotalValue**, with a correlation of approximately -0.00011.

5. **UnitPrice is right-skewed**, with a mean of 28.85035 compared with a median of 19.5 and a maximum of 263.5.

---

# Files Included

```text
part2/
├── README.md
├── Part2_Statistical_EDA.ipynb
├── requirements.txt
├── task4_join_export_part1.csv
├── task4_join_export_part2.csv
├── correlation_heatmap.png
├── unitprice_vs_totalvalue_scatter.png
├── top10_products_totalvalue.png
└── totalvalue_distribution.png
```

The two CSV files are included because the original Part 1 export was split into two files due to its approximately 29 MB size. The notebook loads both files and combines them before performing the analysis.

---

# Requirements

Install the pinned dependencies from `requirements.txt`:

```bash
pip install -r requirements.txt
```

The required library versions are:

```text
matplotlib==3.10.0
numpy==2.0.2
pandas==2.2.2
scipy==1.16.3
seaborn==0.13.2
```

No API keys, passwords, or other secrets are required for this Part.

---

# How to Run

1. Open `Part2_Statistical_EDA.ipynb` in Google Colab or Jupyter Notebook.
2. Keep the two CSV files in the same working directory as the notebook when running locally:
   - `task4_join_export_part1.csv`
   - `task4_join_export_part2.csv`
3. Install the pinned dependencies:

```bash
pip install -r requirements.txt
```

4. Run the notebook from top to bottom without skipping cells.
5. The notebook will load both CSV files, combine them, perform the analysis, run the hypothesis test, and generate the four visualization PNG files.

For Google Colab, the two CSV files can be uploaded to the Colab working environment before running the notebook.

---

# Conclusion

This Part demonstrates a complete statistical EDA workflow on the Northwind order-line dataset, including NumPy operations, descriptive statistics, feature engineering, grouped analysis, segmentation, correlation analysis, hypothesis testing, and visualization.

The analysis shows substantial differences in `TotalValue` between Product 38 and Product 29, a strong relationship between `UnitPrice` and `TotalValue`, a large Medium Value customer-order segment, and almost no linear relationship between `Discount` and `TotalValue`.

The findings were converted into concrete recommendations covering high-value products, value segmentation, pricing, and discount strategy.
