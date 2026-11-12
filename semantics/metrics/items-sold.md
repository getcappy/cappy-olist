---
type: Metric
title: Items sold
description: Number of order items (units) sold.
tags:
- product
aliases:
- units sold
- 销量
- 件数
unit: items
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

Count of order-item rows across all orders. An order with 3 items counts as 3.

# Computation

```sql
SELECT COUNT(*) AS items_sold FROM olist_order_items_dataset;
```

One row per order item (`order_id + order_item_id`).

# Dimensions

- [Order date](/dimensions/date.md)
- [Order status](/dimensions/order-status.md)
- [Product category](/dimensions/category.md)
- [Seller state](/dimensions/seller-state.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 112,650 items.
- `items_sold` counts units; `orders` counts orders — do not mix them in one ratio unless intended.

# Related metrics

- [Item Revenue](/metrics/item-revenue.md)
- [Average Item Price](/metrics/average-item-price.md)
