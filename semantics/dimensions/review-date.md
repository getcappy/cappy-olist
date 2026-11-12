---
type: Dimension
title: Review date
description: Date the review was created.
tags:
- time
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

Review creation timestamp from `olist_order_reviews_dataset.review_creation_date`. Use it when analysing satisfaction over time, distinct from the order date.

# SQL

```sql
DATE_TRUNC('month', review_creation_date) AS review_month
```

# Available in

- [olist_order_reviews_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_order_reviews_dataset.md)

# Notes

- Review date can lag the order date by days or weeks.
- Join `olist_orders_dataset` on `order_id` for order attributes.
