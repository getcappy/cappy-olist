---
type: Dimension
title: Customer type
description: Repeat versus one-time customer.
tags:
- customer
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

`repeat` when the customer has more than one order, `one_time` otherwise. Derived from order counts, not a raw column.

# SQL

```sql
WITH customer_orders AS (
    SELECT c.customer_unique_id, COUNT(*) AS order_count
    FROM olist_customers_dataset c
    JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT CASE WHEN order_count > 1 THEN 'repeat' ELSE 'one_time' END AS customer_type
FROM customer_orders
```

# Available in

- [olist_customers_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_customers_dataset.md)
- [olist_orders_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_orders_dataset.md)

# Notes

- Only 2,997 of 96,096 customers (3.12%) are repeat customers; this is a real dataset characteristic.
- `olist_customers_dataset` has one row per order; aggregate by `customer_unique_id`.
