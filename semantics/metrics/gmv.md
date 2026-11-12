---
type: Metric
title: GMV
description: 'Gross merchandise value: item prices plus freight, in BRL.'
tags:
- revenue
- orders
aliases:
- revenue
- gross merchandise value
- 营收
- 销售额
- 成交总额
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

Total value transacted on the marketplace: the sum of item prices and freight. `gmv = merchandise_value + freight_value`. This is the default meaning of "revenue" in this project.

# Computation

```sql
WITH order_gmv AS (
    SELECT o.order_id, COALESCE(SUM(i.price + i.freight_value), 0) AS gmv
    FROM olist_orders_dataset AS o
    LEFT JOIN olist_order_items_dataset AS i ON o.order_id = i.order_id
    GROUP BY o.order_id
)
SELECT SUM(gmv) AS gmv FROM order_gmv;
```

`olist_orders_dataset` is one row per order; the computation aggregates `olist_order_items_dataset` to order grain first, so orders without items contribute 0.

# Dimensions

- [Order date](/dimensions/date.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)
- [Delivery timeliness](/dimensions/delivery-timeliness.md)

# Notes

- Does not use `payment_value`; payment totals differ because of instalments, vouchers, split payments and undefined payment types.
- Orders without items (775, mostly canceled/unavailable) have `gmv = 0`.
- Full-period baseline: 15,843,553.24 BRL.

# Related metrics

- [Merchandise Value](/metrics/merchandise-value.md)
- [Freight Value](/metrics/freight-value.md)
- [Average Order Value](/metrics/average-order-value.md)
- [Payment Value](/metrics/payment-value.md)
