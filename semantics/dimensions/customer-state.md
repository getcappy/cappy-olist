---
type: Dimension
title: Customer state
description: Two-letter Brazilian state of the customer.
tags:
- geography
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

Customer state from the order address. Values: AC, AL, AM, AP, BA, CE, DF, ES, GO, MA, MG, MS, MT, PA, PB, PE, PI, PR, RJ, RN, RO, RR, RS, SC, SE, SP, TO.

# SQL

```sql
customer_state
```

# Available in

- [olist_customers_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_customers_dataset.md)

# Notes

- SP is the largest market by far (about 42% of orders).
- Join `olist_customers_dataset` to `olist_orders_dataset` on `customer_id` to slice order/item/payment/review metrics by state.
- Do not use `olist_geolocation_dataset.state` for business state analysis; it is a postal-code label.
