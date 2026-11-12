---
type: Metric
title: Merchandise value
description: Item prices excluding freight, in BRL.
tags:
- revenue
aliases:
- product revenue
- item revenue
- 商品收入
- 商品销售额
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
- id: olist-order-items-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_order_items_dataset.md
  title: olist_order_items_dataset table context
---

# Definition

Sum of item prices (`merchandise_value`), excluding freight.

# Computation

```sql
SELECT SUM(price) AS merchandise_value FROM olist_order_items_dataset;
```

One row per order; `merchandise_value` is already aggregated to order grain.

# Dimensions

- [Order date](/dimensions/date.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)
- [Delivery timeliness](/dimensions/delivery-timeliness.md)

# Notes

- Full-period baseline: 13,591,643.70 BRL.
- For category-level merchandise revenue use `item-revenue` on `olist_order_items_dataset`.

# Related metrics

- [Gmv](/metrics/gmv.md)
- [Freight Value](/metrics/freight-value.md)
- [Item Revenue](/metrics/item-revenue.md)
