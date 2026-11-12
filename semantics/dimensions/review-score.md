---
type: Dimension
title: Review score
description: Customer review score from 1 to 5.
tags:
- review
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
- id: olist-order-reviews-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_order_reviews_dataset.md
  title: olist_order_reviews_dataset table context
---

# Definition

Review score as a string so it can be used as a categorical dimension. `1` is the worst, `5` the best.

# SQL

```sql
CAST(review_score AS VARCHAR) AS review_score
```

# Available in

- [olist_order_reviews_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_order_reviews_dataset.md)

# Notes

- 768 orders have no review; they are not in `olist_order_reviews_dataset`.
- Deduplicate to the latest review per order before aggregating; low reviews are scores 1-2.
