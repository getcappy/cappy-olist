---
type: Dimension
title: Weight band
description: Product weight grouped into bands.
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

Product weight bands: `< 500 g`, `500 g - 2 kg`, `2 - 10 kg`, `10 kg +`.

# SQL

```sql
weight_band
```

# Available in

- [dim_products](../../databases/type=duckdb/database=olist/schema=main/table=dim_products.md)

# Notes

- Weight is `weight_g`; 0 means the source weight was missing.
