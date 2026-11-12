---
type: Metric
title: Item revenue
description: Item prices excluding freight.
tags:
- revenue
- product
aliases:
- product revenue
- 类目收入
- 商品行收入
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

Sum of `item_price` over order items, excluding freight. Use it for category, seller and product revenue.

# Computation

```sql
SELECT SUM(price) AS item_revenue FROM olist_order_items_dataset;
```

One row per order item.

# Dimensions

- [Order date](/dimensions/date.md)
- [Order status](/dimensions/order-status.md)
- [Product category](/dimensions/category.md)
- [Seller state](/dimensions/seller-state.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 13,591,643.70 BRL.
- Matches `merchandise-value` at the total level; use this one when slicing by product category.

# Related metrics

- [Items Sold](/metrics/items-sold.md)
- [Average Item Price](/metrics/average-item-price.md)
- [Merchandise Value](/metrics/merchandise-value.md)
