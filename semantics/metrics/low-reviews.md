---
type: Metric
title: Low reviews
description: Reviews with a score of 1 or 2.
tags:
- review
aliases:
- negative reviews
- 差评数
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

Count of reviews where `review_score <= 2`.

# Computation

```sql
WITH latest_review AS (
    SELECT review_score,
           row_number() OVER (
               PARTITION BY order_id
               ORDER BY review_answer_timestamp DESC NULLS LAST, review_creation_date DESC
           ) AS rn
    FROM olist_order_reviews_dataset
)
SELECT SUM(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END) AS low_reviews FROM latest_review WHERE rn = 1;
```

Deduplicate `olist_order_reviews_dataset` to the latest review per order, then count scores <= 2.

# Dimensions

- [Review date](/dimensions/review-date.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 14,494 low reviews (score 1 or 2), after dedupe.

# Related metrics

- [Reviews](/metrics/reviews.md)
- [Low Review Rate](/metrics/low-review-rate.md)
