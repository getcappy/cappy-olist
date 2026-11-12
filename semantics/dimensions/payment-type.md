---
type: Dimension
title: Payment type
description: Payment method used for a transaction.
tags:
- payment
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
- id: olist-order-payments-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_order_payments_dataset.md
  title: olist_order_payments_dataset table context
---

# Definition

Payment method. Values: `credit_card`, `boleto`, `voucher`, `debit_card`, `not_defined`.

# SQL

```sql
payment_type
```

# Available in

- [olist_order_payments_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_order_payments_dataset.md)

# Notes

- An order can have several payment rows (card + voucher, split payments). Sum payment values per order instead of counting rows joined to orders.
