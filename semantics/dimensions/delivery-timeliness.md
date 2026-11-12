---
type: Dimension
title: Delivery timeliness
description: Whether a delivered order arrived late.
tags:
- delivery
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

`late` when the order was delivered after `order_estimated_delivery_date`, else `on_time`. Non-delivered orders are `on_time` and must be excluded from late-rate denominators.

# SQL

```sql
CASE WHEN order_status = 'delivered'
          AND order_delivered_customer_date > order_estimated_delivery_date
     THEN 'late' ELSE 'on_time' END AS delivery_timeliness
```

# Available in

- [olist_orders_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_orders_dataset.md)

# Notes

- Use it with delivered orders only: `WHERE order_status = 'delivered'`.
- `order_delivered_customer_date` is null for undelivered orders.
