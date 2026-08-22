--1a. Top 10 most profitable cities
SELECT City, SUM(Profit) AS total_profit
FROM "Sample - Superstore"
GROUP BY City
ORDER BY total_profit DESC
LIMIT 10;

--1b. Top 10 least profitable cities
SELECT City, SUM(Profit) AS total_profit
FROM "Sample - Superstore"
GROUP BY City
ORDER BY total_profit ASC
LIMIT 10;

--2A. High Quantity purchase customers
WITH CustomerTotalVolume AS(
    SELECT "Customer ID", SUM(quantity) as total_quantity
    FROM "Sample - Superstore"
    GROUP BY "Customer ID"
	LIMIT 159
),
HQ AS (
	SELECT s.*
	FROM "Sample - Superstore" s
	JOIN CustomerTotalVolume cq ON s."Customer ID" = cq."Customer ID"
)
SELECT State,"Sub-Category", SUM(quantity) as total_quantity
FROM HQ
GROUP BY State
ORDER BY total_quantity DESC
LIMIT 10
;

--2B. High Profit purchase customers
WITH CustomerTotalProfit AS(
    SELECT "Customer ID", SUM(Profit) as total_profit
    FROM "Sample - Superstore"
    GROUP BY "Customer ID"
	LIMIT 159
),
HP AS (
	SELECT s.*
	FROM "Sample - Superstore" s
	JOIN CustomerTotalProfit cq ON s."Customer ID" = cq."Customer ID"
)
SELECT State, "Sub-Category", SUM(Profit) as total_profit
FROM HP
GROUP BY State
ORDER BY total_profit DESC
LIMIT 10
;

--2C. Discount Seekers
WITH DiscountSeekers AS(
    SELECT "Customer ID", AVG(Discount) as avg_discount
    FROM "Sample - Superstore"
    GROUP BY "Customer ID"
	LIMIT 159
),
DS AS (
	SELECT s.*
	FROM "Sample - Superstore" s
	JOIN DiscountSeekers cq ON s."Customer ID" = cq."Customer ID"
)
SELECT State, "Sub-Category", AVG(Discount) as avg_discount
FROM DS
GROUP BY State
ORDER BY avg_discount DESC
LIMIT 10
; 

--3a. Most profitable best selling Sub-Category
WITH BestSubCat AS(
    SELECT "Sub-Category", SUM(Sales) as total_sales
    FROM "Sample - Superstore"
    GROUP BY "Sub-Category"
)
SELECT "Sample - Superstore"."Sub-Category", SUM(profit) as total_profit
FROM "Sample - Superstore"
JOIN BestSubCat USING ("Sub-Category")
GROUP BY "Sample - Superstore"."Sub-Category"
ORDER BY total_profit DESC
LIMIT 5;

--3a. Product category with most selling products
SELECT "Sub-Category", SUM(Quantity) as total_quantity
FROM "Sample - Superstore"
GROUP BY "Sub-Category"
ORDER BY total_quantity DESC
LIMIT 10
;
--4. Discounted Products vs. profitability
SELECT "Product Name", AVG(Discount) as avg_discount, SUM(profit) as total_profit
FROM "Sample - Superstore"
GROUP BY "Product Name"
ORDER BY avg_discount DESC
LIMIT 10
;
--5a. Best selling Products: Most Profitable
SELECT "Product Name", SUM(profit) as total_profit
FROM "Sample - Superstore"
GROUP BY "Product Name"
ORDER BY total_profit DESC
LIMIT 10
;
--5b. Best selling Products: Most sold
SELECT "Product Name", SUM(Quantity) as total_quantity
FROM "Sample - Superstore"
GROUP BY "Product Name"
ORDER BY total_quantity DESC
LIMIT 10
;
--6a. Worst selling Products: Least sold
SELECT "Product Name", SUM(Quantity) as total_quantity
FROM "Sample - Superstore"
GROUP BY "Product Name"
ORDER BY total_quantity ASC
LIMIT 10
;
--6b. Worst selling Products: Least profitable
SELECT "Product Name", SUM(Profit) as total_profit
FROM "Sample - Superstore"
GROUP BY "Product Name"
ORDER BY total_profit ASC
LIMIT 10
;
--7 Correlation in order delivery and quantity of Sales
--This is done within python
SELECT "Order Date", "Ship Date", Quantity
FROM "Sample - Superstore"
LIMIT 20;

--8 Which Cities do we want to scale up, where do we want to scale down?
--Negative profit
SELECT "City", SUM(Profit) as total_profit
FROM "Sample - Superstore"
GROUP BY "City"
ORDER BY total_profit ASC
LIMIT 10
;
--Positive profit
SELECT "City", SUM(Profit) as total_profit
FROM "Sample - Superstore"
GROUP BY "City"
ORDER BY total_profit DESC
LIMIT 10
;
--Philadelphia
SELECT DISTINCT "Sub-Category", "Product Name", SUM(profit) as total_profit, AVG(Discount) as avg_discount, SUM(Sales) as total_sales, SUM(Quantity) as total_quantity
FROM "Sample - Superstore"
WHERE City = 'Philadelphia'
GROUP BY "Sub-Category"
ORDER BY total_profit ASC
LIMIT 10;

--9. Customer segments 
SELECT 
	"Segment",
	SUM(profit) as total_profit, 
	AVG(Discount) as avg_discount, 
	SUM(Sales) as total_sales, 
	SUM(Quantity) as total_quantity
FROM "Sample - Superstore"
GROUP BY "Segment"
;
--10. Which product categories do we want to excel and which categories will be focussed on less?
SELECT 
	"Sub-Category",
	SUM(profit) as total_profit, 
	AVG(Discount) as avg_discount, 
	SUM(Sales) as total_sales, 
	SUM(Quantity) as total_quantity
FROM "Sample - Superstore"
GROUP BY "Sub-Category"
ORDER BY total_profit DESC
;