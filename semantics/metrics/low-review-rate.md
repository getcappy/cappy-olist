---
type: Metric
title: "Low review rate"
description: "Low reviews divided by all reviews."
tags: [review]
aliases: ["差评率", "negative review rate"]
unit: ratio
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

`low_review_rate = low_reviews / reviews`, where low means score 1 or 2.

# Computation

```sql
SELECT
    SUM(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END)
    / NULLIF(COUNT(*), 0) AS low_review_rate
FROM fct_reviews;
```

One row per reviewed order.

# Dimensions

- [Review date](/dimensions/review-date.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 14.69% (14,494 / 98,673).

# Related metrics

- [Reviews](/metrics/reviews.md)
- [Low Reviews](/metrics/low-reviews.md)
