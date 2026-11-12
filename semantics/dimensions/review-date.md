---
type: Dimension
title: Review date
description: Date the review was created.
tags: [time, review]
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
---

# Definition

Review creation timestamp. Use it when analysing satisfaction over time, distinct from the order date.

# SQL

```sql
DATE_TRUNC('month', review_creation_ts) AS review_month
```

# Available in

- [fct_reviews](../../databases/type=duckdb/database=olist/schema=main/table=fct_reviews.md)

# Notes

- Review date can lag the order date by days or weeks.
