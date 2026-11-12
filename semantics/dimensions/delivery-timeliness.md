---
type: Dimension
title: Delivery timeliness
description: Whether a delivered order arrived late.
tags: [delivery]
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
---

# Definition

`late` when the order was delivered after `estimated_delivery_ts`, else `on_time`. Non-delivered orders are `on_time` and must be excluded from late-rate denominators.

# SQL

```sql
CASE WHEN is_late THEN 'late' ELSE 'on_time' END AS delivery_timeliness
```

# Available in

- [fct_orders](../../databases/type=duckdb/database=olist/schema=main/table=fct_orders.md)

# Notes

- Use it with delivered orders only: `WHERE is_delivered`.
