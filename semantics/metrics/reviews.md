---
type: Metric
title: "Reviews"
description: "Number of reviews."
tags: [review]
aliases: ["review count", "评价数"]
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

Count of reviews, one per reviewed order (latest review when an order has several).

# Computation

```sql
SELECT COUNT(*) AS reviews
FROM fct_reviews;
```

One row per reviewed order.

# Dimensions

- [Review date](/dimensions/review-date.md)
- [Review score](/dimensions/review-score.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 98,673 reviews.
- The raw review file has 99,224 rows; duplicates per order were removed.

# Related metrics

- [Average Review Score](/metrics/average-review-score.md)
- [Low Reviews](/metrics/low-reviews.md)
