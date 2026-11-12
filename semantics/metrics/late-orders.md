---
type: Metric
title: Late orders
description: Delivered orders that arrived after the estimated delivery date.
tags:
- delivery
aliases:
- delayed orders
- 延迟订单
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

Count of delivered orders where `delivered_customer_ts > estimated_delivery_ts`.

# Computation

```sql
SELECT COUNT(*) AS late_orders
FROM olist_orders_dataset
WHERE order_status = 'delivered'
  AND order_delivered_customer_date > order_estimated_delivery_date;
```

One row per order.

# Dimensions

- [Order date](/dimensions/date.md)
- [Customer state](/dimensions/customer-state.md)
- [Delivery timeliness](/dimensions/delivery-timeliness.md)

# Notes

- Full-period baseline: 7,826 late orders.
- Only delivered orders can be late; non-delivered orders are never counted.

# Related metrics

- [Delivered Orders](/metrics/delivered-orders.md)
- [Late Delivery Rate](/metrics/late-delivery-rate.md)
