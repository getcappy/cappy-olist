---
type: Metric
title: "Repeat customer rate"
description: "Repeat customers divided by all customers."
tags: [customer]
aliases: ["复购率", "回购率"]
unit: ratio
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

`repeat_customer_rate = repeat_customers / customers`.

# Computation

```sql
SELECT
    SUM(CASE WHEN is_repeat_customer THEN 1 ELSE 0 END)
    / NULLIF(COUNT(*), 0) AS repeat_customer_rate
FROM dim_customers;
```

One row per customer.

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
