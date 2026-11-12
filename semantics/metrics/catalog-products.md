---
type: Metric
title: Catalogue products
description: Number of products in the catalogue.
tags:
- product
aliases:
- product count
- SKU count
- 商品数
unit: products
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

Count of distinct products in `olist_products_dataset` (one row per `product_id`).

# Computation

```sql
SELECT COUNT(*) AS catalog_products FROM olist_products_dataset;
```

One row per product.

# Dimensions

- [Product category](/dimensions/category.md)
- [Weight band](/dimensions/weight-band.md)

# Notes

- Full-period baseline: 32,951 products.
- 610 products have no category and appear as `unknown`.

# Related metrics

- [Sellers](/metrics/sellers.md)
- [Items Sold](/metrics/items-sold.md)
