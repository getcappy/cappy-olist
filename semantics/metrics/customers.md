---
type: Metric
title: Customers
description: Number of distinct customers.
tags:
- customer
aliases:
- customer count
- 客户数
- 买家数
unit: customers
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
- id: olist-customers-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_customers_dataset.md
  title: olist_customers_dataset table context
---

# Definition

Count of distinct `customer_unique_id` in `olist_customers_dataset`. The table has one row per order, not per customer.

# Computation

```sql
SELECT COUNT(DISTINCT customer_unique_id) AS customers FROM olist_customers_dataset;
```

`olist_customers_dataset` has one row per order (`customer_id`), not per customer; count distinct `customer_unique_id`.

# Dimensions

- [Customer first order date](/dimensions/customer-first-order-date.md)
- [Customer state](/dimensions/customer-state.md)
- [Customer type](/dimensions/customer-type.md)

# Notes

- Full-period baseline: 96,096 customers.
- `olist_customers_dataset` has 99,441 rows (one per `customer_id`); count distinct `customer_unique_id`.

# Related metrics

- [Repeat Customers](/metrics/repeat-customers.md)
- [Repeat Customer Rate](/metrics/repeat-customer-rate.md)
- [Average Customer Value](/metrics/average-customer-value.md)
