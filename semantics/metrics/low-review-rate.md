---
type: Metric
title: Low review rate
description: Low reviews divided by all reviews.
tags:
- review
aliases:
- 差评率
- negative review rate
unit: ratio
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

`low_review_rate = low_reviews / reviews`, where low means score 1 or 2.

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
SELECT
    SUM(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END)
    / NULLIF(COUNT(*), 0) AS low_review_rate
FROM latest_review WHERE rn = 1;
```

Deduplicate reviews to the latest per order, then divide low reviews by all reviews.

# Dimensions

- [Review date](/dimensions/review-date.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 14.69% (14,494 / 98,673).

# Related metrics

- [Reviews](/metrics/reviews.md)
- [Low Reviews](/metrics/low-reviews.md)
