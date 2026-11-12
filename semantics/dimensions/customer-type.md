---
type: Dimension
title: Customer type
description: Repeat versus one-time customer.
tags: [customer]
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
---

# Definition

`repeat` when the customer has more than one order, `one_time` otherwise.

# SQL

```sql
CASE WHEN is_repeat_customer THEN 'repeat' ELSE 'one_time' END AS customer_type
```

# Available in

- [dim_customers](../../databases/type=duckdb/database=olist/schema=main/table=dim_customers.md)

# Notes

- Only 2,997 of 96,096 customers (3.12%) are repeat customers; this is a real dataset characteristic.
