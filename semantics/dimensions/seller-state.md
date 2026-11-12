---
type: Dimension
title: Seller state
description: Two-letter Brazilian state of the seller.
tags: [geography, seller]
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
---

# Definition

Seller state from the seller address.

# SQL

```sql
seller_state
```

# Available in

- [fct_order_items](../../databases/type=duckdb/database=olist/schema=main/table=fct_order_items.md)
- [dim_sellers](../../databases/type=duckdb/database=olist/schema=main/table=dim_sellers.md)

# Notes

- Sellers concentrate in SP (1,849), PR, MG, SC and RJ.
