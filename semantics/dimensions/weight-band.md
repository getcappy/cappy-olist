---
type: Dimension
title: Weight band
description: Product weight grouped into bands.
tags:
- product
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
- id: olist-products-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_products_dataset.md
  title: olist_products_dataset table context
---

# Definition

Product weight bands: `< 500 g`, `500 g - 2 kg`, `2 - 10 kg`, `10 kg +`.

# SQL

```sql
CASE WHEN product_weight_g < 500 THEN '< 500 g'
     WHEN product_weight_g < 2000 THEN '500 g - 2 kg'
     WHEN product_weight_g < 10000 THEN '2 - 10 kg'
     ELSE '10 kg +' END AS weight_band
```

# Available in

- [olist_products_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_products_dataset.md)

# Notes

- Weight is `product_weight_g`; null or 0 means the source weight was missing.
