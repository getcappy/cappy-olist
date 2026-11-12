---
type: Metric
title: Late delivery rate
description: Late delivered orders divided by delivered orders.
tags:
- delivery
aliases:
- delay rate
- 延迟率
- 延迟交付率
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

`late_delivery_rate = late_orders / delivered_orders`. The denominator is delivered orders only.

# Computation

```sql
SELECT
    SUM(CASE WHEN order_status = 'delivered'
              AND order_delivered_customer_date > order_estimated_delivery_date
             THEN 1 ELSE 0 END)
    / NULLIF(SUM(CASE WHEN order_status = 'delivered' THEN 1 ELSE 0 END), 0) AS late_delivery_rate
FROM olist_orders_dataset;
```

One row per order; aggregate the numerator and denominator before dividing.

# Dimensions

- [Order date](/dimensions/date.md)
- [Customer state](/dimensions/customer-state.md)
- [Delivery timeliness](/dimensions/delivery-timeliness.md)

# Notes

- Full-period baseline: 8.11% (7,826 / 96,478).
- Do not use all orders as the denominator: undelivered orders are not on-time.

# Related metrics

- [Late Orders](/metrics/late-orders.md)
- [Delivered Orders](/metrics/delivered-orders.md)
- [Average Delivery Days](/metrics/average-delivery-days.md)
