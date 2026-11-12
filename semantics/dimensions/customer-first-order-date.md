---
type: Dimension
title: Customer first order date
description: Month of the customer's first order.
tags:
- time
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

First order timestamp per customer; use it for cohort-style slices. Truncate to month for cohorts.

# SQL

```sql
DATE_TRUNC('month', MIN(o.order_purchase_timestamp)) AS first_order_month
```

# Available in

- [olist_customers_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_customers_dataset.md)
- [olist_orders_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_orders_dataset.md)

# Notes

- A customer is counted in their first-order month, not the month of later orders.
- Join `olist_customers_dataset.customer_id` → `olist_orders_dataset.customer_id`, group by `customer_unique_id`.
