---
type: Metric
title: "GMV"
description: "Gross merchandise value: item prices plus freight, in BRL."
tags: [revenue, orders]
aliases: ["revenue", "gross merchandise value", "营收", "销售额", "成交总额"]
unit: BRL
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
  - id: fct-orders
    resource: ../../databases/type=duckdb/database=olist/schema=main/table=fct_orders.md
    title: fct_orders table context
---

# Definition

Total value transacted on the marketplace: the sum of item prices and freight. `gmv = merchandise_value + freight_value`. This is the default meaning of "revenue" in this project.

# Computation

```sql
SELECT SUM(gmv) AS gmv
FROM fct_orders;
```

One row per order in `fct_orders`; summing `gmv` is correct at any slice (state, month, or category via `fct_order_items`).

# Dimensions

- [Order date](/dimensions/date.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)
- [Delivery timeliness](/dimensions/delivery-timeliness.md)

# Notes

- Does not use `payment_value`; payment totals differ because of instalments, vouchers, split payments and undefined payment types.
- Orders without items (775, mostly canceled/unavailable) have `gmv = 0`.
- Full-period baseline: 15,843,553.24 BRL.

# Related metrics

- [Merchandise Value](/metrics/merchandise-value.md)
- [Freight Value](/metrics/freight-value.md)
- [Average Order Value](/metrics/average-order-value.md)
- [Payment Value](/metrics/payment-value.md)
