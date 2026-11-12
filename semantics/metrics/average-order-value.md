---
type: Metric
title: "Average order value (AOV)"
description: "GMV divided by the number of orders."
tags: [revenue, orders]
aliases: ["AOV", "客单价", "平均订单金额"]
unit: BRL
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

`average_order_value = gmv / orders`. It is a ratio of two aggregates, not the average of per-order AOVs.

# Computation

```sql
SELECT SUM(gmv) / NULLIF(COUNT(*), 0) AS average_order_value
FROM fct_orders;
```

One row per order; aggregate first, then divide.

# Dimensions

- [Order date](/dimensions/date.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)
- [Delivery timeliness](/dimensions/delivery-timeliness.md)

# Notes

- Full-period baseline: 159.33 BRL.
- At a slice, compute `SUM(gmv) / COUNT(*)` inside that slice; never average an AOV column.

# Related metrics

- [Gmv](/metrics/gmv.md)
- [Orders](/metrics/orders.md)
