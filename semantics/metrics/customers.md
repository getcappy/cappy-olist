---
type: Metric
title: "Customers"
description: "Number of distinct customers."
tags: [customer]
aliases: ["customer count", "客户数", "买家数"]
unit: customers
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
  - id: dim-customers
    resource: ../../databases/type=duckdb/database=olist/schema=main/table=dim_customers.md
    title: dim_customers table context
---

# Definition

Count of distinct `customer_unique_id` in `dim_customers` (one row per customer).

# Computation

```sql
SELECT COUNT(DISTINCT customer_unique_id) AS customers
FROM dim_customers;
```

One row per customer. Never use `customer_id` from raw orders: it is per-order, not per-customer.

# Dimensions

- [Customer first order date](/dimensions/customer-first-order-date.md)
- [Customer state](/dimensions/customer-state.md)
- [Customer type](/dimensions/customer-type.md)

# Notes

- Full-period baseline: 96,096 customers.
- The raw `customers` table has 99,441 `customer_id` values for those 96,096 people.

# Related metrics

- [Repeat Customers](/metrics/repeat-customers.md)
- [Repeat Customer Rate](/metrics/repeat-customer-rate.md)
- [Average Customer Value](/metrics/average-customer-value.md)
