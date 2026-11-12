---
type: Metric
title: "Low reviews"
description: "Reviews with a score of 1 or 2."
tags: [review]
aliases: ["negative reviews", "差评数"]
unit: reviews
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

Count of reviews where `review_score <= 2`.

# Computation

```sql
SELECT SUM(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END) AS low_reviews
FROM fct_reviews;
```

One row per reviewed order.

# Dimensions

- [Review date](/dimensions/review-date.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 14,494 low reviews.

# Related metrics

- [Reviews](/metrics/reviews.md)
- [Low Review Rate](/metrics/low-review-rate.md)
