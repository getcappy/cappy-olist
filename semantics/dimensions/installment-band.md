---
type: Dimension
title: Instalment band
description: Number of payment instalments grouped into bands.
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

Instalments grouped as `1 (single payment)`, `2-3`, `4-6`, `7-12`, `13+`.

# SQL

```sql
CASE WHEN payment_installments <= 1 THEN '1 (single payment)'
     WHEN payment_installments <= 3 THEN '2-3'
     WHEN payment_installments <= 6 THEN '4-6'
     WHEN payment_installments <= 12 THEN '7-12'
     ELSE '13+' END AS installment_band
```

# Available in

- [olist_order_payments_dataset](../../databases/type=duckdb/database=olist/schema=main/table=olist_order_payments_dataset.md)

# Notes

- Use for instalment-preference analysis; the raw count is `payment_installments`.
