# Enterprise Financial Performance & Budget Variance Analytics

An interactive Power BI portfolio project for reviewing financial performance, comparing actual results with budget, and exploring revenue and expense trends across regions, departments, and time.

> **Dataset note:** This project uses a portfolio/demo dataset, not verified financial data from a real company. The operating-profit and margin metrics below use the simplified definitions documented in this repository.

## Project objectives

- Compare actual revenue and expenses with budget.
- Track monthly revenue and expense trends across 2024–2025.
- Review simplified operating profit and operating margin.
- Compare regional profitability and expense-category composition.
- Support exploratory analysis through Year, Region, and Department slicers.

## Tools

- Microsoft Power BI Desktop
- Power Query for data type checks, validation, and transformation
- DAX for financial measures
- CSV files as data sources

## Dashboard pages

### Executive Overview

- Six KPI cards: Total Revenue, Total Expenses, Operating Profit, Operating Margin, Revenue Variance vs Budget, and Expense Variance vs Budget
- Monthly Revenue vs Budget line chart
- Monthly Expenses vs Budget line chart
- Operating Profit by Region bar chart
- Expense Breakdown by Category bar chart
- Year, Region, and Department slicers

### Business Insights

- Evidence-based findings and business recommendations
- Regional profitability table
- Expense category table
- Monthly revenue-variance table

### DAX_Validation

A validation page used to check measures, monthly totals, filter behavior, and reconciliations.

## Dataset overview

The model covers **1 January 2024 through 31 December 2025**.

| Table | Rows | Purpose |
|---|---:|---|
| `Fact_Revenue` | 4,449 | Revenue transactions, units, and related dimension keys |
| `Fact_Expenses` | 3,821 | Expense records and related dimension keys |
| `Fact_Budget` | 384 | Monthly revenue and expense budgets by region and department |
| `Dim_Date` | 731 | Daily calendar, year, month, quarter, and month-start fields |
| `Dim_Region` | 4 | Region lookup |
| `Dim_Department` | 4 | Department lookup |
| `Dim_Product` | 5 | Product lookup |
| `Dim_ExpenseCategory` | 5 | Expense category lookup |
| `Dim_Month` | 24 | Distinct month-level table derived from `Dim_Date` |

`Dim_Month` contains one row per month and includes `MonthStart`, `Year`, `MonthNumber`, `MonthName`, `YearQuarter`, and `YearMonth`. `YearMonth` is sorted by `MonthStart` to preserve chronological order.

## Data model

The model uses dimension-to-fact relationships with one-to-many cardinality and single-direction filtering:

- `Dim_Month[MonthStart]` → `Dim_Date[MonthStart]`
- `Dim_Month[MonthStart]` → `Fact_Budget[MonthStart]`
- `Dim_Date[Date]` → `Fact_Revenue[Date]`
- `Dim_Date[Date]` → `Fact_Expenses[Date]`
- `Dim_Region[RegionID]` → each fact table's `RegionID`
- `Dim_Department[DepartmentID]` → each fact table's `DepartmentID`
- `Dim_Product[ProductID]` → `Fact_Revenue[ProductID]`
- `Dim_ExpenseCategory[ExpenseCategoryID]` → `Fact_Expenses[ExpenseCategoryID]`

`Dim_Date` is marked as the date table. `Dim_Month` provides month-level filtering for the budget and the daily calendar.

## Key DAX measures

```dax
Total Revenue = SUM ( Fact_Revenue[Revenue_INR] )

Total Expenses = SUM ( Fact_Expenses[Expense_INR] )

Operating Profit (Simplified) = [Total Revenue] - [Total Expenses]

Operating Margin = DIVIDE ( [Operating Profit (Simplified)], [Total Revenue], 0 )

Budget Revenue = SUM ( Fact_Budget[BudgetRevenue_INR] )

Budget Expenses = SUM ( Fact_Budget[BudgetExpense_INR] )

Revenue Variance = [Total Revenue] - [Budget Revenue]

Revenue Variance % = DIVIDE ( [Revenue Variance], [Budget Revenue], 0 )

Expense Variance = [Budget Expenses] - [Total Expenses]

Expense Variance % = DIVIDE ( [Expense Variance], [Budget Expenses], 0 )
```

### Variance interpretation

- **Revenue Variance:** actual revenue minus budget. A negative result means revenue is below budget.
- **Expense Variance:** budget expenses minus actual expenses. A positive result means actual expenses are below budget.

## Full-period results (2024–2025)

These are the validated totals with all slicers cleared.

| KPI | Result |
|---|---:|
| Total Revenue | ₹357,003,158.87 |
| Total Expenses | ₹277,818,809.99 |
| Operating Profit (Simplified) | ₹79,184,348.88 |
| Operating Margin | 22.18% |
| Budget Revenue | ₹358,402,072.55 |
| Budget Expenses | ₹279,428,394.74 |
| Revenue Variance | −₹1,398,913.68 |
| Revenue Variance % | −0.39% |
| Expense Variance | +₹1,609,584.75 |
| Expense Variance % | +0.58% |

## Evidence-based findings

- **Regional profitability:** North was the highest-profit region, with simplified operating profit of **₹21,425,334.79**, approximately **27.06%** of total simplified operating profit.
- **Expense category:** Operation was the largest expense category, at **₹56,754,377.39**, approximately **20.43%** of total expenses.
- **Monthly revenue variance:** February 2024 had the largest reported monthly revenue shortfall, with revenue variance of **−₹527,111.30**.

## Recommendations for further investigation

1. Compare revenue, expenses, and margins across regions to find practices or conditions that may be associated with North's stronger profitability.
2. Break down Operation expenses by month, region, and department to identify cost drivers and possible savings without compromising operations.
3. Investigate regional, departmental, and product-level revenue results for February 2024 to understand the contributors to its revenue shortfall.
4. Monitor actual-versus-budget performance monthly and investigate material deviations early.

These recommendations are proposed follow-up analyses, not claims that this report has established the causes of the observed results.

## Important limitations

- This is a portfolio/demo dataset and should not be represented as a real company's financial results.
- `Operating Profit (Simplified)` is calculated as revenue minus expenses. It is not necessarily equivalent to formal accounting operating profit.
- Budgets are available by month, region, and department, but not allocated by product or expense category. Product-filtered revenue variance and category-filtered expense variance therefore should **not** be presented as valid product-level or category-level budget variances.
- Expense variance is defined as budget minus actual expenses, so positive values are favorable underspending versus budget; they do not by themselves prove that spending was efficient or sufficient.

## How to use

1. Download or clone the repository.
2. Keep the CSV data files in the documented `Data/` folder, preserving the file paths used by the PBIX or update the source paths in Power BI.
3. Open `Dashboard/Enterprise_Financial_Analytics.pbix` in Power BI Desktop.
4. If Power BI asks for data source locations, update the paths to the CSV files in `Data/`, then refresh.
5. Clear the slicers to see the full-period figures reported above.

## Suggested repository structure

```text
Enterprise-Financial-PowerBI/
├── README.md
├── Data/
│   └── CSV source tables
├── Dashboard/
│   ├── Enterprise_Financial_Analytics.pbix
│   └── screenshots/
│       ├── Executive_Overview.png
│       └── Business_Insights.png
└── Documentation/
    ├── Business_Insights.md
    ├── Data_Dictionary.md
    ├── DAX_Measures.md
    └── GitHub_Checklist.md
```

Add genuine screenshots from your finished Power BI report before publishing; the screenshot filenames above are suggested names, not included images.
