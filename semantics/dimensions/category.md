---
type: Dimension
title: Product category
description: Product category in English.
tags: [product]
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
---

# Definition

English product category (`category_en`). `unknown` groups products with no category in the source data.

# SQL

```sql
category_en
```

# Available in

- [fct_order_items](../../databases/type=duckdb/database=olist/schema=main/table=fct_order_items.md)
- [dim_products](../../databases/type=duckdb/database=olist/schema=main/table=dim_products.md)

# Notes

- 1,603 item rows map to `unknown` (610 products have no category).
- For unit/revenue metrics use `fct_order_items.category_en`; for catalogue counts use `dim_products.category_en`.
