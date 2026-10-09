select version();
select "my sql is working" as status;


create database retail_sales;
use retail_sales;

select database();

CREATE TABLE sales_data (
    Order_ID INT,
    Order_Date DATE,
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Region VARCHAR(50),
    City VARCHAR(50),
    Product VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount DECIMAL(5,2),
    Sales DECIMAL(12,2),
    Cost DECIMAL(12,2),
    Profit DECIMAL(12,2),
    Channel VARCHAR(30),
    Payment_Method VARCHAR(30),
    Customer_Segment VARCHAR(30)
);

show tables;
describe sales_data;

ALTER TABLE sales_data
ADD COLUMN Month VARCHAR(20),
ADD COLUMN Month_Number INT,
ADD COLUMN Quarter VARCHAR(10),
ADD COLUMN Profit_Margin DECIMAL(10,2);

describe sales_data;

SELECT COUNT(*) AS total_records
FROM sales_data;


SELECT *
FROM sales_data
LIMIT 10;

SELECT
    MIN(Order_Date) AS First_Order_Date,
    MAX(Order_Date) AS Last_Order_Date
FROM sales_data;


SELECT
    Order_ID,
    Order_Date,
    Product,
    Category,
    Sales,
    Profit
FROM sales_data;


/* Find all orders where Sales are greater than 10,000.*/
select * 
from sales_data
where Sales>10000;


/*Q1. Show Order_ID, Product, Sales for orders where Sales are 
greater than 15,000.*/
select Order_ID,Product,Sales
from sales_data
where Sales>15000;


/*Q2. Show Order_ID, Region, Sales for orders from 
the North region.*/
select Order_ID,Region,Sales
from sales_data
where region="North";

/*Q3. Show Order_ID, Product, Profit where
 Profit is less than 1,000.*/
 
 select Order_ID, Product, Profit
 from sales_data
 where Profit<1000;



/*Q4. Show Order_ID, Product, Sales, Profit where:
Sales > 10,000
AND Profit > 2,000*/

select Order_ID, Product, Sales, Profit
from sales_data
where sales>10000 and Profit>2000


/* Q5. Show Order_ID, Region, Channel, Sales where
Region is West OR Channel is Online */

Select Order_ID, Region, Channel, Sales
from sales_data
where region="West" or Channel="Online";

/*Find all orders where the Region is either North or South AND Sales 
are greater than 10,000.*/
select order_id,Order_Date
from sales_data
where (region="North" or region="South") and Sales>10000;





/*ORDER BY + LIMIT + OFFSET*/


/*Find the 10 orders with the highest Sales.*/

select order_id
from sales_data
order by Sales Desc
limit 10;



/*Find the 5 orders with the lowest Profit.*/
select order_id,Profit
from sales_data
order by Profit
limit 5;

/*Find the 10 orders with the highest Sales from
 the East region.*/
select order_id,region,sales
from sales_data
where region="East"
order by Sales Desc
limit 10;


/*Find the 10 orders with the highest Profit.*/
select order_id
from sales_data
order by profit Desc
limit 10;

/*Find the orders ranked 11–20 by Sales,
 from highest to lowest.*/
select order_id
from sales_data
order by Sales Desc
limit 10 offset 10;


/*Find the 5 highest-Sales orders from the West region 
after skipping the top 5 West-region orders.*/
select order_id,Sales,region
from sales_data
where region="west"
order by Sales Desc
limit 5 offset 5;






/*Aggregate function*/

/* 1.sum() */

/*Q1 Find the total sales of all orders.*/
select sum(sales) as "total sales"
from sales_data;

/*Q2 Find the total profit of all orders.*/
select sum(profit) as "total profit"
from sales_data;


/*Q3 Find the total quantity sold.*/
select sum(Quantity) as "total quantity sold"
from sales_data;


/*Q4 Find the total sales from the North region.*/
select sum(sales) as "total North region sales"
from sales_data
where region="North"


/*Q5 Find the total profit from Online orders.*/
select sum(profit) as "total profit from online"
from sales_data
where Channel="Online";

/*Q6 — Challenge

Find these three KPIs in one query:

Total Sales
Total Profit
Total Quantity*/

select sum(sales) as"total sales" ,sum(profit) as "total profit",sum(Quantity) as "total quantity"
from sales_data;




/*2.COUNT()*/
/*Q1 Find the total number of orders.*/
select count(*) from sales_data;

/*Q2 Find the total number of customers using COUNT(Customer_ID).*/
select count(Customer_ID) from sales_data ;

/*Q3 Find the number of unique customers.*/
select count(distinct Customer_ID) 
from sales_data;

/*Q4 Find the number of orders from the East region.*/
select count(Order_ID)
from sales_data
where region='East';


/*Q5 Find the number of Online orders.*/
select count(*)
from sales_data
where channel='Online';


/*Q6 — Find the number of unique products in the dataset.*/
select count(distinct product) as 'unique product'
from sales_data;




/*3. Avg() */


/*Q1
Find the average sales of all orders.*/
select avg(sales) as "average sales"
from sales_data;


/*
Q2
Find the average profit of all orders.*/
select avg(profit) AS "average profit"
from sales_data;

/*
Q3
Find the average quantity sold per order.*/
select avg(Quantity) as "average quantity"
from sales_data;

/*Q4
Find the average sales for the North region.*/
select avg(sales) as "average sales from north "
from sales_data
where region='North';

/*
Q5
Find the average profit from Online orders.*/
select avg(profit) as "average profit from online order"
from sales_data
where channel='Online';



/*Q6 — Challenge
Find Average Sales, Average Profit, and Average Quantity in a
 single query*/
select avg(sales) as 'average sales',avg(profit)as 'averager profit',avg(quantity) as 'Average quantity'
from sales_data;



/*4. min() and max()*/

/*Q1 Find the minimum Sales.*/
select min(sales) as 'minimum sale'
from sales_data;

/*Q2 Find the maximum Sales.*/
select max(sales) as 'maximum sale'
from sales_data;


/*Q3
Find the minimum Profit.*/
select min(profit) as 'minimum profit'
from sales_data;

/*Q4
Find the maximum Profit.*/
select max(Profit) as 'maximum profit'
from sales_data;

/*Q5
Find the minimum Sales in the West region.*/
select min(sales) as 'minimum sale from west'
from sales_data
where region='West';

/*Q6
Find the maximum Profit from Online orders.*/
select max(profit) as 'maximum profit from online'
from sales_data;

/*Q7 — Challenge
Find minimum Sales, maximum Sales, average Sales, and
total Sales in one query.*/
select min(salas),max(sales),avg(sales),sum(sales)
from sales_data;






/*GROUP BY in SQL*/

/*Find the total sales for each Region.*/
select region,sum(sales) as 'Total sales'
from sales_data
group by Region;

/*Find the total number of orders for each Region.*/
select count(*),region
from sales_data
group by region;


/*Find the average sales for each Region.*/
select region,avg(sales)as 'average_sales'
from sales_data
group by region;

/*Find the total profit for each Region.*/
select sum(profit),region
from sales_data
group by region;

/*Find the minimum sales for each Category.*/
select min(sales),category
from sales_data
group by category;

/*Find the maximum profit for each Category.*/
select max(profit),category
from sales_data
group by category;

/*Find the number of orders for each Channel.*/
select count(*),channel
from sales_data
group by channel;

/*Find the total sales for each Customer Segment.*/
select sum(sales),Customer_Segment
from sales_data
group by Customer_Segment;


/*Find the total sales for each Region, but only 
for Online orders.*/

select sum(sales),region
from sales_data
where channel='Online'
group by region;


/*Find the total profit for each Category, but only for 
the West region.*/
select sum(profit),category
from sales_data
where region='west'
group by category;


/*Q9 — Multiple aggregates
Find the following for each Region:
- Number of orders
- Total sales
- Total profit
- Average sales*/

select count(*),sum(sales),sum(profit),avg(sales),region
from sales_data
group by region;


/*Q10 — Multiple columns in GROUP BY
Find total sales for each Region and Category combination.*/
select sum(sales),region,category
from sales_data
group by region,category;


/*Find number of orders, total sales, and 
total profit for each Channel and Customer Segment combination.*/
select count(*),sum(sales),sum(profit),channel,customer_segment
from sales_data
group by channel,customer_segment;


/*Q12 — Project-style question
Management wants a regional performance summary. 
Find for each Region:
Total Orders
Total Quantity
Total Sales
Total Profit
Average Sales
Minimum Sales
Maximum Sales*/

select region,count(*) as 'total_orders',sum(quantity)as "Total Quantity",
sum(sales)as 'total_sales',sum(profit)as 'total_profit',avg(sales)as 'average sales',
min(sales)as 'minimum sales',max(sales) as 'maximum_sales'
from sales_data
group by region;




/*Having */

/*Q1
Find regions whose total sales are greater than 100,000.*/
select region,sum(sales)
from sales_data
group by region
having sum(sales)>100000;

/*Q2
Find categories whose total profit is greater than 50,000.*/
select category,sum(profit)
from sales_data
group by Category
having sum(Profit)>50000;

/*Q3 Find channels having more than 400 orders.*/
select channel,count(*)
from sales_data
group by Channel
having count(*)>400;

/*Q4
Find customer segments whose average sales are greater t
han 10,000.*/
select Customer_Segment,avg(sales)
from sales_data
group by Customer_Segment
having avg(sales)>10000;


/*Q5
Find regions whose maximum profit is greater than 5,000.*/
select region,max(profit)
from sales_data
group by region
having max(Profit)>5000;

/*Q6
Find categories whose minimum sales are greater than 1,000.*/
select category,min(sales)
from sales_data
group by Category
having min(sales)>1000;

/*Q7
Find regions whose Online total sales are greater than 50,000.*/
select region,sum(sales)
from sales_data
where channel='Online'
group by region
having sum(sales)>50000;

/*Q8
Find categories in the West region whose 
total profit is greater than 20,000.*/
select category,sum(profit) as total_profit,region
from sales_data
where region='West'
group by Category
having sum(Profit)>50000;


/*Q9
For each region, find:
- Total Orders
- Total Sales
- Total Profit
Then show only regions where:
- Total Sales > 100,000
- Total Profit > 20,000*/

select region,sum(profit) as total_profit,sum(sales)as total_sales,count(*) as total_orders
from sales_data
group by region
having sum(Profit)>20000 and sum(sales)>100000;



/*Q10 — Important
Find each Channel + Customer Segment combination where 
the total sales are greater than 50,000.*/

select Channel,Customer_Segment,sum(sales)as total_sales
from sales_data
group by Channel,Customer_Segment
having sum(sales)>50000;

/*Q11 — Interview-style
Find each Region where:
- number of orders > 200
- average sales > 8,000*/

select region,count(*),avg(sales) as average_sales
from sales_data
group by region
having count(*)>200 and  avg(sales)>8000;

/*Q12 — Project-style
For each Region calculate:
- Total Orders
- Total Quantity
- Total Sales
- Total Profit*/

select region,sum(profit)as 'total_profit',count(*)as 'total orders',
sum(Quantity)as 'total_quantity',sum(Sales) as 'total_sales'
from sales_data
group by region
having sum(sales)>100000 and sum(profit)>20000;




/*Q1
Display all unique regions.*/
select distinct region
from sales_data;


/*Q2
Display all unique categories.*/

/*
Q3
Display all unique sales channels.*/
select distinct Channel
from sales_data;

/*Q4
Display all unique payment methods.*/
select distinct Payment_Method
from sales_data;

/*Q5
Display all unique customer segments.*/
select distinct Customer_Segment
from sales_data;

-- Q6
-- Display all unique products.
select distinct Product
from sales_data;

/*Q7
Display all unique cities.*/
select distinct City
from sales_data;


/*Q8
Display unique Region + Category combinations.*/
select distinct region,Category
from sales_data;

-- Q9
-- Display unique Region + Channel combinations.
select distinct region,Channel
from sales_data;


-- Q10-- 
-- Display unique Customer Segment + Payment Method combinations.
select distinct Customer_Segment,Payment_Method
from sales_data;

-- Q11
-- Find the total number of unique customers.
SELECT COUNT(DISTINCT Customer_ID) AS Unique_Customers
FROM sales_data;

-- Q12
-- Find the total number of unique products.
SELECT count(distinct Product)
FROM sales_data;

-- Q13
-- Find the total number of unique cities.
SELECT count(distinct City)
FROM sales_data;

-- Q14
-- Find the total number of unique customers who 
-- purchased through the Online channel.
SELECT count(distinct Customer_ID)
FROM sales_data
where Channel='Online';

-- Q15
-- Find the unique products sold in the West region.
SELECT distinct Product
FROM sales_data
where region='West';

-- Q16
-- Find the unique categories sold through the Online channel.
SELECT distinct Category
FROM sales_data
where Channel='Online';


-- Q17
-- Display unique products sold in the East region, 
-- sorted alphabetically.
SELECT distinct Product
FROM sales_data
where Region='east';


-- Q18
-- Display the first 10 unique products alphabetically.
SELECT distinct Product
FROM sales_data
order by product
limit 10;


-- Q19
-- Find the number of unique customers in each region.
-- Hint: This one requires GROUP BY.
SELECT count(distinct Customer_ID),region
FROM sales_data
group by region

/*Q20 Project-level
Create a summary showing each Region and the number of 
unique customer in that region*/

SELECT region,count(distinct customer_id)
FROM sales_data
group by region;







/*CASE*/

/*Q1
Display Order_ID, Sales, and create a new column Sales_Level:
- Sales > 15,000 → 'High'
- Otherwise → 'Low'*/

select sales,order_id,
case
	when sales>1500 then 'high'
	else 'low'
end as "sales level"
from sales_data;

-- Q2
-- Display Order_ID, Profit, and create Profit_Level:
-- - Profit >= 5,000 → 'High'
-- - Profit >= 2,000 → 'Medium'
-- - Otherwise → 'Low'
select profit,order_id,
case
	when profit>=5000 then 'high'
    when profit>=2000 then 'Medium'
	else 'low'
end as "profit level"
from sales_data;


Q5
Display Order_ID, Profit, and create Profit_Status:
- Profit > 0 → 'Profitable'
- Otherwise → 'Not Profitable'
select profit,order_id,
case
	when profit>0 then 'profitable'
	else 'not_profitable'
end as "profit_status"
from sales_data;

-- Q6
-- Display Order_ID, Channel, and create Channel_Type:
-- - Online → 'Digital'
-- - Store → 'Physical'
-- Use ELSE 'Other' as well.
select channel,order_id,
case
	when Channel='Online' then 'digital'
    when channel='Store' then 'Physical'
	else 'other'
end as "channel type"
from sales_data;

-- Q7
-- Display Order_ID, Region, and create Region_Group:
-- - North or West → 'Group 1'
-- - South or East → 'Group 2'

select region,order_id,
case
	when region in ('North','West') then 'Group 1'
    when region in('South','East') then 'Group 2'
end as "region_group"
from sales_data;


-- Q10 — Slightly harder
-- Display:
-- - Order_ID
-- - Region
-- - Channel
-- - Create Order_Category
SELECT
    Order_ID,
    Region,
    Channel,
    CASE
        WHEN Region = 'North' AND Channel = 'Online'
            THEN 'North Online'

        WHEN Region = 'North' AND Channel = 'Store'
            THEN 'North Store'

        WHEN Region = 'South' AND Channel = 'Online'
            THEN 'South Online'

        WHEN Region = 'South' AND Channel = 'Store'
            THEN 'South Store'

        ELSE 'Other'
    END AS Order_Category
FROM sales_data;


-- Q1 — Monthly Sales
-- Using Order_Date, find the total sales for each month.
-- Display:
-- - Month number
-- - Month name
-- - Total Sales
-- Make sure the months appear in January → December order, not alphabetical order.
SELECT
    MONTH(Order_Date) AS Month_Number,
    MONTHNAME(Order_Date) AS Month_Name,
    SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY Month_Number;



-- Q2 — Monthly Performance
-- Using Order_Date, create a monthly performance summary showing:
-- - Month number
-- - Month name
-- - Total Orders
-- - Total Sales
-- - Total Profit
-- Sort the result chronologically.
SELECT
    MONTH(Order_Date) AS Month_Number,
    MONTHNAME(Order_Date) AS Month_Name,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY Month_Number;


-- Q3 — Quarterly Performance
-- Using Order_Date, calculate for each quarter:
-- - Quarter
-- - Total Orders
-- - Total Sales
-- - Total Profit
-- Display Q1 → Q4 in order.
select quarter(order_date),count(*),sum(sales),sum(profit)
from sales_data
group by quarter(order_date)
order by quarter(order_date);



-- Q4 — Highest Sales Month
-- Find which month generated the highest total sales.
-- Display:
-- - Month number
-- - Month name
-- - Total Sales
-- Return only the highest-sales month.
SELECT
    MONTH(Order_Date) AS Month_Number,
    MONTHNAME(Order_Date) AS Month_Name,
    SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY Total_Sales DESC
LIMIT 1;

-- Q5 — Lowest Profit Month
-- Find which month generated the lowest total profit.
-- Display:
-- - Month number
-- - Month name
-- - Total Profit
-- Return only the lowest-profit month.

SELECT
    MONTH(Order_Date) AS Month_Number,
    MONTHNAME(Order_Date) AS Month_Name,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY Total_Profit
LIMIT 1;



/*Subquery*/


/*Q1 — Above Average Sales
Find all orders where Sales is greater than the overall average Sales.*/
select *
from sales_data
where sales> 
			(select avg(sales) from sales_data);
            
/*Next: Q2 — Above Average Profit
Find all orders where Profit is greater than the overall average Profit.
Display:
- Order_ID
- Product
- Profit
Use a single-value subquery.*/
select order_id,product,sales
from sales_data
where profit > (select avg(profit) from sales_data)


-- Q3 — Highest Sales Order
-- Find the order(s) having the maximum Sales in the entire dataset.
-- Display:
-- - Order_ID
-- - Product
-- - Sales
-- Concept: MAX() + single-value subquery.

SELECT Order_ID, Product, Sales
FROM sales_data
WHERE Sales = (
    SELECT MAX(Sales)
    FROM sales_data);
    
-- Q4 — Highest Profit Order
-- Find the order(s) having the maximum Profit.
-- Display:
-- - Order_ID
-- - Product
-- - Profit
-- Concept: MAX() + subquery.
SELECT Order_ID, Product, Profit
FROM sales_data
WHERE Profit = (
    SELECT MAX(Profit)
    FROM sales_data
);
SELECT Region, SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Region
HAVING SUM(Sales) > (
    SELECT AVG(Region_Sales)
    FROM (
        SELECT Region, SUM(Sales) AS Region_Sales
        FROM sales_data
        GROUP BY Region
    ) AS Regional_Summary
);
-- Q5 — Region Above Average Sales
-- Find the regions whose total sales are greater than the overall average regional sales.
-- Display:
-- - Region
-- - Total Sales
-- This is important because it combines:
-- - GROUP BY
-- - SUM()
-- - subquery
-- - comparison
SELECT Region, SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Region
HAVING SUM(Sales) > (
    SELECT AVG(Region_Sales)
    FROM (
        SELECT Region, SUM(Sales) AS Region_Sales
        FROM sales_data
        GROUP BY Region
    ) AS Regional_Summary
);


-- Q6 — Categories Above Average Profit
-- Find the categories whose total profit is greater than the average profit across all categories.
-- Display:
-- - Category
-- - Total Profit
-- This is another important group-level subquery for your project.
SELECT Category, SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Category
HAVING SUM(Profit) > (
    SELECT AVG(Category_Profit)
    FROM (
        SELECT Category, SUM(Profit) AS Category_Profit
        FROM sales_data
        GROUP BY Category
    ) AS Category_Summary
);


-- Q7 — Products With Sales Above Average Product Sales
-- Calculate total sales for each product and return only products whose total sales are greater than the average total sales across all products.
-- Display:
-- - Product
-- - Total Sales
-- This is a more realistic Data Analyst problem because the comparison is product-level, not transaction-level.

SELECT Product, SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Product
HAVING SUM(Sales) > (
    SELECT AVG(Product_Sales)
    FROM (
        SELECT Product, SUM(Sales) AS Product_Sales
        FROM sales_data
        GROUP BY Product
    ) AS Product_Summary
);

/*Q8 — Regions With Above-Average Order Count
Find regions whose number of orders is greater than the average number of orders per region.
Display:
- Region
- Total Orders
This will make you think carefully about aggregation inside a subquery.
*/
SELECT Region, COUNT(*) AS Total_Orders
FROM sales_data
GROUP BY Region
HAVING COUNT(*) > (
    SELECT AVG(Region_Orders)
    FROM (
        SELECT Region, COUNT(*) AS Region_Orders
        FROM sales_data
        GROUP BY Region
    ) AS Region_Summary
);


/*IN, EXISTS, ANY, ALL*/
/*Q1: Find all orders belonging to regions whose total sales are greater than ₹100,000.
Display:
- Order_ID
- Region
- Product
- Sales*/
select order_id,region,product,Sales
from sales_data
where region in (select region 
				from sales_data 
                group by region
				having sum(sales)>100000);
                
/*EXISTS — Project Question
Q2: Find customers who have made at least one Online order.
Display:
- Customer_ID
- Customer_Name
Use EXISTS.
ANY — Project Question*/
SELECT DISTINCT Customer_ID, Customer_Name
FROM sales_data s
WHERE EXISTS (
    SELECT 1
    FROM sales_data o
    WHERE o.Customer_ID = s.Customer_ID
      AND o.Channel = 'Online'
);
/*
Q3: Find orders whose Sales are greater than at least one category's average Sales.
Display:
- Order_ID
- Product
- Sales
Use ANY with a subquery.
ALL — Project Question*/
SELECT Order_ID, Product, Sales
FROM sales_data
WHERE Sales > ANY (
    SELECT AVG(Sales)
    FROM sales_data
    GROUP BY Category
);





/*Q4: Find orders whose Sales are greater than every category's average Sales.
Display:
- Order_ID
- Product
- Sales
Use ALL with a subquery.
One combined analyst problem*/
SELECT Order_ID, Product, Sales
FROM sales_data
WHERE Sales > ALL (
    SELECT AVG(Sales)
    FROM sales_data
    GROUP BY Category
);



/*Q5: Find products whose total Sales are greater than at least one region's total Sales.
Display:
- Product
- Total Sales
Use:
- GROUP BY
- ANY
- Subquery*/
SELECT Product, SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Product
HAVING SUM(Sales) > ANY (
    SELECT SUM(Sales)
    FROM sales_data
    GROUP BY Region
);



/*JOIN*/

Q1. Using sales_data twice with different aliases, join the table based on Customer_ID. Display:
SELECT
    s1.Customer_ID,
    s1.Customer_Name,
    s2.Order_ID,
    s2.Sales
FROM sales_data s1
INNER JOIN sales_data s2
    ON s1.Customer_ID = s2.Customer_ID;


Q2. Join sales_data with itself using Product as the matching column. Display:    
SELECT
    s1.Product,
    s1.Order_ID,
    s2.Sales
FROM sales_data s1
INNER JOIN sales_data s2
    ON s1.Product = s2.Product;



Q3. Using a self-join, find pairs of orders that belong to the same customer. Display:    
SELECT
    s1.Customer_ID,
    s1.Order_ID AS First_Order_ID,
    s2.Order_ID AS Second_Order_ID
FROM sales_data s1
INNER JOIN sales_data s2
    ON s1.Customer_ID = s2.Customer_ID
   AND s1.Order_ID < s2.Order_ID;


Q4. Using a self-join, find pairs of orders where:
- Same Region   
SELECT
    s1.Region,
    s1.Order_ID AS First_Order_ID,
    s2.Order_ID AS Second_Order_ID
FROM sales_data s1
INNER JOIN sales_data s2
    ON s1.Region = s2.Region
   AND s1.Order_ID < s2.Order_ID;
   
   
Q5. Project-style:
Using a self-join on Customer_ID, find customers who have more than one order.
Display:
- Customer_ID
- Customer_Name   
SELECT DISTINCT
    s1.Customer_ID,
    s1.Customer_Name
FROM sales_data s1
INNER JOIN sales_data s2
    ON s1.Customer_ID = s2.Customer_ID
   AND s1.Order_ID <> s2.Order_ID;
   
Q6. Project-style:
Using a self-join, find pairs of orders from the same region where the first order has higher Sales than the second order.
Display:
- Region
- First Order_ID
- First Sales
- Second Order_ID
- Second Sales
Important
SELECT DISTINCT
    s1.Customer_ID,
    s1.Customer_Name
FROM sales_data s1
INNER JOIN sales_data s2
    ON s1.Customer_ID = s2.Customer_ID
   AND s1.Order_ID <> s2.Order_ID;
   
   


/*Q1 — Basic INNER JOIN
Find:
- Order_ID
- Product
- Sales
- Customer_Name
Join sales_data with customers.*/
SELECT
    s.Order_ID,
    s.Product,
    s.Sales,
    c.Customer_Name
FROM sales_data s
INNER JOIN customers c
    ON s.Customer_ID = c.Customer_ID;

-- Q2 — Customer location
-- Find:
-- - Order_ID
-- - Customer_Name
-- - City
-- - Region
-- - Sales
-- Use INNER JOIN.
SELECT
    s.Order_ID,
    c.Customer_Name,
    c.City,
    c.Region,
    s.Sales
FROM sales_data s
INNER JOIN customers c
    ON s.Customer_ID = c.Customer_ID;

/*Q3 — Online customers
Find all Online orders with:
- Order_ID
- Customer_ID
- Customer_Name
- Product
- Sales
- City
Use INNER JOIN + WHERE.*/
SELECT
    s.Order_ID,
    s.Customer_ID,
    c.Customer_Name,
    s.Product,
    s.Sales,
    c.City
FROM sales_data s
INNER JOIN customers c
    ON s.Customer_ID = c.Customer_ID
WHERE s.Channel = 'Online';
Q4 — Customer segment performance
Find:
- Customer_Segment
- Total Orders
- Total Sales
- Total Profit
Use INNER JOIN + GROUP BY.
SELECT
    c.Customer_Segment,
    COUNT(*) AS Total_Orders,
    SUM(s.Sales) AS Total_Sales,
    SUM(s.Profit) AS Total_Profit
FROM sales_data s
INNER JOIN customers c
    ON s.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Segment;

-- Q5 — Regional customer analysis
-- Find:
-- - Region
-- - Number of Orders
-- - Total Sales
-- - Total Profit
-- Use the customers table's Region and aggregate the sales data.
SELECT
    c.Region,
    COUNT(*) AS Total_Orders,
    SUM(s.Sales) AS Total_Sales,
    SUM(s.Profit) AS Total_Profit
FROM sales_data s
INNER JOIN customers c
    ON s.Customer_ID = c.Customer_ID
GROUP BY c.Region;


Q6 — Business question
Which customer cities generated the highest total sales?

Display:
- City
- Total Sales
Sort from highest to lowest.
SELECT
    c.City,
    SUM(s.Sales) AS Total_Sales
FROM sales_data s
INNER JOIN customers c
    ON s.Customer_ID = c.Customer_ID
GROUP BY c.City
ORDER BY Total_Sales DESC;


Q7 — Slightly advanced
Find:
Customer segments with total sales greater than 100,000.

Display:
- Customer_Segment
- Total_Sales
Use:
INNER JOIN
+
GROUP BY
+
HAVING
+
ORDER BY
SELECT
    c.Customer_Segment,
    SUM(s.Sales) AS Total_Sales
FROM sales_data s
INNER JOIN customers c
    ON s.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Segment
HAVING SUM(s.Sales) > 100000
ORDER BY Total_Sales DESC;


Q8 — Project-level
Find the top 10 customers by total sales.
Display:
- Customer_ID
- Customer_Name
- Total_Sales*/
SELECT
    s.Customer_ID,
    c.Customer_Name,
    SUM(s.Sales) AS Total_Sales
FROM sales_data s
INNER JOIN customers c
    ON s.Customer_ID = c.Customer_ID
GROUP BY
    s.Customer_ID,
    c.Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;





/*
Q1
Question:
The company wants to generate a report containing every order along with the name of the customer who placed it. Orders should not be removed from the report even if corresponding customer information is unavailable.
*/
SELECT
    s.Order_ID,
    s.Customer_ID,
    s.Product,
    s.Sales,
    c.Customer_Name
FROM sales_data s
LEFT JOIN customers c
    ON s.Customer_ID = c.Customer_ID;
    
    
/*Q2
Question:
The data team wants to identify orders for which customer information is missing from the customer master table.
*/
SELECT
    s.Order_ID,
    s.Customer_ID,
    s.Product,
    s.Sales
FROM sales_data s
LEFT JOIN customers c
    ON s.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;

/*Q3
Question:
The company wants a customer activity report that includes every registered customer, along with any orders they have placed. Customers who have never placed an order should also appear in the report.
*/
SELECT
    c.Customer_ID,
    c.Customer_Name,
    s.Order_ID,
    s.Product,
    s.Sales
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID;
    
Q4
Question:
The marketing team wants to identify customers who have registered with the company but have never made a purchase.
Answer
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    c.Region
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
WHERE s.Customer_ID IS NULL;

/*Q5
Question:
Management wants a customer-wise sales report showing every registered customer and the total amount they have purchased. Customers who have not purchased anything should still be included.
*/
SELECT
    c.Customer_ID,
    c.Customer_Name,
    COALESCE(SUM(s.Sales), 0) AS Total_Sales
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name;
    
Q6
Question:
The company wants to identify customers who have generated no sales so that the marketing team can target them with promotional campaigns.
Answer
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    c.Region
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    c.Region
HAVING COALESCE(SUM(s.Sales), 0) = 0;


-- Q7
-- Question:
-- The business wants to compare customer activity across regions. Prepare a report showing every region, the number of registered customers, the number of orders placed, and the total sales generated.

SELECT
    c.Region,
    COUNT(DISTINCT c.Customer_ID) AS Registered_Customers,
    COUNT(s.Order_ID) AS Total_Orders,
    COALESCE(SUM(s.Sales), 0) AS Total_Sales
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
GROUP BY c.Region;





/*The business suspects that some customers in the customer master database are inactive. Find all registered customers who have no orders at all, along with their customer name, city, region, and customer segment.
*/
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    c.Region,
    c.Customer_Segment
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
WHERE s.Customer_ID IS NULL;


/*Rightjoin*/


/*Q1
Question:
The company wants a report containing every registered customer and any orders associated with that customer. Customers without orders must also appear.
*/
SELECT
    c.Customer_ID,
    c.Customer_Name,
    s.Order_ID,
    s.Product,
    s.Sales
FROM sales_data s
RIGHT JOIN customers c
    ON s.Customer_ID = c.Customer_ID;



/*Q2 Question:The marketing team wants to identify customers 
who are registered in the customer database but have never placed an order.
*/
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    c.Region
FROM sales_data s
RIGHT JOIN customers c
    ON s.Customer_ID = c.Customer_ID
WHERE s.Customer_ID IS NULL;


-- Q3
-- Question:
-- Management wants a customer-wise report showing every registered customer and the total sales generated by each customer, including customers who have generated no sales.
SELECT
    c.Customer_ID,
    c.Customer_Name,
    COALESCE(SUM(s.Sales), 0) AS Total_Sales
FROM sales_data s
RIGHT JOIN customers c
    ON s.Customer_ID = c.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name;


/*Q4 Question:
The company wants to determine whether any registered customers have no transaction records in the sales database.
*/
SELECT
    c.Customer_ID,
    c.Customer_Name
FROM sales_data s
RIGHT JOIN customers c
    ON s.Customer_ID = c.Customer_ID
WHERE s.Order_ID IS NULL;


/*Q5
Question:
Management wants to compare the number of orders and total sales generated by each customer segment while ensuring that all registered customers are considered.
*/
SELECT
    c.Customer_Segment,
    COUNT(s.Order_ID) AS Total_Orders,
    COALESCE(SUM(s.Sales), 0) AS Total_Sales
FROM sales_data s
RIGHT JOIN customers c
    ON s.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Segment;

-- Q6 — Project-level
-- Question:
-- The marketing department wants a list of inactive registered customers so that promotional campaigns can be targeted specifically at customers who have never purchased anything.

SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    c.Region,
    c.Customer_Segment
FROM sales_data s
RIGHT JOIN customers c
    ON s.Customer_ID = c.Customer_ID
WHERE s.Order_ID IS NULL;





-- Q1
-- Question:
-- The data team wants to create a reconciliation report containing every customer from the customer master and every customer ID appearing in the transaction data. Matching records should be combined, while unmatched records from either dataset should also be retained.

SELECT
    c.Customer_ID AS Customer_Master_ID,
    c.Customer_Name,
    s.Customer_ID AS Sales_Customer_ID,
    s.Order_ID,
    s.Sales
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID

UNION

SELECT
    c.Customer_ID AS Customer_Master_ID,
    c.Customer_Name,
    s.Customer_ID AS Sales_Customer_ID,
    s.Order_ID,
    s.Sales
FROM customers c
RIGHT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID;

-- Q2
-- Question:
-- The data-quality team wants to identify customers who are present in the customer master but have no transaction records, as well as transaction records whose customer IDs are missing from the customer master.

SELECT
    c.Customer_ID AS Customer_Master_ID,
    s.Customer_ID AS Sales_Customer_ID,
    c.Customer_Name,
    s.Order_ID
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
WHERE s.Customer_ID IS NULL

UNION

SELECT
    c.Customer_ID AS Customer_Master_ID,
    s.Customer_ID AS Sales_Customer_ID,
    c.Customer_Name,
    s.Order_ID
FROM customers c
RIGHT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
WHERE c.Customer_ID IS NULL;


-- Q3
-- Question:
-- The business wants to classify every customer ID according to whether it exists in both datasets, only in the customer master, or only in the transaction data.
SELECT
    COALESCE(c.Customer_ID, s.Customer_ID) AS Customer_ID,
    CASE
        WHEN c.Customer_ID IS NOT NULL
             AND s.Customer_ID IS NOT NULL
            THEN 'Both Tables'

        WHEN c.Customer_ID IS NOT NULL
            THEN 'Customer Master Only'

        WHEN s.Customer_ID IS NOT NULL
            THEN 'Sales Data Only'
    END AS Record_Status
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID

UNION

SELECT
    COALESCE(c.Customer_ID, s.Customer_ID) AS Customer_ID,
    CASE
        WHEN c.Customer_ID IS NOT NULL
             AND s.Customer_ID IS NOT NULL
            THEN 'Both Tables'

        WHEN c.Customer_ID IS NOT NULL
            THEN 'Customer Master Only'

        WHEN s.Customer_ID IS NOT NULL
            THEN 'Sales Data Only'
    END AS Record_Status
FROM customers c
RIGHT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID;



/*Q4 — Project-Level
Question:
The company wants to perform a complete customer-data reconciliation before building its final dashboard. Identify all customer IDs that do not have a corresponding record in both datasets.
*/
SELECT
    COALESCE(c.Customer_ID, s.Customer_ID) AS Customer_ID,
    CASE
        WHEN c.Customer_ID IS NULL THEN 'Sales Data Only'
        WHEN s.Customer_ID IS NULL THEN 'Customer Master Only'
    END AS Missing_From
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
WHERE s.Customer_ID IS NULL

UNION

SELECT
    COALESCE(c.Customer_ID, s.Customer_ID) AS Customer_ID,
    CASE
        WHEN c.Customer_ID IS NULL THEN 'Sales Data Only'
        WHEN s.Customer_ID IS NULL THEN 'Customer Master Only'
    END AS Missing_From
FROM customers c
RIGHT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
WHERE c.Customer_ID IS NULL;


/*Q5 — Understand the FULL JOIN result
Question:
The analyst wants to see every customer ID and determine whether the customer has a matching transaction record. The report should retain unmatched records from either side.
*/
SELECT
    COALESCE(c.Customer_ID, s.Customer_ID) AS Customer_ID,
    c.Customer_Name,
    s.Order_ID,
    s.Sales
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID

UNION

SELECT
    COALESCE(c.Customer_ID, s.Customer_ID) AS Customer_ID,
    c.Customer_Name,
    s.Order_ID,
    s.Sales
FROM customers c
RIGHT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID;
    
    
    
/*SELF join*/

-- Q1
-- Question:
-- A company stores employees and their manager IDs in the same employee table. The HR team wants a report showing each employee along with the name of their manager.

SELECT
    e.Employee_Name AS Employee,
    m.Employee_Name AS Manager
FROM employees e
LEFT JOIN employees m
    ON e.Manager_ID = m.Employee_ID;


/*Q2
Question:
The HR team wants to find all employees who report directly to a particular manager.
*/
SELECT
    e.Employee_ID,
    e.Employee_Name
FROM employees e
JOIN employees m
    ON e.Manager_ID = m.Employee_ID
WHERE m.Employee_Name = 'Amit';


/*Q3
Question:
Management wants to see every employee and their manager employee ID, including employees who do not have a manager.
*/
SELECT
    e.Employee_ID,
    e.Employee_Name,
    e.Manager_ID,
    m.Employee_ID AS Manager_Employee_ID,
    m.Employee_Name AS Manager_Name
FROM employees e
LEFT JOIN employees m
    ON e.Manager_ID = m.Employee_ID;


/*Q4 — Interview-style
Question:
A company has an employee table where Manager_ID refers to another employee in the same table. What SQL technique should be used to display the employee name alongside their managers name
SELF JOIN*/
SELECT
    e.Employee_Name AS Employee,
    m.Employee_Name AS Manager
FROM employees e
LEFT JOIN employees m




-- Project Question 1
-- Business question:
-- Management wants to see every possible combination of customer segment and sales target so they can evaluate different target scenarios.

SELECT
    c.Customer_Segment,
    t.Target_Level,
    t.Target_Amount
FROM (
    SELECT DISTINCT Customer_Segment
    FROM customers
) c
CROSS JOIN sales_targets t;


-- Project Question 2
-- Business question:
-- The sales team wants to create a planning sheet containing every region and every possible target level.
SELECT
    r.Region,
    t.Target_Level,
    t.Target_Amount
FROM (
    SELECT DISTINCT Region
    FROM sales_data
) r
CROSS JOIN sales_targets t;



/*Project Question 3
Business question:
Management wants to prepare a planning matrix containing every customer segment and every sales channel, regardless of whether that combination currently exists in the sales data.
*/
SELECT
    c.Customer_Segment,
    ch.Channel
FROM (
    SELECT DISTINCT Customer_Segment
    FROM customers
) c
CROSS JOIN (
    SELECT DISTINCT Channel
    FROM sales_data
) ch;



/*Union and Union all*/
-- Question 1
-- The business team wants one consolidated list of all customer IDs appearing either in the sales transactions or in the registered customer master, without showing the same customer more than once.
SELECT Customer_ID
FROM sales_data

UNION

SELECT Customer_ID
FROM customers;

/*Question 2
The data team wants to see every occurrence of customer IDs from both sources, including repeated IDs, because they want to investigate how frequently each ID appears across the two datasets.
Answer*/

select Customer_id
from sales_data

union all
select Customer_id
from customers;



/*Question 2
Question 3
Management wants a consolidated list containing all regions represented in either the 
sales transactions or the customer master, with each region appearing only once.r*/
SELECT Region
FROM sales_data

UNION

SELECT Region
FROM customers;


/*Question 4
The company wants to identify customers who exist in the customer master but never appear in sales transactions.
This is an important business question because these customers could be targeted for marketing.*/
SELECT Customer_ID
FROM customers

UNION

SELECT Customer_ID
FROM sales_data;


/*Question 5 — Business Scenario
The company has two lists of customers from different sources. The management team wants a single master list of customer IDs, 
and duplicate IDs should appear only once.*/

SELECT Customer_ID
FROM customers

UNION

SELECT Customer_ID
FROM sales_data;







/*union order by*/
/*Question 1
The marketing team wants one list containing customers who either made an Online purchase or are registered as Premium customers.
 Each customer should appear only once.*/
SELECT DISTINCT Customer_ID
FROM sales_data
WHERE Channel = 'Online'

UNION

SELECT Customer_ID
FROM customers
WHERE Customer_Segment = 'Premium';



Q/*uestion 2
The company wants a consolidated list of all regions appearing in either dataset, sorted alphabetically.
*/
SELECT Region
FROM sales_data

UNION

SELECT Region
FROM customers

ORDER BY Region;


-- Question 3
-- The management team wants to combine the customer IDs from the two sources while preserving every occurrence, because the frequency of appearance needs to be analyzed later.
SELECT Customer_ID
FROM sales_data

UNION ALL

SELECT Customer_ID
FROM customers;

-- Question 4
-- The company wants a consolidated list of customers who either purchased through the Online channel or belong to the Corporate segment, with the customer name included.
SELECT Customer_ID, Customer_Name
FROM sales_data
WHERE Channel = 'Online'

UNION

SELECT Customer_ID, Customer_Name
FROM customers
WHERE Customer_Segment = 'Corporate'
ORDER BY Customer_Name;





/*WINDOWS FUNCTION*/
/*Example A — Total company sales beside every order*/
select sales,
sum(Sales) over () as "total ccompany sales"
from sales_data;



/*Example B — Regional sales beside every order*/
select customer_id,sales,region,
sum(sales) over(
				partition by region) as "region sails"
from sales_data;


-- Example C — Regional average order value
SELECT
    Order_ID,
    Region,
    Sales,
    AVG(Sales) OVER(
        PARTITION BY Region
    ) AS Regional_Average
FROM sales_data;


-- Example D — Running company sales
SELECT
    Order_Date,
    Order_ID,
    Sales,
    SUM(Sales) OVER(
        ORDER BY Order_Date
    ) AS Running_Sales
FROM sales_data
ORDER BY Order_Date;


-- Example E — Regional running sales
SELECT
    Order_Date,
    Order_ID,
    Region,
    Sales,
    SUM(Sales) OVER(
        PARTITION BY Region
        ORDER BY Order_Date
    ) AS Regional_Running_Sales
FROM sales_data
ORDER BY Region, Order_Date;

/*row_num()*/
/*Management wants to see every transaction ranked from the highest sale to the lowest sale across the entire company.*/
SELECT
    Order_ID,
    Order_Date,
    Product,
    Sales,
    ROW_NUMber() OVER(
        ORDER BY Sales DESC
    ) AS Sales_Row_Number
FROM sales_data;



/*Find the Top 10 Transactions
Now suppose management says:
Show only the 10 transactions with the highest sales.*/
SELECT *
FROM (
    SELECT
        Order_ID,
        Order_Date,
        Product,
        Sales,
        ROW_NUMBER() OVER(
            ORDER BY Sales DESC
        ) AS Row_Num
    FROM sales_data
) AS ranked_sales
WHERE Row_Num <= 10;



/*Top 3 Transactions in Every Region
Business requirement:
Management wants the three highest-value transactions from every region*/


SELECT *
FROM (
    SELECT
        Order_ID,
        Region,
        Product,
        Sales,
        ROW_NUMBER() OVER(
            PARTITION BY Region
            ORDER BY Sales DESC
        ) AS Row_Num
    FROM sales_data
) AS ranked_sales
WHERE Row_Num <= 3;


/*Rank and dense_rank()*/
/*Management wants to identify the highest-value orders within each region and see how each 
order ranks against other orders from the same region.*/
SELECT
    Order_ID,
    Region,
    Product,
    Sales,
    RANK() OVER (
        PARTITION BY Region
        ORDER BY Sales DESC
    ) AS Regional_Rank
FROM sales_data
ORDER BY Region, Regional_Rank;

/*Top 3 sales positions in each region*/
SELECT *
FROM (
    SELECT
        Order_ID,
        Region,
        Product,
        Sales,
        DENSE_RANK() OVER (
            PARTITION BY Region
            ORDER BY Sales DESC
        ) AS Sales_Rank
    FROM sales_data
) AS ranked_sales
WHERE Sales_Rank <= 3
ORDER BY Region, Sales_Rank;





/*lag() and lead()*/
/*Management wants to review each order against the immediately preceding order and identify how sales changed from one order to the next. 
Show the order date, current sales, previous order's sales, and the difference between the two.*/
SELECT
    Order_ID,
    Order_Date,
    Sales,

    LAG(Sales) OVER (
        ORDER BY Order_Date
    ) AS Previous_Sales,

    Sales - LAG(Sales) OVER (
        ORDER BY Order_Date
    ) AS Sales_Change

FROM sales_data
ORDER BY Order_Date;


/*The business team wants to understand customer purchasing behavior. For every customer order, 
show the previous order date made by the same customer and the number of days between the two purchases.*/
SELECT
    Customer_ID,
    Order_ID,
    Order_Date,

    LAG(Order_Date) OVER (
        PARTITION BY Customer_ID
        ORDER BY Order_Date
    ) AS Previous_Order_Date,

    DATEDIFF(
        Order_Date,
        LAG(Order_Date) OVER (
            PARTITION BY Customer_ID
            ORDER BY Order_Date
        )
    ) AS Days_Since_Previous_Order

FROM sales_data
ORDER BY Customer_ID, Order_Date;




SELECT
    Customer_ID,
    SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Customer_ID
HAVING SUM(Sales) > 50000;




/*CTEs (COmmon Table Expression*/
Business Question
The sales manager wants a customer-level sales report. First calculate the total sales generated by each customer, 
then display only customers whose total purchase value is greater than ₹50,000. Show the highest-value customers first.

WITH customer_sales AS (
    SELECT
        Customer_ID,
        Customer_Name,
        SUM(Sales) AS Total_Sales
    FROM sales_data
    GROUP BY
        Customer_ID,
        Customer_Name
)

SELECT
    Customer_ID,
    Customer_Name,
    Total_Sales
FROM customer_sales
WHERE Total_Sales > 50000
ORDER BY Total_Sales DESC;




Business Question
Management wants to identify the three highest-value orders from every region. 
Orders with higher sales should receive better positions within their own region.
WITH ranked_orders AS (
    SELECT
        Order_ID,
        Region,
        Product,
        Sales,
        ROW_NUMBER() OVER (
            PARTITION BY Region
            ORDER BY Sales DESC, Order_ID
        ) AS Row_Num
    FROM sales_data
)

SELECT
    Order_ID,
    Region,
    Product,
    Sales,
    Row_Num
FROM ranked_orders
WHERE Row_Num <= 3
ORDER BY Region, Row_Num;



/*Management wants to compare every region's total sales with the average sales generated by all regions. 
Show the region, its total sales, the average regional sales, and whether the region is performing above or below that average.*/

WITH region_sales AS (
    SELECT
        Region,
        SUM(Sales) AS Total_Sales
    FROM sales_data
    GROUP BY Region
)

SELECT
    Region,
    Total_Sales,
    AVG(Total_Sales) OVER () AS Average_Regional_Sales,
    Total_Sales - AVG(Total_Sales) OVER () AS Difference
FROM region_sales
ORDER BY Total_Sales DESC;




/*VIEW*/


/*Business requirement
The management team frequently needs regional performance containing total orders, total quantity sold, total sales, and total profit. 
Create a reusable database object for this report and then retrieve the report from it.*/
CREATE VIEW regional_sales_performance AS
SELECT
    Region,
    COUNT(*) AS Total_Orders,
    SUM(Quantity) AS Total_Quantity,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Region;

SELECT *
FROM regional_sales_performance
ORDER BY Total_Sales DESC;


/*Business requirement
The marketing team wants a reusable customer-level report showing every registered customer, their region and segment, total orders, total sales and total profit. 
Customers who have never purchased should also appear with zero sales and zero profit.*/
CREATE VIEW customer_sales_summary AS
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Region,
    c.Customer_Segment,
    COUNT(s.Order_ID) AS Total_Orders,
    COALESCE(SUM(s.Sales), 0) AS Total_Sales,
    COALESCE(SUM(s.Profit), 0) AS Total_Profit
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    c.Region,
    c.Customer_Segment;
    
    
    

    
Business requirement
The sales team wants a reusable monthly performance report showing month number, month name, total orders, total sales and total profit. The months should be displayed chronologically.
CREATE VIEW monthly_sales_summary AS
SELECT
    MONTH(Order_Date) AS Month_Number,
    MONTHNAME(Order_Date) AS Month_Name,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date);  

SELECT *
FROM monthly_sales_summary
ORDER BY Month_Number;



SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(s.Sales) AS Total_Sales
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name;
    
    
/*Handling Null values*/


/*The finance team wants to identify all transactions where the sales amount has not been recorded.*/


select * 
from sales_data
where sales is null;


/*Find all sales transactions where the customer name is missing.*/
select * from sales_data
where Customer_Name is null;


/*Management wants a complete customer report showing total sales for every registered customer. 
Customers who have never purchased should also appear, with their total sales shown as 0.*/
SELECT
    c.Customer_ID,
    c.Customer_Name,
    COALESCE(SUM(s.Sales), 0) AS Total_Sales
FROM customers c
LEFT JOIN sales_data s
    ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name;
    
    
/*ind all transactions where Profit is missing.*/
SELECT
    Order_ID,
    Product,
    Sales,
    Profit
FROM sales_data
WHERE Profit IS NULL;



/*Calculate profit margin while making sure that transactions with zero Sales do not cause a division-by-zero problem.*/
SELECT
    Order_ID,
    Sales,
    Profit,
    ROUND(
        Profit / NULLIF(Sales, 0) * 100,
        2
    ) AS Profit_Margin
FROM sales_data;




SELECT COUNT(*) FROM sales_data;

SELECT COUNT(*) FROM sales_data
WHERE Customer_ID IS NULL;

SELECT COUNT(*) FROM sales_data
WHERE Order_Date IS NULL;

SELECT COUNT(*) FROM sales_data
WHERE Quantity <= 0;

SELECT COUNT(*) FROM sales_data
WHERE Sales < 0;

SELECT DISTINCT Region
FROM sales_data;

SELECT DISTINCT Category
FROM sales_data;

SELECT DISTINCT Channel
FROM sales_data;





The marketing team wants to identify customers who had a gap of more than 60 days between two consecutive purchases.
WITH customer_orders AS (
    SELECT
        Customer_ID,
        Order_ID,
        Order_Date,
        LAG(Order_Date) OVER (
            PARTITION BY Customer_ID
            ORDER BY Order_Date, Order_ID
        ) AS Previous_Order_Date
    FROM sales_data
)
SELECT
    Customer_ID,
    Order_ID,
    Order_Date,
    Previous_Order_Date,
    DATEDIFF(
        Order_Date,
        Previous_Order_Date
    ) AS Days_Between_Orders
FROM customer_orders
WHERE Previous_Order_Date IS NOT NULL
  AND DATEDIFF(
        Order_Date,
        Previous_Order_Date
      ) > 60
ORDER BY Days_Between_Orders DESC;




The business wants customers whose orders have increased consecutively.
WITH customer_orders AS (
    SELECT
        Customer_ID,
        Order_ID,
        Order_Date,
        Sales,
        LAG(Sales) OVER (
            PARTITION BY Customer_ID
            ORDER BY Order_Date, Order_ID
        ) AS Previous_Sales
    FROM sales_data
),
increasing_orders AS (
    SELECT
        Customer_ID,
        Order_ID,
        Order_Date,
        Sales,
        Previous_Sales
    FROM customer_orders
    WHERE Previous_Sales IS NOT NULL
      AND Sales > Previous_Sales
)
SELECT
    Customer_ID,
    COUNT(*) AS Increasing_Order_Count
FROM increasing_orders
GROUP BY Customer_ID
HAVING COUNT(*) >= 2
ORDER BY Increasing_Order_Count DESC;



Problem 33 — Find the highest-profit product in each category
WITH product_profit AS (
    SELECT
        Category,
        Product,
        SUM(Profit) AS Total_Profit
    FROM sales_data
    GROUP BY Category, Product
),
ranked_products AS (
    SELECT
        Category,
        Product,
        Total_Profit,
        ROW_NUMBER() OVER (
            PARTITION BY Category
            ORDER BY Total_Profit DESC
        ) AS Row_Num
    FROM product_profit
)
SELECT
    Category,
    Product,
    Total_Profit
FROM ranked_products
WHERE Row_Num = 1
ORDER BY Category;


The finance team wants to identify products where total profit is negative.
SELECT
    Product,
    SUM(Sales) AS Total_Sales,
    SUM(Cost) AS Total_Cost,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Product
HAVING SUM(Profit) < 0
ORDER BY Total_Profit



Management wants to identify products with the lowest profit margins.
SELECT
    Product,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS Profit_Margin
FROM sales_data
GROUP BY Product
ORDER BY Profit_Margin ASC
LIMIT 10;


The finance team wants to know which payment method generates the highest sales.
SELECT
    Payment_Method,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Payment_Method
ORDER BY Total_Sales DESC;



Management wants a detailed comparison between sales channels.
SELECT
    Channel,
    COUNT(Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers,
    SUM(Quantity) AS Total_Quantity,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS Profit_Margin,
    ROUND(AVG(Sales), 2) AS Average_Order_Value
FROM sales_data
GROUP BY Channel
ORDER BY Total_Sales DESC;


For each sales channel, which region performs the best?

WITH channel_region_sales AS (
    SELECT
        Channel,
        Region,
        SUM(Sales) AS Total_Sales
    FROM sales_data
    GROUP BY Channel, Region
),
ranked_regions AS (
    SELECT
        Channel,
        Region,
        Total_Sales,
        ROW_NUMBER() OVER (
            PARTITION BY Channel
            ORDER BY Total_Sales DESC
        ) AS Row_Num
    FROM channel_region_sales
)
SELECT
    Channel,
    Region,
    Total_Sales
FROM ranked_regions
WHERE Row_Num = 1
ORDER BY Channel;


The marketing team wants customers who have purchased Online but never Offline.

SELECT
    Customer_ID
FROM sales_data
GROUP BY Customer_ID
HAVING COUNT(
           DISTINCT CASE
               WHEN Channel = 'Online' THEN Channel
           END
       ) > 0
   AND COUNT(
           DISTINCT CASE
               WHEN Channel = 'Offline' THEN Channel
           END
       ) = 0;
       
       
       
Problem 40 — Find customers who use only Offline
SELECT
    Customer_ID
FROM sales_data
GROUP BY Customer_ID
HAVING COUNT(
           DISTINCT CASE
               WHEN Channel = 'Offline' THEN Channel
           END
       ) > 0
   AND COUNT(
           DISTINCT CASE
               WHEN Channel = 'Online' THEN Channel
           END
       ) = 0;
       
       
Problem 41 — Find the month with the highest profit
SELECT
    MONTH(Order_Date) AS Month_Number,
    MONTHNAME(Order_Date) AS Month_Name,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY Total_Profit DESC
LIMIT 1;


/*Problem 42 — Find the region's most profitable month*/
WITH regional_monthly_profit AS (
    SELECT
        Region,
        MONTH(Order_Date) AS Month_Number,
        MONTHNAME(Order_Date) AS Month_Name,
        SUM(Profit) AS Total_Profit
    FROM sales_data
    GROUP BY
        Region,
        MONTH(Order_Date),
        MONTHNAME(Order_Date)
),
ranked_months AS (
    SELECT
        Region,
        Month_Number,
        Month_Name,
        Total_Profit,
        ROW_NUMBER() OVER (
            PARTITION BY Region
            ORDER BY Total_Profit DESC
        ) AS Row_Num
    FROM regional_monthly_profit
)
SELECT
    Region,
    Month_Name,
    Total_Profit
FROM ranked_months
WHERE Row_Num = 1
ORDER BY Region;


Problem 43 — Identify high-value inactive customers
This is a very realistic marketing problem.
Find customers who previously generated more than ₹50,000 in sales but have not purchased in the latest 90 days.


WITH customer_summary AS (
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales,
        MAX(Order_Date) AS Last_Order_Date
    FROM sales_data
    GROUP BY Customer_ID
),
latest_date AS (
    SELECT
        MAX(Order_Date) AS Latest_Date
    FROM sales_data
)
SELECT
    cs.Customer_ID,
    cs.Total_Sales,
    cs.Last_Order_Date,
    DATEDIFF(
        ld.Latest_Date,
        cs.Last_Order_Date
    ) AS Days_Since_Last_Order
FROM customer_summary cs
CROSS JOIN latest_date ld
WHERE cs.Total_Sales > 50000
  AND DATEDIFF(
        ld.Latest_Date,
        cs.Last_Order_Date
      ) > 90
ORDER BY cs.Total_Sales DESC;



/*Problem 44 — Find each customer's first and latest purchase
Management wants a basic customer lifecycle report.*/
SELECT
    Customer_ID,
    MIN(Order_Date) AS First_Order_Date,
    MAX(Order_Date) AS Latest_Order_Date,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Customer_ID
ORDER BY Total_Sales DESC;


-- Problem 45 — Customer lifetime period
-- Now calculate how many days each customer has been active between their first and latest order.
SELECT
    Customer_ID,
    MIN(Order_Date) AS First_Order_Date,
    MAX(Order_Date) AS Latest_Order_Date,
    DATEDIFF(
        MAX(Order_Date),
        MIN(Order_Date)
    ) AS Customer_Active_Days,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Customer_ID
ORDER BY Customer_Active_Days DESC;


