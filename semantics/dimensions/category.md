---
type: Dimension
title: Product category
description: Product category in English.
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
- id: product-category-name-translation
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=product_category_name_translation.md
  title: product_category_name_translation table context
- id: olist-order-items-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_order_items_dataset.md
  title: olist_order_items_dataset table context
---

# Definition

English product category, derived from `olist_products_dataset.product_category_name` and `product_category_name_translation.product_category_name_english`. `unknown` groups products with no category.

# SQL

```sql
COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category_en
```

# Available in

- [olist_order_items_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_order_items_dataset.md)
- [olist_products_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_products_dataset.md)
- [product_category_name_translation](../../databases/type=duckdb/database=olist/schema=main/table=product_category_name_translation.md)

# Notes

- 610 products have no category; 1,603 order-item rows map to `unknown`.
- Join path: `olist_order_items_dataset.product_id` → `olist_products_dataset.product_id` → `product_category_name_translation.product_category_name`.
- For item/revenue metrics use this expression on `olist_order_items_dataset`; for catalogue counts use it on `olist_products_dataset`.
