-- Employee Management Project 

-- # Part 1: Basic Queries

-- Display all records from the GreenMart sales table
SELECT *
FROM greenmart_sales
;
-- Show the first 10 transactions that took place in the “Nairobi” store
SELECT *
FROM greenmart_sales
WHERE store_location ='Nairobi'
LIMIT 10
;
-- Retrieve all transactions made after 1st July 2024
SELECT *
FROM greenmart_sales
WHERE date >= '2024-07-01'
;
-- Display all transactions where the payment method is “M-Pesa”
SELECT *
FROM greenmart_sales
WHERE payment_method = 'Mpesa'
;
-- Show all transactions where total_amount is greater than 200
SELECT *
FROM greenmart_sales
WHERE total_amount > 200
;
-- List the transaction_id, product_name, and total_amount for all sales
SELECT transaction_id, product_name, total_amount
FROM greenmart_sales
ORDER BY total_amount
;
-- Display all sales records where the product_category is “Beverages”
SELECT *
FROM greenmart_sales
WHERE product_category = 'beverages'
;
-- Show transactions made by customer_id = 1012
SELECT *
FROM greenmart_sales
WHERE customer_id = 1012
;
-- Display the 5 most recent transactions
SELECT *
FROM greenmart_sales
ORDER BY date desc
LIMIT 5
;
-- Display the 5 highest-value transactions (based on total_amount)
SELECT *
FROM greenmart_sales
ORDER BY total_amount desc
LIMIT 5
;
-- List all distinct payment methods used
SELECT DISTINCT payment_method
FROM greenmart_sales
;
-- Count the total number of transactions in the table
SELECT COUNT(*) AS total_transactions
FROM greenmart_sales
;
-- Show all transactions where the quantity sold is greater than 5
SELECT *
FROM greenmart_sales
WHERE quantity > 5
;
-- Find all transactions that occurred in “Kisumu” store and were paid by “Card”
SELECT *
FROM greenmart_sales
WHERE store_location = 'Kisumu'
AND payment_method = 'Card'
;
-- List all unique store locations where GreenMart operates
SELECT DISTINCT store_location
FROM greenmart_sales
ORDER BY store_location
;

-- # Part 2: Aggregation & Grouping

-- Find the total revenue (sum of total_amount) from all transactions
SELECT SUM(total_amount) AS total_revenue
FROM greenmart_sales
;
-- Find the average total_amount of all transactions
SELECT AVG(total_amount) AS average_revenue
FROM greenmart_sales
;
-- Find the minimum and maximum total_amount recorded
SELECT MIN(total_amount) AS minimum_amount, MAX(total_amount) AS maximum_amount
FROM greenmart_sales
;
-- Show total sales per store location
SELECT SUM(total_amount) AS total_sales, store_location
FROM greenmart_sales
GROUP BY store_location
;
-- Show the average quantity of products sold per product category
SELECT AVG(quantity) AS average_quantity, product_category
FROM greenmart_sales
GROUP BY product_category
;
-- Count how many transactions were made per payment method
SELECT COUNT(*) AS total_transactions, payment_method
FROM greenmart_sales
GROUP BY payment_method
;
-- Find total revenue by payment method
SELECT SUM(total_amount) AS total_revenue, payment_method
FROM greenmart_sales
GROUP BY payment_method
;
-- Show total sales per product category, but only include categories that earned more than 5,000
SELECT SUM(total_amount) AS total_sales, product_category
FROM greenmart_sales
GROUP BY product_category
HAVING SUM(total_amount) > 5000
;
-- Count how many sales were made per store location.
SELECT COUNT(*) AS total_transactions, store_location
FROM greenmart_sales
GROUP BY store_location
;
-- Find the store location with the highest average transaction amount
SELECT AVG(total_amount) AS average_transaction, store_location
FROM greenmart_sales
GROUP BY store_location
ORDER BY average_transaction desc
LIMIT 1
;
-- Find the product category with the highest total quantity sold
SELECT SUM(quantity) AS total_quantity, product_category
FROM greenmart_sales
GROUP BY product_category
ORDER BY total_quantity desc
LIMIT 1
;

-- # Part 3: Filtering & Grouping (Intermediate Queries)

-- Show total sales per store location, but only for stores with total sales above 10,000
SELECT SUM(total_amount) AS total_sales, store_location
FROM greenmart_sales
GROUP BY store_location
HAVING SUM(total_amount) > 10000
;
-- Display the average total_amount per payment method, only including methods with more than 20 transactions
SELECT COUNT(*) AS transactions, AVG(total_amount) AS average_total_amount, payment_method
FROM greenmart_sales
GROUP BY payment_method
HAVING COUNT(*) > 20
;
-- Find product categories that sold more than 100 total units (quantity)
SELECT product_category, SUM(quantity) AS total_quantity
FROM greenmart_sales
GROUP BY product_category
HAVING SUM(quantity) > 100
;
-- Show each store’s total revenue and filter only those stores that had an average transaction value greater than 300
SELECT SUM(total_amount) AS total_revenue, AVG(total_amount) AS average_amount, store_location
FROM greenmart_sales
GROUP BY store_location
HAVING AVG(total_amount) > 300
;
-- Display each product category’s total revenue, but only for those that contributed more than 15% of the company’s overall revenue
SELECT SUM(total_amount) AS total_revenue, product_category, (SUM(total_amount) / (SELECT SUM(total_amount) FROM greenmart_sales)) * 100 AS pct_of_total
FROM greenmart_sales
GROUP BY product_category
HAVING pct_of_total > 15
;
-- Find all payment methods that brought in at least 5,000 in total revenue
SELECT payment_method, SUM(total_amount) AS total_revenue
FROM greenmart_sales
GROUP BY payment_method
HAVING SUM(total_amount) >= 5000
;
-- List the top 3 store locations by total number of transactions
SELECT COUNT(*) AS total_transactions, store_location
FROM greenmart_sales
GROUP BY store_location
ORDER BY COUNT(*) desc
LIMIT 3
;
-- Show which product categories have an average quantity sold greater than 3 per transaction
SELECT product_category, AVG(quantity) AS average_quantity
FROM greenmart_sales
GROUP BY product_category
HAVING AVG(quantity) > 3
;
-- Find which product categories are performing below average in revenue compared to all categories
SELECT product_category, SUM(total_amount) AS total_revenue
FROM greenmart_sales
GROUP BY product_category
HAVING SUM(total_amount) < (SELECT AVG(category_total)
    FROM (SELECT SUM(total_amount) AS category_total
        FROM greenmart_sales
        GROUP BY product_category) AS category_summary)
;
