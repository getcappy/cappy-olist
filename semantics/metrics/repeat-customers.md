---
type: Metric
title: Repeat customers
description: Customers with more than one order.
tags:
- customer
aliases:
- returning customers
- 复购客户
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
- id: olist-orders-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_orders_dataset.md
  title: olist_orders_dataset table context
---

# Definition

Count of customers whose `order_count > 1`.

# Computation

```sql
WITH customer_orders AS (
    SELECT c.customer_unique_id, COUNT(*) AS order_count
    FROM olist_customers_dataset AS c
    JOIN olist_orders_dataset AS o ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT COUNT(*) AS repeat_customers FROM customer_orders WHERE order_count > 1;
```

Join `olist_customers_dataset` to `olist_orders_dataset` on `customer_id`, count orders per `customer_unique_id`, keep those with more than one.

# Dimensions

- [Customer first order date](/dimensions/customer-first-order-date.md)
- [Customer state](/dimensions/customer-state.md)
- [Customer type](/dimensions/customer-type.md)

# Notes

- Full-period baseline: 2,997 repeat customers.
- A repeat customer is defined by lifetime order count, not by orders within a period.

# Related metrics

- [Customers](/metrics/customers.md)
- [Repeat Customer Rate](/metrics/repeat-customer-rate.md)
