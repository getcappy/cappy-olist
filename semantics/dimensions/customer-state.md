---
type: Dimension
title: Customer state
description: Two-letter Brazilian state of the customer.
tags: [geography]
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
---

# Definition

Customer state from the order address. Values: AC, AL, AM, AP, BA, CE, DF, ES, GO, MA, MG, MS, MT, PA, PB, PE, PI, PR, RJ, RN, RO, RR, RS, SC, SE, SP, TO.

# SQL

```sql
customer_state
```

# Available in

- [fct_orders](../../databases/type=duckdb/database=olist/schema=main/table=fct_orders.md)
- [fct_order_items](../../databases/type=duckdb/database=olist/schema=main/table=fct_order_items.md)
- [fct_payments](../../databases/type=duckdb/database=olist/schema=main/table=fct_payments.md)
- [fct_reviews](../../databases/type=duckdb/database=olist/schema=main/table=fct_reviews.md)
- [dim_customers](../../databases/type=duckdb/database=olist/schema=main/table=dim_customers.md)

# Notes

- SP is the largest market by far (about 42% of orders).
- For customer-level metrics use the dimension on `dim_customers`; for order-level metrics use `fct_orders`.
