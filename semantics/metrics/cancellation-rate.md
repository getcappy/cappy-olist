---
type: Metric
title: Cancellation rate
description: Canceled orders divided by all orders.
tags:
- orders
aliases:
- cancel rate
- 取消率
unit: ratio
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
- id: olist-orders-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_orders_dataset.md
  title: olist_orders_dataset table context
---

# Definition

`cancellation_rate = canceled_orders / orders`. The denominator is all orders.

# Computation

```sql
SELECT
    SUM(CASE WHEN order_status = 'canceled' THEN 1 ELSE 0 END)
    / NULLIF(COUNT(*), 0) AS cancellation_rate
FROM olist_orders_dataset;
```

One row per order.

# Dimensions

- [Order date](/dimensions/date.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 0.63% (625 / 99,441).
- `unavailable` is not counted as canceled.

# Related metrics

- [Canceled Orders](/metrics/canceled-orders.md)
- [Orders](/metrics/orders.md)
