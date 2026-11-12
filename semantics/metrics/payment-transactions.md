---
type: Metric
title: Payment transactions
description: Number of payment transactions.
tags:
- payment
aliases:
- payment count
- 支付笔数
unit: transactions
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

Count of payment transaction rows (`order_id + payment_sequential`).

# Computation

```sql
SELECT COUNT(*) AS payment_transactions FROM olist_order_payments_dataset;
```

One row per payment transaction.

# Dimensions

- [Order date](/dimensions/date.md)
- [Payment type](/dimensions/payment-type.md)
- [Instalment band](/dimensions/installment-band.md)
- [Order status](/dimensions/order-status.md)

# Notes

- Full-period baseline: 103,886 transactions.
- More transactions than orders because some orders are split across payments.

# Related metrics

- [Payment Value](/metrics/payment-value.md)
