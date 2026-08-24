USE bike_store_db;

-- Task 1: Product names and unit prices
SELECT product_name, price 
FROM products;

-- Task 2: Customers from California
SELECT customer_id, first_name, last_name, email, city, state 
FROM customers 
WHERE state = 'CA';

-- Task 3: Products costing more than $500
SELECT product_name, price 
FROM products 
WHERE price > 500;