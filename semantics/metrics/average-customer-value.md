---
type: Metric
title: Average customer value
description: Average lifetime GMV per customer.
tags:
- customer
- revenue
aliases:
- customer lifetime value
- LTV
- 客户平均终身价值
- 客均价值
unit: BRL
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
- id: olist-order-items-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_order_items_dataset.md
  title: olist_order_items_dataset table context
---

# Definition

Average of `total_gmv` across customers, where `total_gmv` is the customer's lifetime merchandise plus freight value.

# Computation

```sql
WITH order_gmv AS (
    SELECT o.order_id, c.customer_unique_id,
           COALESCE(SUM(i.price + i.freight_value), 0) AS gmv
    FROM olist_orders_dataset AS o
    JOIN olist_customers_dataset AS c ON o.customer_id = c.customer_id
    LEFT JOIN olist_order_items_dataset AS i ON o.order_id = i.order_id
    GROUP BY o.order_id, c.customer_unique_id
),
customer_value AS (
    SELECT customer_unique_id, SUM(gmv) AS total_gmv
    FROM order_gmv GROUP BY customer_unique_id
)
SELECT AVG(total_gmv) AS average_customer_value FROM customer_value;
```

Attribute each order's item price + freight to `customer_unique_id`, sum per customer, then average.

# Dimensions

- [Customer first order date](/dimensions/customer-first-order-date.md)
- [Customer state](/dimensions/customer-state.md)
- [Customer type](/dimensions/customer-type.md)

# Notes

- Full-period baseline: 164.87 BRL.
- This is a historical lifetime average, not a forward-looking LTV model.

# Related metrics

- [Customers](/metrics/customers.md)
- [Gmv](/metrics/gmv.md)
