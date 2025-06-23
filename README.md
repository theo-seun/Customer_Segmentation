# Customer Segmentation SQL Project

This project explores customer purchasing behavior using a relational grocery sales database. Through SQL queries, I segmented customers based on purchase frequency, total spend, and engagement levels to uncover insights that can guide retention and marketing strategies.

---

## Dataset Overview

The database contains 7 interrelated tables: `sales`, `customers`, `products`, `employees`, `cities`, `countries`, and `categories`.  
Each sale includes customer, product, quantity, discount, and timestamp data, allowing for rich behavioral analysis.

---

## Business Goal

The goal is to identify key customer segments, understand purchase behavior, and uncover actionable insights such as:
- Customer lifetime value
- Repeat vs one-time buyer patterns
- Value-based tiers (VIP, Loyal, Occasional, Infrequent)

---

## Business Questions Answered

1. How many unique customers made at least one purchase?
2. How many are repeat vs one-time buyers?
3. What is the total and average spend per customer?
4. Who are the top 10 highest-spending customers?
5. How are customers segmented into low, medium, and high value?
6. When was each customer’s most recent purchase?
7. Can we segment customers into value tiers based on spend and frequency?

---

## Key Insights

- **40,527** unique customers made at least one purchase.
- **76%** of customers were one-time buyers, while only **24%** were repeat buyers.
- Spend ranges from as low as **₦6** to over **₦4,000** — most customers spend between **₦200–₦1,000**.
- Customers were segmented into:
  - **High, Medium, Low Value** (based on total spend)
  - **VIP, Loyal, Occasional, Infrequent** (based on spend + frequency)
- Recency analysis identifies customers who are **active vs inactive**, allowing for targeted reactivation campaigns.

---

## Recommendations

- Focus on retaining high-value customers through loyalty programs.
- Re-engage one-time buyers using follow-up offers or discounts.
- Use tiered marketing strategies based on customer classification.
- Monitor recency to identify and win back lapsed customers.

---

## Tools Used

- SQL (MySQL)

---

## Project Files

- `customer_segmentation.sql` — SQL script containing all queries and insights
- `README.md` — Project documentation
