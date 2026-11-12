---
type: Metric
title: "Payment value"
description: "Total value collected through payments."
tags: [payment, revenue]
aliases: ["collected revenue", "支付金额", "收款金额"]
unit: BRL
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
  - id: fct-payments
    resource: ../../databases/type=duckdb/database=olist/schema=main/table=fct_payments.md
    title: fct_payments table context
---

# Definition

Sum of `payment_value` over payment transactions. It is a cash-collection measure, not GMV.

# Computation

```sql
SELECT SUM(payment_value) AS payment_value
FROM fct_payments;
```

One row per payment transaction; an order can have several.

# Dimensions

- [Order date](/dimensions/date.md)
- [Payment type](/dimensions/payment-type.md)
- [Instalment band](/dimensions/installment-band.md)
- [Order status](/dimensions/order-status.md)

# Notes

- Full-period baseline: 16,008,872.12 BRL.
- Differs from GMV (15,843,553.24) because of instalments, vouchers, split payments and `not_defined` rows.
- Do not join payments to order items and sum both.

# Related metrics

- [Gmv](/metrics/gmv.md)
- [Payment Transactions](/metrics/payment-transactions.md)
- [Average Payment Value](/metrics/average-payment-value.md)
