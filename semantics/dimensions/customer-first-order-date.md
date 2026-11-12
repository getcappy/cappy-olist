---
type: Dimension
title: Customer first order date
description: Month of the customer's first order.
tags: [time, customer]
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
---

# Definition

First order timestamp per customer; use it for cohort-style slices. Truncate to month for cohorts.

# SQL

```sql
DATE_TRUNC('month', first_order_ts) AS first_order_month
```

# Available in

- [dim_customers](../../databases/type=duckdb/database=olist/schema=main/table=dim_customers.md)

# Notes

- A customer is counted in their first-order month, not the month of later orders.
