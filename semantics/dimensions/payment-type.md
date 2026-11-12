---
type: Dimension
title: Payment type
description: Payment method used for a transaction.
tags: [payment]
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
---

# Definition

Payment method. Values: `credit_card`, `boleto`, `voucher`, `debit_card`, `not_defined`.

# SQL

```sql
payment_type
```

# Available in

- [fct_payments](../../databases/type=duckdb/database=olist/schema=main/table=fct_payments.md)

# Notes

- An order can have several payment rows (card + voucher, split payments). Sum payment values, do not join to orders and count rows.
