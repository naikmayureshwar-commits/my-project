USE retail_sales;

SELECT DATABASE();


-- ============================================================
-- RETAIL SALES ANALYTICS PROJECT
-- FINAL SQL ANALYSIS
-- ============================================================

-- ============================================================
-- 1. DATASET OVERVIEW
-- ============================================================
/*Requirement 1 — Total Transactions
Find the total number of transactions in the dataset.*/
select count(*) as total_transaction
from sales_data;


/*Requirement 2 — Sales Period
Find:
- Earliest order date
- Latest order date
The result should clearly show the period covered by the data.*/
SELECT
    MIN(Order_Date) AS start_date,
    MAX(Order_Date) AS end_date
FROM sales_data;



/*Requirement 3 — Customer Coverage
 Find the number of unique customers who placed order */

select count(Distinct customer_id) as "number of unique customers who placed orders"
from sales_data;

/*Requirement 4 — Product Coverage
Find the number of unique products sold.*/
select count(Distinct product) as "number of unique products sold"
from sales_data;

-- Requirement 5 — Category Coverage
-- Find the number of unique product categories.
select count(distinct category) as "number of unique product categories"
from sales_data

-- Requirement 6 — Regional Coverage
-- Find the number of unique regions represented in the sales transactions

select count(distinct region) as "number of unique region"
from sales_data


-- Requirement 7 — Dataset Summary
-- Now combine the important overview information into one result:

select count(*) as total_transaction,
    MIN(Order_Date) AS start_date,
    MAX(Order_Date) AS end_date,
	count(Distinct customer_id) as "number of unique customers who placed orders",
    count(Distinct product) as "number of unique products sold",
	count(distinct category) as "number of unique product categories",
	count(distinct region) as "number of unique region"
from sales_data;

select count(null) from sales_data;


-- ============================================================
-- 2. DATA QUALITY CHECKS
-- ============================================================
-- ============================================================
-- 2. DATA QUALITY CHECKS
-- ============================================================

-- 2.1 Missing Values Check

SELECT
    SUM(CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END) AS order_id_nulls,
    SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS order_date_nulls,
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS customer_id_nulls,
    SUM(CASE WHEN Product IS NULL THEN 1 ELSE 0 END) AS product_nulls,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS category_nulls,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS quantity_nulls,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS sales_nulls,
    SUM(CASE WHEN Cost IS NULL THEN 1 ELSE 0 END) AS cost_nulls,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS profit_nulls,
    SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS region_nulls,
    SUM(CASE WHEN Channel IS NULL THEN 1 ELSE 0 END) AS channel_nulls
FROM sales_data;




/*Check whether any order has been recorded more than once in the sales transaction table.”*/
SELECT
    Order_ID,
    COUNT(*) AS order_count
FROM sales_data
GROUP BY Order_ID
HAVING COUNT(*) > 1;


/*2.3 Invalid Numeric Values
Check whether important numeric fields contain negative values.*/

SELECT
    COUNT(*) AS invalid_numeric_records
FROM sales_data
WHERE Quantity < 0
   OR Unit_Price < 0
   OR Discount < 0
   OR Sales < 0
   OR Cost < 0;
   
-- 2.4 Invalid Quantity
-- A retail transaction should normally have a quantity greater than zero.
SELECT
    Order_ID,
    Product,
    Quantity
FROM sales_data
WHERE Quantity <= 0;


-- ============================================================
-- 2.5 SALES AND PROFIT CONSISTENCY
-- ============================================================

SELECT
    Order_ID,
    Sales,
    Cost,
    Profit,
    (Sales - Cost) AS calculated_profit
FROM sales_data
WHERE ABS(Profit - (Sales - Cost)) > 0.01;



-- ============================================================
-- 2.6 INVALID DATE CHECK
-- ============================================================

SELECT
    Order_ID,
    Order_Date
FROM sales_data
WHERE Order_Date < '2025-01-01'
   OR Order_Date > '2025-12-31';



-- ============================================================
-- 3. OVERALL BUSINESS KPIs
-- ============================================================
-- 3.1 Total Sales

SELECT
    SUM(Sales) AS total_sales
FROM sales_data;


-- 3.2 Total Profit

SELECT
    SUM(Profit) AS total_profit
FROM sales_data;

-- 3.3 Total Orders

SELECT
    COUNT(DISTINCT Order_ID) AS total_orders
FROM sales_data;

-- 3.4 Total Quantity Sold

SELECT
    SUM(Quantity) AS total_quantity_sold
FROM sales_data;

-- 3.5 Average Order Value

SELECT
    SUM(Sales) / COUNT(DISTINCT Order_ID) AS average_order_value
FROM sales_data;

-- 3.6 Overall Profit Margin

SELECT
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data;


-- 3.7 Overall Business KPI Summary

SELECT
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Quantity) AS total_quantity_sold,
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS average_order_value,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data;



-- ============================================================
-- 4. SALES PERFORMANCE
-- ============================================================
-- 4.1 Sales Performance by Region

SELECT
    Region,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Quantity) AS total_quantity,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY Region
ORDER BY total_sales DESC;



-- 4.2 Regional Sales Contribution

SELECT
    Region,
    SUM(Sales) AS total_sales,
    ROUND(
        SUM(Sales) /
        NULLIF((SELECT SUM(Sales) FROM sales_data), 0) * 100,
        2
    ) AS sales_contribution_percentage
FROM sales_data
GROUP BY Region
ORDER BY total_sales DESC;


-- 4.3 Sales Performance by Category

SELECT
    Category,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Quantity) AS total_quantity,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY Category
ORDER BY total_sales DESC;


-- 4.4 Sales Performance by Channel

SELECT
    Channel,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Quantity) AS total_quantity,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY Channel
ORDER BY total_sales DESC;



-- 4.5 Sales Performance by Customer Segment

SELECT
    Customer_Segment,
    COUNT(DISTINCT Order_ID) AS total_orders,
    COUNT(DISTINCT Customer_ID) AS unique_customers,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY Customer_Segment
ORDER BY total_sales DESC;


-- 4.6 Monthly Sales Performance

SELECT
    MONTH(Order_Date) AS month_number,
    MONTHNAME(Order_Date) AS month_name,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY month_number;



-- 4.7 Quarterly Sales Performance

SELECT
    QUARTER(Order_Date) AS quarter,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY QUARTER(Order_Date)
ORDER BY quarter;

-- 4.8 Best-Performing Region

SELECT
    Region,
    SUM(Sales) AS total_sales
FROM sales_data
GROUP BY Region
ORDER BY total_sales DESC
LIMIT 1;


-- 4.9 Best Sales Month

SELECT
    MONTH(Order_Date) AS month_number,
    MONTHNAME(Order_Date) AS month_name,
    SUM(Sales) AS total_sales
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY total_sales DESC
LIMIT 1;



-- 4.10 Monthly Sales Growth

WITH monthly_sales AS (
    SELECT
        MONTH(Order_Date) AS month_number,
        MONTHNAME(Order_Date) AS month_name,
        SUM(Sales) AS total_sales
    FROM sales_data
    GROUP BY
        MONTH(Order_Date),
        MONTHNAME(Order_Date)
),
monthly_comparison AS (
    SELECT
        month_number,
        month_name,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY month_number
        ) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    month_number,
    month_name,
    total_sales,
    previous_month_sales,
    ROUND(
        (total_sales - previous_month_sales)
        / NULLIF(previous_month_sales, 0) * 100,
        2
    ) AS month_over_month_growth_percentage
FROM monthly_comparison
ORDER BY month_number;





-- ============================================================
-- 5. PRODUCT ANALYSIS
-- ============================================================
-- 5.1 Product Performance

SELECT
    Product,
    Category,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Quantity) AS total_quantity,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY
    Product,
    Category
ORDER BY total_sales DESC;



-- 5.2 Top 10 Products by Sales

SELECT
    Product,
    Category,
    SUM(Quantity) AS total_quantity,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY
    Product,
    Category
ORDER BY total_sales DESC
LIMIT 10;



-- 5.3 Top 10 Products by Profit

SELECT
    Product,
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY
    Product,
    Category
ORDER BY total_profit DESC
LIMIT 10;

-- 5.4 Product Profit Margin

SELECT
    Product,
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) /
        NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY
    Product,
    Category
ORDER BY profit_margin_percentage DESC;

-- 5.5 Top Product in Each Category

WITH product_performance AS (
    SELECT
        Category,
        Product,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit
    FROM sales_data
    GROUP BY
        Category,
        Product
),
ranked_products AS (
    SELECT
        Category,
        Product,
        total_sales,
        total_profit,
        ROW_NUMBER() OVER (
            PARTITION BY Category
            ORDER BY total_sales DESC
        ) AS product_rank
    FROM product_performance
)
SELECT
    Category,
    Product,
    total_sales,
    total_profit
FROM ranked_products
WHERE product_rank = 1
ORDER BY Category;


-- 5.6 Top 3 Products per Category

WITH product_performance AS (
    SELECT
        Category,
        Product,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit
    FROM sales_data
    GROUP BY
        Category,
        Product
),
ranked_products AS (
    SELECT
        Category,
        Product,
        total_sales,
        total_profit,
        DENSE_RANK() OVER (
            PARTITION BY Category
            ORDER BY total_sales DESC
        ) AS product_rank
    FROM product_performance
)
SELECT
    Category,
    Product,
    total_sales,
    total_profit,
    product_rank
FROM ranked_products
WHERE product_rank <= 3
ORDER BY Category, product_rank;

-- 5.7 High-Sales but Low-Margin Products

SELECT
    Product,
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) /
        NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY
    Product,
    Category
HAVING
    SUM(Sales) > (
        SELECT AVG(product_sales)
        FROM (
            SELECT SUM(Sales) AS product_sales
            FROM sales_data
            GROUP BY Product
        ) AS product_summary
    )
    AND
    SUM(Profit) / NULLIF(SUM(Sales), 0) < 0.10
ORDER BY total_sales DESC;


-- 5.8 Loss-Making Products

SELECT
    Product,
    Category,
    SUM(Sales) AS total_sales,
    SUM(Cost) AS total_cost,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY
    Product,
    Category
HAVING SUM(Profit) < 0
ORDER BY total_profit;

-- 5.9 Least Profitable Products

SELECT
    Product,
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) /
        NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY
    Product,
    Category
ORDER BY total_profit
LIMIT 10;






-- ============================================================
-- 6. CATEGORY ANALYSIS
-- ============================================================
-- 6.1 Category Performance
SELECT
    Category,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Quantity) AS total_quantity,
    SUM(Sales) AS total_sales,
    SUM(Cost) AS total_cost,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY Category
ORDER BY total_sales DESC;

-- 6.2 Category Sales Contribution
-- Which categories contribute the most to overall sales?
SELECT
    Category,
    SUM(Sales) AS total_sales,
    ROUND(
        SUM(Sales) /
        NULLIF((SELECT SUM(Sales) FROM sales_data), 0) * 100,
        2
    ) AS sales_contribution_percentage
FROM sales_data
GROUP BY Category
ORDER BY total_sales DESC;

-- 6.3 Most Profitable Category
SELECT
    Category,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY Category
ORDER BY total_profit DESC
LIMIT 1;


-- 6.4 Category with Highest Profit Margin

SELECT
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) /
        NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY Category
ORDER BY profit_margin_percentage DESC
LIMIT 1;


-- 6.5 Category with Lowest Profit Margin
SELECT
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) /
        NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY Category
ORDER BY profit_margin_percentage
LIMIT 1;

-- 6.6 Category Performance Classification
WITH category_performance AS (
    SELECT
        Category,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit,
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100
            AS profit_margin_percentage
    FROM sales_data
    GROUP BY Category
)
SELECT
    Category,
    total_sales,
    total_profit,
    ROUND(profit_margin_percentage, 2) AS profit_margin_percentage,
    CASE
        WHEN profit_margin_percentage >= 20 THEN 'High Margin'
        WHEN profit_margin_percentage >= 10 THEN 'Medium Margin'
        ELSE 'Low Margin'
    END AS margin_category
FROM category_performance
ORDER BY profit_margin_percentage DESC;



-- ============================================================
-- 7. REGIONAL ANALYSIS
-- ============================================================
-- 7.1 Complete Regional Performance
SELECT
    Region,
    COUNT(DISTINCT Order_ID) AS total_orders,
    COUNT(DISTINCT Customer_ID) AS unique_customers,
    SUM(Quantity) AS total_quantity,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY Region
ORDER BY total_sales DESC;



-- 7.2 Region Sales Contribution
SELECT
    Region,
    SUM(Sales) AS total_sales,
    ROUND(
        SUM(Sales) /
        NULLIF((SELECT SUM(Sales) FROM sales_data), 0) * 100,
        2
    ) AS sales_contribution_percentage
FROM sales_data
GROUP BY Region
ORDER BY total_sales DESC;

-- 7.3 Most Profitable Region
SELECT
    Region,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY Region
ORDER BY total_profit DESC
LIMIT 1;

-- 7.4 Highest-Margin Region
SELECT
    Region,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) /
        NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY Region
ORDER BY profit_margin_percentage DESC
LIMIT 1;


-- 7.5 City-Level Performance
SELECT
    Region,
    City,
    COUNT(DISTINCT Order_ID) AS total_orders,
    COUNT(DISTINCT Customer_ID) AS unique_customers,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY
    Region,
    City
ORDER BY total_sales DESC;

-- 7.6 Top City in Each Region
WITH city_performance AS (
    SELECT
        Region,
        City,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit
    FROM sales_data
    GROUP BY
        Region,
        City
),
ranked_cities AS (
    SELECT
        Region,
        City,
        total_sales,
        total_profit,
        ROW_NUMBER() OVER (
            PARTITION BY Region
            ORDER BY total_sales DESC
        ) AS city_rank
    FROM city_performance
)
SELECT
    Region,
    City,
    total_sales,
    total_profit
FROM ranked_cities
WHERE city_rank = 1
ORDER BY Region;


-- 7.7 Regional Channel Performance

SELECT
    Region,
    Channel,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY
    Region,
    Channel
ORDER BY
    Region,
    total_sales DESC;
    




-- 7.8 Best Channel in Each Region
WITH regional_channel AS (
    SELECT
        Region,
        Channel,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit
    FROM sales_data
    GROUP BY
        Region,
        Channel
),
ranked_channels AS (
    SELECT
        Region,
        Channel,
        total_sales,
        total_profit,
        ROW_NUMBER() OVER (
            PARTITION BY Region
            ORDER BY total_sales DESC
        ) AS channel_rank
    FROM regional_channel
)
SELECT
    Region,
    Channel,
    total_sales,
    total_profit
FROM ranked_channels
WHERE channel_rank = 1
ORDER BY Region;






-- ============================================================
-- 8. CUSTOMER ANALYSIS
-- ============================================================
-- 8.1 Customer Performance
SELECT
    Customer_ID,
    MAX(Customer_Name) AS Customer_Name,
    MAX(Region) AS Region,
    MAX(Customer_Segment) AS Customer_Segment,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Quantity) AS total_quantity,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY Customer_ID
ORDER BY total_sales DESC;

-- 8.2 Top 10 Customers by Sales
SELECT
    Customer_ID,
    MAX(Customer_Name) AS Customer_Name,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY Customer_ID
ORDER BY total_sales DESC
LIMIT 10;

-- 8.3 Top 10 Customers by Profit
SELECT
    Customer_ID,
    MAX(Customer_Name) AS Customer_Name,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY Customer_ID
ORDER BY total_profit DESC
LIMIT 10;


-- 8.4 Customer Purchase Frequency
SELECT
    Customer_ID,
    MAX(Customer_Name) AS Customer_Name,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales
FROM sales_data
GROUP BY Customer_ID
ORDER BY total_orders DESC;


-- 8.5 Repeat Customers
-- A repeat customer has more than one order.
SELECT
    Customer_ID,
    MAX(Customer_Name) AS Customer_Name,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales
FROM sales_data
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Order_ID) > 1
ORDER BY total_orders DESC;


-- 8.6 Customers with Both Online and Offline Purchases
-- This identifies customers who use multiple channels.
SELECT
    Customer_ID,
    MAX(Customer_Name) AS Customer_Name,
    COUNT(DISTINCT Channel) AS channel_count,
    SUM(Sales) AS total_sales
FROM sales_data
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Channel) = 2
ORDER BY total_sales DESC;

-- 8.7 Online-Only Customers
SELECT
    Customer_ID,
    MAX(Customer_Name) AS Customer_Name,
    SUM(Sales) AS total_sales
FROM sales_data
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Channel) = 1
   AND MAX(Channel) = 'Online';


-- 8.8 Customers Who Never Purchased

SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Region,
    c.Customer_Segment
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
WHERE s.Customer_ID IS NULL;



-- 8.9 Customer Sales Including Zero
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Region,
    c.Customer_Segment,
    COUNT(DISTINCT s.Order_ID) AS total_orders,
    COALESCE(SUM(s.Sales), 0) AS total_sales,
    COALESCE(SUM(s.Profit), 0) AS total_profit
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    c.Region,
    c.Customer_Segment
ORDER BY total_sales DESC;

-- 8.10 Latest Order for Every Registered Customer
WITH ranked_orders AS (
    SELECT
        Customer_ID,
        Order_ID,
        Order_Date,
        Sales,
        ROW_NUMBER() OVER (
            PARTITION BY Customer_ID
            ORDER BY Order_Date DESC, Order_ID DESC
        ) AS order_rank
    FROM sales_data
)
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Region,
    r.Order_ID AS latest_order_id,
    r.Order_Date AS latest_order_date,
    r.Sales AS latest_order_sales
FROM customers c
LEFT JOIN ranked_orders r
    ON c.Customer_ID = r.Customer_ID
   AND r.order_rank = 1
ORDER BY latest_order_date DESC;

-- 8.11 High-Value Inactive Customers
WITH customer_summary AS (
    SELECT
        Customer_ID,
        MAX(Customer_Name) AS Customer_Name,
        MAX(Region) AS Region,
        SUM(Sales) AS total_sales,
        MAX(Order_Date) AS latest_order_date
    FROM sales_data
    GROUP BY Customer_ID
)
SELECT
    Customer_ID,
    Customer_Name,
    Region,
    total_sales,
    latest_order_date
FROM customer_summary
WHERE total_sales > 50000
  AND latest_order_date < '2025-10-03'
ORDER BY total_sales DESC;


-- 8.12 Customer Ranking
-- Rank customers by their total sales.
WITH customer_sales AS (
    SELECT
        Customer_ID,
        MAX(Customer_Name) AS Customer_Name,
        SUM(Sales) AS total_sales
    FROM sales_data
    GROUP BY Customer_ID
)
SELECT
    Customer_ID,
    Customer_Name,
    total_sales,
    DENSE_RANK() OVER (
        ORDER BY total_sales DESC
    ) AS customer_rank
FROM customer_sales
ORDER BY customer_rank;



-- 8.13 Top 3 Customers in Each Region

WITH customer_sales AS (
    SELECT
        Region,
        Customer_ID,
        MAX(Customer_Name) AS Customer_Name,
        SUM(Sales) AS total_sales
    FROM sales_data
    GROUP BY
        Region,
        Customer_ID
),
ranked_customers AS (
    SELECT
        Region,
        Customer_ID,
        Customer_Name,
        total_sales,
        DENSE_RANK() OVER (
            PARTITION BY Region
            ORDER BY total_sales DESC
        ) AS customer_rank
    FROM customer_sales
)
SELECT
    Region,
    Customer_ID,
    Customer_Name,
    total_sales,
    customer_rank
FROM ranked_customers
WHERE customer_rank <= 3
ORDER BY Region, customer_rank;


-- 8.14 First vs Latest Purchase
-- This tells us the customer's purchasing timeline.
SELECT
    Customer_ID,
    MAX(Customer_Name) AS Customer_Name,
    MIN(Order_Date) AS first_purchase_date,
    MAX(Order_Date) AS latest_purchase_date,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales
FROM sales_data
GROUP BY Customer_ID
ORDER BY total_sales DESC;



-- 8.15 Customer Purchase Gap
WITH customer_orders AS (
    SELECT
        Customer_ID,
        Order_ID,
        Order_Date,
        LAG(Order_Date) OVER (
            PARTITION BY Customer_ID
            ORDER BY Order_Date, Order_ID
        ) AS previous_order_date
    FROM sales_data
)
SELECT
    Customer_ID,
    Order_ID,
    Order_Date,
    previous_order_date,
    DATEDIFF(
        Order_Date,
        previous_order_date
    ) AS days_since_previous_order
FROM customer_orders
WHERE previous_order_date IS NOT NULL
ORDER BY Customer_ID, Order_Date;





-- ============================================================
-- 9. CHANNEL ANALYSIS
-- ============================================================
-- 9.1 Overall Channel Performance
SELECT
    Channel,
    COUNT(DISTINCT Order_ID) AS total_orders,
    COUNT(DISTINCT Customer_ID) AS unique_customers,
    SUM(Quantity) AS total_quantity,
    SUM(Sales) AS total_sales,
    SUM(Cost) AS total_cost,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY Channel
ORDER BY total_sales DESC;


-- 9.2 Channel Sales Contribution
SELECT
    Channel,
    SUM(Sales) AS total_sales,
    ROUND(
        SUM(Sales) /
        NULLIF((SELECT SUM(Sales) FROM sales_data), 0) * 100,
        2
    ) AS sales_contribution_percentage
FROM sales_data
GROUP BY Channel
ORDER BY total_sales DESC;


-- 9.3 Channel Profit Margin
SELECT
    Channel,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY Channel
ORDER BY profit_margin_percentage DESC;



-- 9.4 Average Order Value by Channel
SELECT
    Channel,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales,
    ROUND(
        SUM(Sales) / NULLIF(COUNT(DISTINCT Order_ID), 0),
        2
    ) AS average_order_value
FROM sales_data
GROUP BY Channel
ORDER BY average_order_value DESC;



-- 9.5 Customer Count by Channel
SELECT
    Channel,
    COUNT(DISTINCT Customer_ID) AS unique_customers
FROM sales_data
GROUP BY Channel
ORDER BY unique_customers DESC;

-- 9.6 Online vs Offline Customer Preference
SELECT
    Customer_ID,
    MAX(Customer_Name) AS Customer_Name,
    COUNT(DISTINCT Channel) AS channels_used
FROM sales_data
GROUP BY Customer_ID
ORDER BY channels_used DESC;


-- 9.7 Customers Using Both Channels
SELECT
    Customer_ID,
    MAX(Customer_Name) AS Customer_Name,
    SUM(Sales) AS total_sales
FROM sales_data
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Channel) = 2
ORDER BY total_sales DESC;

-- 9.8 Channel Performance by Region
SELECT
    Region,
    Channel,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY
    Region,
    Channel
ORDER BY
    Region,
    total_sales DESC;
    
    

-- 9.9 Best Channel in Each Region
WITH regional_channel AS (
    SELECT
        Region,
        Channel,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit
    FROM sales_data
    GROUP BY
        Region,
        Channel
),
ranked_channels AS (
    SELECT
        Region,
        Channel,
        total_sales,
        total_profit,
        ROW_NUMBER() OVER (
            PARTITION BY Region
            ORDER BY total_sales DESC
        ) AS channel_rank
    FROM regional_channel
)
SELECT
    Region,
    Channel,
    total_sales,
    total_profit
FROM ranked_channels
WHERE channel_rank = 1
ORDER BY Region;



-- ============================================================
-- 10. TIME-BASED ANALYSIS
-- ============================================================

10.1 Monthly Performance
SELECT
    MONTH(Order_Date) AS month_number,
    MONTHNAME(Order_Date) AS month_name,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Quantity) AS total_quantity,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY month_number;

This should be one of your core final-project queries.
10.2 Monthly Profit Margin
SELECT
    MONTH(Order_Date) AS month_number,
    MONTHNAME(Order_Date) AS month_name,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY month_number;

Now we can see whether profitability changes throughout the year.
10.3 Quarterly Performance
SELECT
    QUARTER(Order_Date) AS quarter,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY QUARTER(Order_Date)
ORDER BY quarter;

10.4 Best Sales Month
SELECT
    MONTH(Order_Date) AS month_number,
    MONTHNAME(Order_Date) AS month_name,
    SUM(Sales) AS total_sales
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY total_sales DESC
LIMIT 1;

10.5 Lowest Sales Month
SELECT
    MONTH(Order_Date) AS month_number,
    MONTHNAME(Order_Date) AS month_name,
    SUM(Sales) AS total_sales
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY total_sales
LIMIT 1;

10.6 Best Profit Month
SELECT
    MONTH(Order_Date) AS month_number,
    MONTHNAME(Order_Date) AS month_name,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY total_profit DESC
LIMIT 1;

-- 10.7 Monthly Sales Growth
WITH monthly_sales AS (
    SELECT
        MONTH(Order_Date) AS month_number,
        MONTHNAME(Order_Date) AS month_name,
        SUM(Sales) AS total_sales
    FROM sales_data
    GROUP BY
        MONTH(Order_Date),
        MONTHNAME(Order_Date)
),
monthly_comparison AS (
    SELECT
        month_number,
        month_name,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY month_number
        ) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    month_number,
    month_name,
    total_sales,
    previous_month_sales,
    ROUND(
        (total_sales - previous_month_sales)
        / NULLIF(previous_month_sales, 0) * 100,
        2
    ) AS month_over_month_growth_percentage
FROM monthly_comparison
ORDER BY month_number;



-- 10.8 Monthly Profit Growth
WITH monthly_profit AS (
    SELECT
        MONTH(Order_Date) AS month_number,
        MONTHNAME(Order_Date) AS month_name,
        SUM(Profit) AS total_profit
    FROM sales_data
    GROUP BY
        MONTH(Order_Date),
        MONTHNAME(Order_Date)
),
profit_comparison AS (
    SELECT
        month_number,
        month_name,
        total_profit,
        LAG(total_profit) OVER (
            ORDER BY month_number
        ) AS previous_month_profit
    FROM monthly_profit
)
SELECT
    month_number,
    month_name,
    total_profit,
    previous_month_profit,
    ROUND(
        (total_profit - previous_month_profit)
        / NULLIF(previous_month_profit, 0) * 100,
        2
    ) AS profit_growth_percentage
FROM profit_comparison
ORDER BY month_number;


-- 10.9 Running Total of Sales
WITH monthly_sales AS (
    SELECT
        MONTH(Order_Date) AS month_number,
        MONTHNAME(Order_Date) AS month_name,
        SUM(Sales) AS total_sales
    FROM sales_data
    GROUP BY
        MONTH(Order_Date),
        MONTHNAME(Order_Date)
)
SELECT
    month_number,
    month_name,
    total_sales,
    SUM(total_sales) OVER (
        ORDER BY month_number
    ) AS cumulative_sales
FROM monthly_sales
ORDER BY month_number;



-- 10.10 Monthly Sales Trend by Region
SELECT
    Region,
    MONTH(Order_Date) AS month_number,
    MONTHNAME(Order_Date) AS month_name,
    SUM(Sales) AS total_sales
FROM sales_data
GROUP BY
    Region,
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY
    Region,
    month_number;

-- 10.11 Monthly Sales by Channel
SELECT
    MONTH(Order_Date) AS month_number,
    MONTHNAME(Order_Date) AS month_name,
    Channel,
    SUM(Sales) AS total_sales
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date),
    Channel
ORDER BY
    month_number,
    Channel;


-- ============================================================
-- 11. PROFITABILITY ANALYSIS
-- ============================================================

-- 11.1 Overall Profitability
SELECT
    SUM(Sales) AS total_sales,
    SUM(Cost) AS total_cost,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data;

-- 11.2 Profitability by Category
SELECT
    Category,
    SUM(Sales) AS total_sales,
    SUM(Cost) AS total_cost,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY Category
ORDER BY total_profit DESC;

-- 11.3 Profitability by Region
SELECT
    Region,
    SUM(Sales) AS total_sales,
    SUM(Cost) AS total_cost,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY Region
ORDER BY total_profit DESC;


-- 1.4 Profitability by Product
SELECT
    Product,
    Category,
    SUM(Sales) AS total_sales,
    SUM(Cost) AS total_cost,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY
    Product,
    Category
ORDER BY total_profit DESC;

-- 11.5 Top 10 Most Profitable Products
SELECT
    Product,
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY
    Product,
    Category
ORDER BY total_profit DESC
LIMIT 10;

-- 11.6 Bottom 10 Products by Profit
SELECT
    Product,
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY
    Product,
    Category
ORDER BY total_profit
LIMIT 10;

-- 11.7 Loss-Making Products
SELECT
    Product,
    Category,
    SUM(Sales) AS total_sales,
    SUM(Cost) AS total_cost,
    SUM(Profit) AS total_profit
FROM sales_data
GROUP BY
    Product,
    Category
HAVING SUM(Profit) < 0
ORDER BY total_profit;



-- 11.8 Low-Margin Products

SELECT
    Product,
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY
    Product,
    Category
HAVING
    SUM(Profit) / NULLIF(SUM(Sales), 0) * 100 < 10
ORDER BY profit_margin_percentage;


-- 11.9 High-Sales but Low-Profit Products
WITH product_profitability AS (
    SELECT
        Product,
        Category,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit,
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100
            AS profit_margin_percentage
    FROM sales_data
    GROUP BY
        Product,
        Category
)
SELECT
    Product,
    Category,
    total_sales,
    total_profit,
    ROUND(profit_margin_percentage, 2) AS profit_margin_percentage
FROM product_profitability
WHERE profit_margin_percentage < 10
ORDER BY total_sales DESC;



-- 11.10 Profitability by Customer Segment
SELECT
    Customer_Segment,
    COUNT(DISTINCT Customer_ID) AS unique_customers,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY Customer_Segment
ORDER BY total_profit DESC;

-- 11.11 Profitability by Channel
SELECT
    Channel,
    SUM(Sales) AS total_sales,
    SUM(Cost) AS total_cost,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY Channel
ORDER BY total_profit DESC;

-- 11.12 Monthly Profitability
SELECT
    MONTH(Order_Date) AS month_number,
    MONTHNAME(Order_Date) AS month_name,
    SUM(Sales) AS total_sales,
    SUM(Cost) AS total_cost,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY month_number;






-- ============================================================
-- 12. ADVANCED BUSINESS ANALYSIS
-- ============================================================

-- 12.1 Customer Retention / Repeat Customer Analysis
-- Business question
-- How many customers made only one purchase, and how many became repeat customers?

WITH customer_orders AS (
    SELECT
        Customer_ID,
        COUNT(DISTINCT Order_ID) AS total_orders
    FROM sales_data
    GROUP BY Customer_ID
)
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_orders
GROUP BY
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;


-- 12.2 Repeat Customer Rate

WITH customer_orders AS (
    SELECT
        Customer_ID,
        COUNT(DISTINCT Order_ID) AS total_orders
    FROM sales_data
    GROUP BY Customer_ID
)
SELECT
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN total_orders > 1 THEN 1
            ELSE 0
        END
    ) AS repeat_customers,
    ROUND(
        SUM(
            CASE
                WHEN total_orders > 1 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS repeat_customer_percentage
FROM customer_orders;

-- 12.3 Customer Sales Concentration
-- How much of total sales comes from the top 10 customers?

WITH customer_sales AS (
    SELECT
        Customer_ID,
        SUM(Sales) AS total_sales
    FROM sales_data
    GROUP BY Customer_ID
),
ranked_customers AS (
    SELECT
        Customer_ID,
        total_sales,
        ROW_NUMBER() OVER (
            ORDER BY total_sales DESC
        ) AS customer_rank
    FROM customer_sales
)
SELECT
    SUM(total_sales) AS top_10_customer_sales,
    (
        SELECT SUM(Sales)
        FROM sales_data
    ) AS total_company_sales,
    ROUND(
        SUM(total_sales) /
        (SELECT SUM(Sales) FROM sales_data) * 100,
        2
    ) AS sales_contribution_percentage
FROM ranked_customers
WHERE customer_rank <= 10;


-- 12.4 High-Value Inactive Customers

-- Which valuable customers have not purchased recently?

WITH customer_summary AS (
    SELECT
        Customer_ID,
        MAX(Customer_Name) AS Customer_Name,
        MAX(Region) AS Region,
        COUNT(DISTINCT Order_ID) AS total_orders,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit,
        MAX(Order_Date) AS latest_order_date
    FROM sales_data
    GROUP BY Customer_ID
)
SELECT
    Customer_ID,
    Customer_Name,
    Region,
    total_orders,
    total_sales,
    total_profit,
    latest_order_date,
    DATEDIFF(
        (SELECT MAX(Order_Date) FROM sales_data),
        latest_order_date
    ) AS days_since_last_purchase
FROM customer_summary
WHERE total_sales > 50000
  AND latest_order_date < DATE_SUB(
        (SELECT MAX(Order_Date) FROM sales_data),
        INTERVAL 90 DAY
      )
ORDER BY total_sales DESC;


-- 12.5 Customer Purchase Gap Analysis

WITH customer_orders AS (
    SELECT
        Customer_ID,
        Order_ID,
        Order_Date,
        LAG(Order_Date) OVER (
            PARTITION BY Customer_ID
            ORDER BY Order_Date, Order_ID
        ) AS previous_order_date
    FROM sales_data
)
SELECT
    Customer_ID,
    Order_ID,
    Order_Date,
    previous_order_date,
    DATEDIFF(
        Order_Date,
        previous_order_date
    ) AS days_between_orders
FROM customer_orders
WHERE previous_order_date IS NOT NULL
ORDER BY Customer_ID, Order_Date;


-- 12.6 Top Product in Each Region
-- Business question
-- Which product generates the highest sales in each region?

WITH regional_products AS (
    SELECT
        Region,
        Product,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit
    FROM sales_data
    GROUP BY Region, Product
),
ranked_products AS (
    SELECT
        Region,
        Product,
        total_sales,
        total_profit,
        ROW_NUMBER() OVER (
            PARTITION BY Region
            ORDER BY total_sales DESC
        ) AS product_rank
    FROM regional_products
)
SELECT
    Region,
    Product,
    total_sales,
    total_profit
FROM ranked_products
WHERE product_rank = 1
ORDER BY Region;


-- 12.7 Product-Region Opportunity Analysis
-- Business question
-- Which product-region combinations have high sales but relatively weak profitability?

WITH product_region AS (
    SELECT
        Region,
        Product,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit,
        SUM(Profit) /
            NULLIF(SUM(Sales), 0) * 100
            AS profit_margin_percentage
    FROM sales_data
    GROUP BY Region, Product
)
SELECT
    Region,
    Product,
    total_sales,
    total_profit,
    ROUND(profit_margin_percentage, 2)
        AS profit_margin_percentage
FROM product_region
WHERE total_sales >
      (SELECT AVG(total_sales)
       FROM product_region)
  AND profit_margin_percentage < 20
ORDER BY total_sales DESC;


-- 12.8 Discount vs Profitability Analysis

SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.05 THEN '1-5%'
        WHEN Discount <= 0.10 THEN '6-10%'
        WHEN Discount <= 0.15 THEN '11-15%'
        ELSE 'Above 15%'
    END AS discount_band,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) /
        NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.05 THEN '1-5%'
        WHEN Discount <= 0.10 THEN '6-10%'
        WHEN Discount <= 0.15 THEN '11-15%'
        ELSE 'Above 15%'
    END
ORDER BY profit_margin_percentage DESC;



-- 12.9 Segment × Channel Analysis
-- Business question
-- Which customer segments perform best through each channel?

SELECT
    Customer_Segment,
    Channel,
    COUNT(DISTINCT Order_ID) AS total_orders,
    COUNT(DISTINCT Customer_ID) AS unique_customers,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND(
        SUM(Profit) /
        NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales_data
GROUP BY
    Customer_Segment,
    Channel
ORDER BY
    Customer_Segment,
    total_sales DESC;


-- 12.10 Monthly Performance — Best and Worst Months
WITH monthly_sales AS (
    SELECT
        MONTH(Order_Date) AS month_number,
        MONTHNAME(Order_Date) AS month_name,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit
    FROM sales_data
    GROUP BY
        MONTH(Order_Date),
        MONTHNAME(Order_Date)
)
SELECT
    month_number,
    month_name,
    total_sales,
    total_profit
FROM monthly_sales
ORDER BY total_sales DESC;

-- 12.11 Monthly Decline Analysis
-- Business question
-- Which months experienced a decline compared with the previous month?

WITH monthly_sales AS (
    SELECT
        MONTH(Order_Date) AS month_number,
        MONTHNAME(Order_Date) AS month_name,
        SUM(Sales) AS total_sales
    FROM sales_data
    GROUP BY
        MONTH(Order_Date),
        MONTHNAME(Order_Date)
),
monthly_comparison AS (
    SELECT
        month_number,
        month_name,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY month_number
        ) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    month_name,
    total_sales,
    previous_month_sales,
    ROUND(
        (total_sales - previous_month_sales)
        / NULLIF(previous_month_sales, 0) * 100,
        2
    ) AS growth_percentage
FROM monthly_comparison
WHERE total_sales < previous_month_sales
ORDER BY growth_percentage;


-- 12.12 Top Customers Within Each Region
WITH customer_region_sales AS (
    SELECT
        Region,
        Customer_ID,
        MAX(Customer_Name) AS Customer_Name,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit
    FROM sales_data
    GROUP BY
        Region,
        Customer_ID
),
ranked_customers AS (
    SELECT
        Region,
        Customer_ID,
        Customer_Name,
        total_sales,
        total_profit,
        DENSE_RANK() OVER (
            PARTITION BY Region
            ORDER BY total_sales DESC
        ) AS customer_rank
    FROM customer_region_sales
)
SELECT
    Region,
    Customer_ID,
    Customer_Name,
    total_sales,
    total_profit,
    customer_rank
FROM ranked_customers
WHERE customer_rank <= 3
ORDER BY Region, customer_rank;






-- ============================================================
-- 13. FINAL BUSINESS INSIGHTS
-- ============================================================


-- ============================================================
-- 14. BUSINESS RECOMMENDATIONS
-- ============================================================


