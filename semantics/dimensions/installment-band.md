---
type: Dimension
title: Instalment band
description: Number of payment instalments grouped into bands.
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

Instalments grouped as `1 (single payment)`, `2-3`, `4-6`, `7-12`, `13+`.

# SQL

```sql
installment_band
```

# Available in

- [fct_payments](../../databases/type=duckdb/database=olist/schema=main/table=fct_payments.md)

# Notes

- Use for instalment-preference analysis; the raw count is `installments`.
