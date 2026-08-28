-- Deliverables 2 
-- SQL QUERY:
ALTER TABLE orders CHANGE COLUMN quantity_id quantity INT;
USE bike_store_db;

-- Task 1: "Find each customer's name and the product they purchased"
SELECT 
    c.first_name, 
    c.last_name, 
    p.product_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id;

-- Task 2: "Find the top 5 products by revenue"
SELECT 
    p.product_name, 
    sum(o.quantity * o.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Task 3: "Find the top 5 customers by total number of orders"
SELECT 
    c.first_name, 
    c.last_name, 
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_orders DESC
LIMIT 5;

































