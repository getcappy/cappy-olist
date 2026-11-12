---
type: Metric
title: "Late orders"
description: "Delivered orders that arrived after the estimated delivery date."
tags: [delivery]
aliases: ["delayed orders", "延迟订单"]
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

Count of delivered orders where `delivered_customer_ts > estimated_delivery_ts`.

# Computation

```sql
SELECT SUM(CASE WHEN is_late THEN 1 ELSE 0 END) AS late_orders
FROM fct_orders;
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
