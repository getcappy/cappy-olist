---
type: Dimension
title: Seller state
description: Two-letter Brazilian state of the seller.
tags:
- geography
- seller
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
- id: olist-sellers-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_sellers_dataset.md
  title: olist_sellers_dataset table context
---

# Definition

Seller state from `olist_sellers_dataset.seller_state`.

# SQL

```sql
seller_state
```

# Available in

- [olist_sellers_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_sellers_dataset.md)
- [olist_order_items_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_order_items_dataset.md)

# Notes

- Sellers concentrate in SP (1,849), PR, MG, SC and RJ.
- Join `olist_order_items_dataset.seller_id` → `olist_sellers_dataset.seller_id`.
