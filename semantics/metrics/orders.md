---
type: Metric
title: "Orders"
description: "Number of orders placed."
tags: [orders]
aliases: ["order count", "订单量", "订单数"]
unit: orders
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

Count of orders, one per `order_id`, including canceled and undelivered orders.

# Computation

```sql
SELECT COUNT(*) AS orders
FROM fct_orders;
```

One row per order.

# Dimensions

- [Order date](/dimensions/date.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)
- [Delivery timeliness](/dimensions/delivery-timeliness.md)

# Notes

- Full-period baseline: 99,441 orders.
- Use `delivered_orders` or filter `is_delivered` when the question is about completed orders.

# Related metrics

- [Delivered Orders](/metrics/delivered-orders.md)
- [Canceled Orders](/metrics/canceled-orders.md)
- [Average Order Value](/metrics/average-order-value.md)
