-- ==================================================
-- Business Operations & Growth Analytics
-- Database: PostgreSQL
-- Author: Shraavya K N Bhat
-- ==================================================

CREATE TABLE orders (
   order_id INT,
   order_date DATE,
   customer_id VARCHAR(10),
   customer_name VARCHAR(50),
   region VARCHAR(20),
   category VARCHAR(30),
   product_name VARCHAR(50),
   sales NUMERIC,
   quantity INT
 );
 
SELECT * FROM orders;

COPY orders
FROM 'C:/Users/shraa/OneDrive/Desktop/Business_Operations_SQL_Project/data/orders.csv'
DELIMITER ',' 
CSV HEADER;

SELECT COUNT(*) FROM orders;

-- 1. Overall Business Performance
SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_revenue
FROM orders;

-- 2. Revenue by Region
SELECT 
    region,
    SUM(sales) AS revenue
FROM orders
GROUP BY region
ORDER BY revenue DESC;

-- 3. Revenue by Category
SELECT 
    category,
    SUM(sales) AS revenue
FROM orders
GROUP BY category
ORDER BY revenue DESC;

-- 4. Monthly Revenue Trend
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(sales) AS revenue
FROM orders
GROUP BY month
ORDER BY month;

-- 5. Top Products by Revenue
SELECT 
    product_name,
    SUM(sales) AS revenue
FROM orders
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 5;

-- 6. Repeat Customers
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;


CREATE TABLE orders_large (
    order_id INT,
    order_date DATE,
    customer_id VARCHAR(10),
    customer_name VARCHAR(50),
    region VARCHAR(20),
    category VARCHAR(30),
    product_name VARCHAR(50),
    sales NUMERIC,
    quantity INT
);

SELECT COUNT(*) FROM orders_large;

SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_revenue
FROM orders_large;

SELECT 'small_dataset' AS dataset,
       COUNT(*) AS total_orders,
       SUM(sales) AS revenue
FROM orders

UNION ALL

SELECT 'large_dataset' AS dataset,
       COUNT(*) AS total_orders,
       SUM(sales) AS revenue
FROM orders_large;
