---
type: Dimension
title: Review score
description: Customer review score from 1 to 5.
tags: [review]
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
---

# Definition

Review score as a string so it can be used as a categorical dimension. `1` is the worst, `5` the best.

# SQL

```sql
CAST(review_score AS VARCHAR) AS review_score
```

# Available in

- [fct_reviews](../../databases/type=duckdb/database=olist/schema=main/table=fct_reviews.md)

# Notes

- 768 orders have no review; they are not in `fct_reviews`.
- Low reviews are scores 1-2.
