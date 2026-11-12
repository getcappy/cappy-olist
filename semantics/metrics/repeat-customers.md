---
type: Metric
title: "Repeat customers"
description: "Customers with more than one order."
tags: [customer]
aliases: ["returning customers", "复购客户"]
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

Count of customers whose `order_count > 1`.

# Computation

```sql
SELECT SUM(CASE WHEN is_repeat_customer THEN 1 ELSE 0 END) AS repeat_customers
FROM dim_customers;
```

One row per customer.

# Dimensions

- [Customer first order date](/dimensions/customer-first-order-date.md)
- [Customer state](/dimensions/customer-state.md)
- [Customer type](/dimensions/customer-type.md)

# Notes

- Full-period baseline: 2,997 repeat customers.
- A repeat customer is defined by lifetime order count, not by orders within a period.

# Related metrics

- [Customers](/metrics/customers.md)
- [Repeat Customer Rate](/metrics/repeat-customer-rate.md)
