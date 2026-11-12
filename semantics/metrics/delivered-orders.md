---
type: Metric
title: Delivered orders
description: Orders with status delivered.
tags:
- orders
- delivery
aliases:
- completed orders
- 已送达订单
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

Count of orders whose `order_status = 'delivered'`.

# Computation

```sql
SELECT COUNT(*) AS delivered_orders FROM olist_orders_dataset WHERE order_status = 'delivered';
```

One row per order.

# Dimensions

- [Order date](/dimensions/date.md)
- [Customer state](/dimensions/customer-state.md)
- [Delivery timeliness](/dimensions/delivery-timeliness.md)

# Notes

- Full-period baseline: 96,478 delivered orders.
- This is the denominator for `late-delivery-rate`.

# Related metrics

- [Orders](/metrics/orders.md)
- [Late Orders](/metrics/late-orders.md)
- [Late Delivery Rate](/metrics/late-delivery-rate.md)
