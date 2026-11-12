---
type: Dimension
title: Order date
description: Date the order was placed (purchase timestamp).
tags:
- time
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
---

# Definition

Order purchase date from `olist_orders_dataset.order_purchase_timestamp`. Slice monthly with `DATE_TRUNC('month', order_purchase_timestamp)`, yearly with `DATE_TRUNC('year', ...)`.

# SQL

```sql
DATE_TRUNC('month', order_purchase_timestamp) AS month
```

# Available in

- [olist_orders_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_orders_dataset.md)

# Notes

- Data spans 2016-09-04 to 2018-10-17.
- 2018-09 and 2018-10 are incomplete; report trends through 2018-08 unless the question asks for the tail.
- Items/payments/reviews have no purchase date; join `olist_orders_dataset` on `order_id` first.
