---
type: Metric
title: "Canceled orders"
description: "Orders with status canceled."
tags: [orders]
aliases: ["cancellations", "取消订单"]
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

Count of orders whose `order_status = 'canceled'`.

# Computation

```sql
SELECT SUM(CASE WHEN is_canceled THEN 1 ELSE 0 END) AS canceled_orders
FROM fct_orders;
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
