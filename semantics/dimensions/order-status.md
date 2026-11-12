---
type: Dimension
title: Order status
description: Order lifecycle status.
tags: [orders]
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
---

# Definition

Current status of the order. Values: `delivered`, `shipped`, `canceled`, `unavailable`, `invoiced`, `processing`, `created`, `approved`.

# SQL

```sql
order_status
```

# Available in

- [fct_orders](../../databases/type=duckdb/database=olist/schema=main/table=fct_orders.md)
- [fct_order_items](../../databases/type=duckdb/database=olist/schema=main/table=fct_order_items.md)
- [fct_payments](../../databases/type=duckdb/database=olist/schema=main/table=fct_payments.md)
- [fct_reviews](../../databases/type=duckdb/database=olist/schema=main/table=fct_reviews.md)

# Notes

- Only `delivered` orders have delivery dates and `delivery_days`.
- `canceled` is the cancellation flag; `unavailable` means the order could not be fulfilled.
