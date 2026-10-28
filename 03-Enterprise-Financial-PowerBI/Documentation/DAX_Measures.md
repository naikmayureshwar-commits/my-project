# DAX Measures Reference

Use these measures in Power BI. Currency measures are formatted as INR; percentage measures are formatted as percentages with two decimal places.

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

## Definitions and interpretation

- `Total Revenue`: sum of actual revenue transaction amounts.
- `Total Expenses`: sum of expense record amounts.
- `Operating Profit (Simplified)`: revenue minus expenses; not necessarily formal accounting operating profit.
- `Operating Margin`: simplified operating profit divided by actual revenue.
- `Budget Revenue` and `Budget Expenses`: sums of monthly budget records in the current filter context.
- `Revenue Variance`: actual revenue minus revenue budget. Negative is below budget.
- `Revenue Variance %`: revenue variance divided by budget revenue.
- `Expense Variance`: budget expenses minus actual expenses. Positive is favorable underspending versus budget.
- `Expense Variance %`: expense variance divided by budget expenses.

## Full-period validation baseline

| Measure | Validated value |
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

Values refer to the complete 2024–2025 period with slicers cleared.
