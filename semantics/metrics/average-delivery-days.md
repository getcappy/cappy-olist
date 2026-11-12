---
type: Metric
title: "Average delivery days"
description: "Average days from purchase to delivery for delivered orders."
tags: [delivery]
aliases: ["delivery time", "平均交付天数", "平均配送时长"]
unit: days
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

Average of `delivery_days` = `DATE_DIFF('day', purchase_ts, delivered_customer_ts)` over delivered orders.

# Computation

```sql
SELECT AVG(delivery_days) AS average_delivery_days
FROM fct_orders
WHERE is_delivered;
```

One row per delivered order.

# Dimensions

- [Order date](/dimensions/date.md)
- [Customer state](/dimensions/customer-state.md)
- [Delivery timeliness](/dimensions/delivery-timeliness.md)

# Notes

- Full-period baseline: 12.50 days.
- `delivery_days` is null for undelivered orders; filter `is_delivered` explicitly.

# Related metrics

- [Late Delivery Rate](/metrics/late-delivery-rate.md)
- [Late Orders](/metrics/late-orders.md)
