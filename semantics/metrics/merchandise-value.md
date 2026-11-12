---
type: Metric
title: "Merchandise value"
description: "Item prices excluding freight, in BRL."
tags: [revenue]
aliases: ["product revenue", "item revenue", "商品收入", "商品销售额"]
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

Sum of item prices (`merchandise_value`), excluding freight.

# Computation

```sql
SELECT SUM(merchandise_value) AS merchandise_value
FROM fct_orders;
```

One row per order; `merchandise_value` is already aggregated to order grain.

# Dimensions

- [Order date](/dimensions/date.md)
- [Order status](/dimensions/order-status.md)
- [Customer state](/dimensions/customer-state.md)
- [Delivery timeliness](/dimensions/delivery-timeliness.md)

# Notes

- Full-period baseline: 13,591,643.70 BRL.
- For category-level merchandise revenue use `item-revenue` on `fct_order_items`.

# Related metrics

- [Gmv](/metrics/gmv.md)
- [Freight Value](/metrics/freight-value.md)
- [Item Revenue](/metrics/item-revenue.md)
