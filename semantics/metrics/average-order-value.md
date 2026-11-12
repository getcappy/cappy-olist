---
type: Metric
title: Average order value (AOV)
description: GMV divided by the number of orders.
tags:
- revenue
- orders
aliases:
- AOV
- 客单价
- 平均订单金额
unit: BRL
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
- id: olist-order-items-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_order_items_dataset.md
  title: olist_order_items_dataset table context
---

# Definition

`average_order_value = gmv / orders`. It is a ratio of two aggregates, not the average of per-order AOVs.

# Computation

```sql
WITH order_gmv AS (
    SELECT o.order_id, COALESCE(SUM(i.price + i.freight_value), 0) AS gmv
    FROM olist_orders_dataset AS o
    LEFT JOIN olist_order_items_dataset AS i ON o.order_id = i.order_id
    GROUP BY o.order_id
)
SELECT SUM(gmv) / NULLIF((SELECT COUNT(*) FROM olist_orders_dataset), 0) AS average_order_value
FROM order_gmv;
```

Aggregate GMV and order count separately, then divide; never average per-order values.

# Dimensions

- [Order date](/dimensions/date.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)
- [Delivery timeliness](/dimensions/delivery-timeliness.md)

# Notes

- Full-period baseline: 159.33 BRL.
- At a slice, compute `SUM(price + freight_value) / COUNT(orders)` inside that slice; never average an AOV column.

# Related metrics

- [Gmv](/metrics/gmv.md)
- [Orders](/metrics/orders.md)
