---
type: DuckDB Table
title: Olist Order Payments Dataset
database: olist
schema: main
tags: []
---

# 描述

原始支付表，一行一笔支付（`order_id + payment_sequential`，共 103,886 行）。表名、列名与 Kaggle CSV 完全一致，**未做任何处理**。

- 一个订单可能有多笔支付（信用卡 + 优惠券、拆分支付、分期等）；按订单汇总前必须先 `SUM(payment_value) GROUP BY order_id`。
- `payment_type`：credit_card、boleto、voucher、debit_card、not_defined。
- 支付金额合计约 16.01M，与商品+运费口径（约 15.84M）不同，不要混用。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 103,886 |
| **Column Count** | 5 |

| Column | Type | Description |
|--------|------|-------------|
| `order_id` | string |  |
| `payment_sequential` | int32 |  |
| `payment_type` | string |  |
| `payment_installments` | int32 |  |
| `payment_value` | decimal(12, 2) |  |

# 数据采样

| order_id | payment_sequential | payment_type | payment_installments | payment_value |
| --- | --- | --- | --- | --- |
| b81ef226f3fe1789b1e8b2acac839d17 | 1 | credit_card | 8 | 99.33 |
| a9810da82917af2d9aefd1278f1dcfa0 | 1 | credit_card | 1 | 24.39 |
| 25e8ea4e93396b6fa0d3dd708e76c1bd | 1 | credit_card | 1 | 65.71 |
| ba78997921bbcdc1373bb41e913ab953 | 1 | credit_card | 8 | 107.78 |
| 42fdf880ba16b47b59251dd489d4441a | 1 | credit_card | 2 | 128.45 |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T12:21:05.273293+00:00`

**Columns:** 5

## Column Profiles (JSONL)

- {"column": "order_id", "type": "string", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 99440}
- {"column": "payment_sequential", "type": "int32", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 29, "min": 1, "max": 29, "mean": 1.0927, "stddev": 0.7066}
- {"column": "payment_type", "type": "string", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 5, "top_values": [{"value": "credit_card", "count": 76795}, {"value": "boleto", "count": 19784}, {"value": "voucher", "count": 5775}, {"value": "debit_card", "count": 1529}, {"value": "not_defined", "count": 3}]}
- {"column": "payment_installments", "type": "int32", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 24, "min": 0, "max": 24, "mean": 2.8533, "stddev": 2.687}
- {"column": "payment_value", "type": "decimal(12, 2)", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 29077, "min": "0.00", "max": "13664.08", "mean": 154.1004, "stddev": 217.493}

# 关联关系

- `olist_orders_dataset`：`order_id` → `order_id`（多对一）
