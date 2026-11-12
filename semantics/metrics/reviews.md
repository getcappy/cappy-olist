---
type: Metric
title: Reviews
description: Number of reviews.
tags:
- review
aliases:
- review count
- 评价数
unit: reviews
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

Count of reviews after keeping the latest review per order; the raw table may have several reviews per order.

# Computation

```sql
WITH latest_review AS (
    SELECT order_id,
           row_number() OVER (
               PARTITION BY order_id
               ORDER BY review_answer_timestamp DESC NULLS LAST, review_creation_date DESC
           ) AS rn
    FROM olist_order_reviews_dataset
)
SELECT COUNT(*) AS reviews FROM latest_review WHERE rn = 1;
```

`olist_order_reviews_dataset` has 99,224 raw rows; the computation keeps one (latest) review per order.

# Dimensions

- [Review date](/dimensions/review-date.md)
- [Review score](/dimensions/review-score.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 98,673 reviews after keeping one review per order.
- The raw file has 99,224 rows; the computation keeps the latest review per order.

# Related metrics

- [Average Review Score](/metrics/average-review-score.md)
- [Low Reviews](/metrics/low-reviews.md)
