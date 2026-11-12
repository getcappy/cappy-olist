---
type: Dimension
title: Order date
description: Date the order was placed (purchase timestamp).
tags: [time]
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
---

# Definition

Order purchase date. Slice monthly with `DATE_TRUNC('month', purchase_ts)`, yearly with `DATE_TRUNC('year', purchase_ts)`.

# SQL

```sql
DATE_TRUNC('month', purchase_ts) AS month
```

# Available in

- [fct_orders](../../databases/type=duckdb/database=olist/schema=main/table=fct_orders.md)
- [fct_order_items](../../databases/type=duckdb/database=olist/schema=main/table=fct_order_items.md)
- [fct_payments](../../databases/type=duckdb/database=olist/schema=main/table=fct_payments.md)

# Notes

- Data spans 2016-09-04 to 2018-10-17.
- 2018-09 and 2018-10 are incomplete: report trends through 2018-08 unless the question asks for the tail.
