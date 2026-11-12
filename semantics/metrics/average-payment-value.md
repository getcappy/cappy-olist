---
type: Metric
title: Average payment value
description: Payment value divided by payment transactions.
tags:
- payment
aliases:
- 平均支付金额
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
- id: olist-order-payments-dataset
  resource: ../../databases/type=duckdb/database=olist/schema=main/table=olist_order_payments_dataset.md
  title: olist_order_payments_dataset table context
---

# Definition

`average_payment_value = payment_value / payment_transactions`.

# Computation

```sql
SELECT SUM(payment_value) / NULLIF(COUNT(*), 0) AS average_payment_value FROM olist_order_payments_dataset;
```

One row per payment transaction.

# Dimensions

- [Order date](/dimensions/date.md)
- [Payment type](/dimensions/payment-type.md)
- [Instalment band](/dimensions/installment-band.md)
- [Order status](/dimensions/order-status.md)

# Notes

- Full-period baseline: 154.10 BRL.
- This is per transaction, not per order; split payments lower it.

# Related metrics

- [Payment Value](/metrics/payment-value.md)
- [Payment Transactions](/metrics/payment-transactions.md)
