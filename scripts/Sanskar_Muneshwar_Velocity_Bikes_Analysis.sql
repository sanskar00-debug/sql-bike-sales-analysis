-- =====================================================================
-- Velocity Bikes Ltd. - SQL Capstone Project (Day 3 Deliverable)
-- Analyst: Sanskar Muneshwar
-- Database: bike_store_db
-- =====================================================================

USE bike_store_db;

-- ---------------------------------------------------------------------
-- Question 1: Why are some products selling better than others?
-- Analyzing product price tiers against sales volume and total revenue.
-- ---------------------------------------------------------------------
SELECT 
    CASE 
        WHEN p.price < 500 THEN 'Budget (< $500)'
        WHEN p.price BETWEEN 500 AND 1500 THEN 'Mid-Range ($500 - $1,500)'
        WHEN p.price BETWEEN 1501 AND 3000 THEN 'High-End ($1,501 - $3,000)'
        ELSE 'Premium (> $3,000)'
    END AS price_segment,
    COUNT(DISTINCT p.product_id) AS product_count,
    SUM(o.quantity) AS total_units_sold,
    ROUND(SUM(o.quantity * o.price), 2) AS total_revenue
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY price_segment
ORDER BY total_revenue DESC;


-- ---------------------------------------------------------------------
-- Question 2: Which customers could be considered for a loyalty programme?
-- Finding top spenders with frequent repeat purchases.
-- ---------------------------------------------------------------------
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.quantity) AS total_items_bought,
    ROUND(SUM(o.quantity * o.price), 2) AS total_spend
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.state
HAVING total_spend > 25000 AND total_orders >= 2
ORDER BY total_spend DESC
LIMIT 10;


-- ---------------------------------------------------------------------
-- Question 3: Are there states with many customers but low revenue?
-- Analyzing customer concentration vs. revenue generated per customer.
-- ---------------------------------------------------------------------
SELECT 
    c.state,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(o.quantity * o.price), 2) AS total_revenue,
    ROUND(SUM(o.quantity * o.price) / COUNT(DISTINCT c.customer_id), 2) AS revenue_per_customer
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.state
ORDER BY total_customers DESC;


-- ---------------------------------------------------------------------
-- Question 4 & 5: Low-performing products — Discount or discontinue?
-- Identifying unsold or dead inventory products.
-- ---------------------------------------------------------------------
SELECT 
    p.product_id,
    p.product_name,
    p.model_year,
    p.price,
    COALESCE(SUM(o.quantity), 0) AS units_sold,
    COALESCE(ROUND(SUM(o.quantity * o.price), 2), 0.00) AS total_revenue
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, p.model_year, p.price
HAVING units_sold = 0
ORDER BY p.model_year ASC, p.price DESC;


-- ---------------------------------------------------------------------
-- Question 6: Are newer bicycle models performing better than older ones?
-- Comparing performance metrics across model release years.
-- ---------------------------------------------------------------------
SELECT 
    p.model_year,
    COUNT(DISTINCT p.product_id) AS total_models,
    COALESCE(SUM(o.quantity), 0) AS units_sold,
    ROUND(COALESCE(SUM(o.quantity * o.price), 0), 2) AS total_revenue,
    ROUND(COALESCE(SUM(o.quantity * o.price), 0) / COUNT(DISTINCT p.product_id), 2) AS avg_revenue_per_model
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.model_year
ORDER BY p.model_year ASC;


-- ---------------------------------------------------------------------
-- Question 7: Which regions could be good opportunities for expansion?
-- City-level sales volume within underserved / growing states.
-- ---------------------------------------------------------------------
SELECT 
    c.state,
    c.city,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    ROUND(SUM(o.quantity * o.price), 2) AS city_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.state, c.city
ORDER BY city_revenue DESC
LIMIT 10;