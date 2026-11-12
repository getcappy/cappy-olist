---
type: Metric
title: "Average customer value"
description: "Average lifetime GMV per customer."
tags: [customer, revenue]
aliases: ["customer lifetime value", "LTV", "客户平均终身价值", "客均价值"]
unit: BRL
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

Average of `total_gmv` across customers, where `total_gmv` is the customer's lifetime merchandise plus freight value.

# Computation

```sql
SELECT AVG(total_gmv) AS average_customer_value
FROM dim_customers;
```

One row per customer.

# Dimensions

- [Customer first order date](/dimensions/customer-first-order-date.md)
- [Customer state](/dimensions/customer-state.md)
- [Customer type](/dimensions/customer-type.md)

# Notes

- Full-period baseline: 164.87 BRL.
- This is a historical lifetime average, not a forward-looking LTV model.

# Related metrics

- [Customers](/metrics/customers.md)
- [Gmv](/metrics/gmv.md)
