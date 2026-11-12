---
type: Metric
title: Average item price
description: Item revenue divided by items sold.
tags:
- product
aliases:
- 平均商品单价
- 平均件单价
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

`average_item_price = item_revenue / items_sold`.

# Computation

```sql
SELECT SUM(price) / NULLIF(COUNT(*), 0) AS average_item_price FROM olist_order_items_dataset;
```

One row per order item; aggregate first, then divide.

# Dimensions

- [Order date](/dimensions/date.md)
- [Product category](/dimensions/category.md)
- [Seller state](/dimensions/seller-state.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 120.65 BRL.
- Weighted by units, not the average of per-order prices.

# Related metrics

- [Item Revenue](/metrics/item-revenue.md)
- [Items Sold](/metrics/items-sold.md)
