---
type: Metric
title: Average review score
description: Average customer review score from 1 to 5.
tags:
- review
aliases:
- avg rating
- 平均评分
- 满意度
unit: score
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

Average `review_score` over reviews. Orders without a review are excluded.

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
SELECT AVG(review_score) AS average_review_score FROM latest_review WHERE rn = 1;
```

`olist_order_reviews_dataset` can have multiple reviews per order; deduplicate to the latest review per order before averaging.

# Dimensions

- [Review date](/dimensions/review-date.md)
- [Review score](/dimensions/review-score.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 4.086.
- 768 orders have no review and are not in `olist_order_reviews_dataset`.
- Deduplicate to the latest review per order before averaging.

# Related metrics

- [Reviews](/metrics/reviews.md)
- [Low Reviews](/metrics/low-reviews.md)
- [Low Review Rate](/metrics/low-review-rate.md)
