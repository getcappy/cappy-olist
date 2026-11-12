---
type: Metric
title: Canceled orders
description: Orders with status canceled.
tags:
- orders
aliases:
- cancellations
- 取消订单
unit: orders
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

Count of orders whose `order_status = 'canceled'`.

# Computation

```sql
SELECT COUNT(*) AS canceled_orders FROM olist_orders_dataset WHERE order_status = 'canceled';
```

One row per order.

# Dimensions

- [Order date](/dimensions/date.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 625 canceled orders.
- `unavailable` orders are a separate status and are not counted here.

# Related metrics

- [Orders](/metrics/orders.md)
- [Cancellation Rate](/metrics/cancellation-rate.md)
