---
type: Metric
title: "Freight value"
description: "Freight charged to customers, in BRL."
tags: [revenue, logistics]
aliases: ["shipping revenue", "运费", "运费收入"]
unit: BRL
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
  - id: fct-orders
    resource: ../../databases/type=duckdb/database=olist/schema=main/table=fct_orders.md
    title: fct_orders table context
---

# Definition

Sum of freight charged on order items.

# Computation

```sql
SELECT SUM(freight_value) AS freight_value
FROM fct_orders;
```

One row per order.

# Dimensions

- [Order date](/dimensions/date.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)
- [Delivery timeliness](/dimensions/delivery-timeliness.md)

# Notes

- Full-period baseline: 2,251,909.54 BRL.
- Zero for orders without items.

# Related metrics

- [Gmv](/metrics/gmv.md)
- [Merchandise Value](/metrics/merchandise-value.md)
- [Average Order Value](/metrics/average-order-value.md)
