-- PROJECT: Customer Segmentation Analysis
-- Objective: Use SQL to analyze customer behavior and segment customers based on spending, frequency, and retention.

--           									Business questions 

-- Q1: How many unique customers made at least one purchase?
SELECT COUNT(DISTINCT CustomerID) AS active_customers 
FROM sales;

/*
Insight:
A total of 40,527 unique customers made at least one purchase during the recorded period.
This forms the active customer base, and is the foundation for all further behavioral segmentation.
*/

-- Q2: How many are repeat vs one-time buyers?
WITH customer_order_counts AS (
    SELECT CustomerID, COUNT(*) AS num_orders,
        CASE WHEN COUNT(*) = 1 THEN 'One-Time Buyer'
             ELSE 'Repeat Buyer'
        END AS buyer_type
    FROM sales
    GROUP BY CustomerID
)
SELECT buyer_type, COUNT(*) AS customer_count
FROM customer_order_counts
GROUP BY buyer_type;

/*
Insight:
Among all active customers, 76% were one-time buyers, while only 24% made more than one purchase.
This indicates a low customer retention rate, suggesting a strong reliance on acquisition rather than loyalty.
*/

-- Q3: What is the total and average spend per customer?
SELECT 
  s.CustomerID,
  ROUND(SUM(p.Price * s.Quantity * (1 - s.Discount)), 2) AS total_spent,
  ROUND(AVG(p.Price * s.Quantity * (1 - s.Discount)), 2) AS avg_order_value
FROM sales s
JOIN products p ON s.ProductID = p.ProductID
GROUP BY s.CustomerID;

/*
Insight:
Customer spending ranges from as low as $1 to over $6,500, showing high variance in behavior.
*/

-- Q4: Who are the top 10 highest-spending customers?
WITH customer_spend AS (
  SELECT s.CustomerID, ROUND(SUM(p.Price * s.Quantity * (1 - s.Discount)), 2) AS Total_spent
  FROM sales s JOIN products p ON s.ProductID = p.ProductID
  GROUP BY s.CustomerID
)
SELECT CustomerID, total_spent
FROM customer_spend
ORDER BY total_spent DESC
LIMIT 10;

/*
Insight:
These top 10 customers each spent $5,500 to $6,500+, making them less than 1% of the user base but likely contributing 10–15% of total revenue.
*/

-- Q5: How are customers segmented into low, medium, and high value?
WITH customer_spend AS (
  SELECT CustomerID, SUM(p.Price * s.Quantity * (1 - s.Discount)) AS total_spent
  FROM sales s JOIN products p ON s.ProductID = p.ProductID
  GROUP BY CustomerID
)
SELECT 
  CASE 
    WHEN total_spent >= 1000 THEN 'High Value'
    WHEN total_spent BETWEEN 500 AND 999 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS segment,
  COUNT(*) AS customer_count
FROM customer_spend
GROUP BY segment;

/*
Insight:
Customers were classified into low, medium, and high value based on total spend. 
This helps prioritize which customer segments to focus on for upselling and retention.
*/

-- Q6: When was each customer’s most recent purchase?
SELECT 
  CustomerID,
  MAX(SalesDate) AS last_purchase_date
FROM sales
GROUP BY CustomerID;

/*
Insight:
Each customer's most recent purchase date was identified, allowing the business to distinguish active vs inactive users and build re-engagement strategies.
*/

-- Q7: Can we segment customers into value tiers based on spend and frequency?
WITH customer_stats AS (
  SELECT 
    s.CustomerID,
    COUNT(s.SalesID) AS total_orders,
    ROUND (SUM(p.Price * s.Quantity * (1 - s.Discount)), 2) AS total_spent
  FROM sales s
  JOIN products p ON s.ProductID = p.ProductID
  GROUP BY s.CustomerID
)

SELECT 
  CustomerID,
  total_orders,
  total_spent,
  CASE 
    WHEN total_spent >= 1000 AND total_orders >= 3 THEN 'VIP'
    WHEN total_spent >= 500 AND total_orders >= 2 THEN 'Loyal'
    WHEN total_spent < 500 AND total_orders >= 2 THEN 'Occasional'
    ELSE 'New or Infrequent'
  END AS customer_tier
FROM customer_stats;

/*
Insight:
A combined analysis of spend and frequency segmented customers into VIP, Loyal, Occasional, and Infrequent tiers — enabling personalized retention and marketing efforts.
*/