---
type: Metric
title: "Average orders per customer"
description: "Average number of orders per customer."
tags: [customer, orders]
aliases: ["order frequency", "人均订单数"]
unit: orders
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

Average of `order_count` across customers.

# Computation

```sql
SELECT AVG(order_count) AS average_orders_per_customer
FROM dim_customers;
```

One row per customer.

# Dimensions

- [Customer first order date](/dimensions/customer-first-order-date.md)
- [Customer state](/dimensions/customer-state.md)
- [Customer type](/dimensions/customer-type.md)

# Notes

- Full-period baseline: 1.035.
- The denominator is customers (96,096), not orders.

# Related metrics

- [Customers](/metrics/customers.md)
- [Orders](/metrics/orders.md)
