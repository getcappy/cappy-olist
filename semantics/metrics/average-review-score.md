---
type: Metric
title: "Average review score"
description: "Average customer review score from 1 to 5."
tags: [review]
aliases: ["avg rating", "平均评分", "满意度"]
unit: score
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
  - id: fct-reviews
    resource: ../../databases/type=duckdb/database=olist/schema=main/table=fct_reviews.md
    title: fct_reviews table context
---

# Definition

Average `review_score` over reviews. Orders without a review are excluded.

# Computation

```sql
SELECT AVG(review_score) AS average_review_score
FROM fct_reviews;
```

One row per reviewed order (latest review).

# Dimensions

- [Review date](/dimensions/review-date.md)
- [Review score](/dimensions/review-score.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 4.086.
- 768 orders have no review and are not in this table.
- Do not average raw reviews without deduplicating by order.

# Related metrics

- [Reviews](/metrics/reviews.md)
- [Low Reviews](/metrics/low-reviews.md)
- [Low Review Rate](/metrics/low-review-rate.md)
