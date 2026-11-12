---
type: Metric
title: Repeat customer rate
description: Repeat customers divided by all customers.
tags:
- customer
aliases:
- 复购率
- 回购率
unit: ratio
status: stable
generated:
  by: dsh-agent/deepseek-flash
  at: '2026-11-12T12:30:00Z'
verified:
  by: process:olist-raw-baseline-check
  at: '2026-11-12T12:30:00Z'
sources:
- id: kaggle
  resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
  title: Brazilian E-Commerce Public Dataset by Olist
- id: olist-customers-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_customers_dataset.md
  title: olist_customers_dataset table context
- id: olist-orders-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_orders_dataset.md
  title: olist_orders_dataset table context
---

# Definition

`repeat_customer_rate = repeat_customers / customers`.

# Computation

```sql
WITH customer_orders AS (
    SELECT c.customer_unique_id, COUNT(*) AS order_count
    FROM olist_customers_dataset AS c
    JOIN olist_orders_dataset AS o ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT
    SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END)
    / NULLIF((SELECT COUNT(DISTINCT customer_unique_id) FROM olist_customers_dataset), 0) AS repeat_customer_rate
FROM customer_orders;
```

Denominator is all distinct `customer_unique_id` values in `olist_customers_dataset` (96,096).

# Dimensions

- [Customer first order date](/dimensions/customer-first-order-date.md)
- [Customer state](/dimensions/customer-state.md)
- [Customer type](/dimensions/customer-type.md)

# Notes

- Full-period baseline: 3.12%.
- The low rate is real for this marketplace and is not a query bug.

# Related metrics

- [Customers](/metrics/customers.md)
- [Repeat Customers](/metrics/repeat-customers.md)
