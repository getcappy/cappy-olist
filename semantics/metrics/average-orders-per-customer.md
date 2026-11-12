---
type: Metric
title: Average orders per customer
description: Average number of orders per customer.
tags:
- customer
- orders
aliases:
- order frequency
- 人均订单数
unit: orders
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
- id: olist-orders-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_orders_dataset.md
  title: olist_orders_dataset table context
---

# Definition

Average of `order_count` across customers.

# Computation

```sql
SELECT
    COUNT(*)::DOUBLE / NULLIF((SELECT COUNT(DISTINCT customer_unique_id) FROM olist_customers_dataset), 0)::DOUBLE AS average_orders_per_customer
FROM olist_orders_dataset;
```

Total orders divided by distinct `customer_unique_id`; `customer_id` is per order, not per customer.

# Dimensions

- [Customer first order date](/dimensions/customer-first-order-date.md)
- [Customer state](/dimensions/customer-state.md)
- [Customer type](/dimensions/customer-type.md)

# Notes

- Full-period baseline: 1.035.
- The denominator is customers (96,096), not orders.

# Related metrics

- [Customers](/metrics/customers.md)
- [Orders](/metrics/orders.md)
