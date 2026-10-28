# Data Dictionary

The model spans 1 January 2024 through 31 December 2025. The dataset is a portfolio/demo dataset, not real-company financial data.

## Fact_Revenue

**Grain:** One revenue transaction per record.

| Column | Description |
|---|---|
| `Date` | Transaction date |
| `Revenue_INR` | Revenue amount in Indian rupees |
| `Units` | Units associated with the transaction |
| `RegionID` | Region lookup key |
| `DepartmentID` | Department lookup key |
| `ProductID` | Product lookup key |
| `TransactionID` | Transaction identifier |

## Fact_Expenses

**Grain:** One expense record per row.

| Column | Description |
|---|---|
| `Date` | Expense date |
| `Expense_INR` | Expense amount in Indian rupees |
| `RegionID` | Region lookup key |
| `DepartmentID` | Department lookup key |
| `ExpenseCategoryID` | Expense category lookup key |
| `ExpenseID` | Expense record identifier |

## Fact_Budget

**Grain:** One monthly budget record per region and department.

| Column | Description |
|---|---|
| `MonthStart` | First date of the budget month |
| `RegionID` | Region lookup key |
| `DepartmentID` | Department lookup key |
| `BudgetRevenue_INR` | Budgeted revenue in INR |
| `BudgetExpense_INR` | Budgeted expenses in INR |

Budget has no product key or expense-category key. Do not interpret product-filtered revenue variance or category-filtered expense variance as allocated budget variances.

## Dim_Date

**Grain:** One row per calendar date; 731 rows total.

| Column | Description |
|---|---|
| `Date` | Unique calendar date; marked as the date-table column |
| `Year` | Calendar year |
| `MonthNumber` | Month number, 1–12 |
| `MonthName` | Readable month name |
| `YearQuarter` | Year and quarter label |
| `MonthStart` | First date of the month |

## Dim_Month

**Grain:** One row per month; 24 rows total.

| Column | Description |
|---|---|
| `MonthStart` | Unique month-start date |
| `Year` | Calendar year |
| `MonthNumber` | Month number, 1–12 |
| `MonthName` | Readable month name |
| `YearQuarter` | Year and quarter label |
| `YearMonth` | Display label, such as `Jan 2024`, sorted by `MonthStart` |

## Dimension tables

| Table | Key | Purpose |
|---|---|---|
| `Dim_Region` | `RegionID` | Region lookup; includes a readable region name |
| `Dim_Department` | `DepartmentID` | Department lookup; includes a readable department name |
| `Dim_Product` | `ProductID` | Product lookup; includes a readable product name |
| `Dim_ExpenseCategory` | `ExpenseCategoryID` | Expense-category lookup; includes a readable category name |

Use readable dimension names in visuals wherever possible instead of displaying ID columns.
