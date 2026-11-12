---
type: Metric
title: "Sellers"
description: "Number of sellers."
tags: [seller]
aliases: ["seller count", "卖家数", "商家数"]
unit: sellers
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
  - id: dim-sellers
    resource: ../../databases/type=duckdb/database=olist/schema=main/table=dim_sellers.md
    title: dim_sellers table context
---

# Definition

Count of distinct sellers in `dim_sellers` (one row per `seller_id`).

# Computation

```sql
SELECT COUNT(*) AS sellers
FROM dim_sellers;
```

One row per seller.

# Dimensions

- [Seller state](/dimensions/seller-state.md)

# Notes

- Full-period baseline: 3,095 sellers.
- Most sellers are based in SP (1,849).

# Related metrics

- [Catalog Products](/metrics/catalog-products.md)
- [Items Sold](/metrics/items-sold.md)
