---
type: Dimension
title: Order status
description: Order lifecycle status.
tags:
- orders
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

Current status of the order. Values: `delivered`, `shipped`, `canceled`, `unavailable`, `invoiced`, `processing`, `created`, `approved`.

# SQL

```sql
order_status
```

# Available in

- [olist_orders_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_orders_dataset.md)

# Notes

- Only `delivered` orders have delivery dates.
- `canceled` is the cancellation flag; `unavailable` is a separate status.
- Items/payments/reviews need a join to `olist_orders_dataset` on `order_id`.
