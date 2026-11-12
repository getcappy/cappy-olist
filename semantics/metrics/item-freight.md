---
type: Metric
title: "Item freight"
description: "Freight on order items."
tags: [product, logistics]
aliases: ["item shipping", "商品运费"]
unit: BRL
status: stable
generated: { by: dsh-agent/deepseek-flash, at: 2026-11-12T09:55:00Z }
verified: { by: process:olist-baseline-check, at: 2026-11-12T09:55:00Z }
sources:
  - id: kaggle
    resource: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
    title: Brazilian E-Commerce Public Dataset by Olist
  - id: fct-order-items
    resource: ../../databases/type=duckdb/database=olist/schema=main/table=fct_order_items.md
    title: fct_order_items table context
---

# Definition

Sum of `freight_value` over order items. Use it to analyse freight by category, seller or state.

# Computation

```sql
SELECT SUM(freight_value) AS item_freight
FROM fct_order_items;
```

One row per order item.

# Dimensions

- [Order date](/dimensions/date.md)
- [Product category](/dimensions/category.md)
- [Seller state](/dimensions/seller-state.md)
- [Customer state](/dimensions/customer-state.md)

# Notes

- Full-period baseline: 2,251,909.54 BRL.

# Related metrics

- [Item Revenue](/metrics/item-revenue.md)
- [Freight Value](/metrics/freight-value.md)
