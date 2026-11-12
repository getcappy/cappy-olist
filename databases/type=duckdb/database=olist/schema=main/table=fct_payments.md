---
type: DuckDB Table
title: Fct Payments
database: olist
schema: main
tags: []
---

# 描述

支付流水粒度事实表：一行一笔支付（`order_id + payment_sequential`，共 103,886 行）。金额单位为 BRL。

- 一个订单可能有多笔支付（信用卡 + 优惠券、分期等），按订单汇总支付金额时必须先 `sum(payment_value)`，不能直接 join 后求和。
- `payment_type`：credit_card、boleto、voucher、debit_card、not_defined（3 笔金额为 0）。
- `installment_band` 把分期数分档，便于分析分期偏好。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 103,886 |
| **Column Count** | 10 |

| Column | Type | Description |
|--------|------|-------------|
| `order_id` | string |  |
| `payment_sequential` | int32 |  |
| `payment_type` | string |  |
| `installments` | int32 |  |
| `payment_value` | decimal(12, 2) |  |
| `customer_unique_id` | string |  |
| `customer_state` | string |  |
| `purchase_ts` | timestamp(6) |  |
| `order_status` | string |  |
| `installment_band` | string |  |

# 数据采样

| order_id | payment_sequential | payment_type | installments | payment_value | customer_unique_id | customer_state | purchase_ts | order_status | installment_band |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| e481f51cbdc54678b7cc49136f2d6af7 | 2 | voucher | 1 | 18.59 | 7c396fd4830fd04220f754e42b4e5bff | SP | 2017-10-02 10:56:33 | delivered | 1 (single payment) |
| 53cdb2fc8bc7dce0b6741e2150273451 | 1 | boleto | 1 | 141.46 | af07308b275d755c9edb36a90c618231 | BA | 2018-07-24 20:41:37 | delivered | 1 (single payment) |
| 47770eb9100c2d0c44946d9cf07ec65d | 1 | credit_card | 3 | 179.12 | 3a653a41f6f9fc3d2a113cf8398680e8 | GO | 2018-08-08 08:38:49 | delivered | 2-3 |
| ad21c59c0840e6cb83a9ceb5573f8159 | 1 | credit_card | 1 | 28.62 | 72632f0f9dd73dfee390c9b22eb56dd6 | SP | 2018-02-13 21:18:39 | delivered | 1 (single payment) |
| a4591c265e18cb1dcee52889e2d8acc3 | 1 | credit_card | 6 | 175.26 | 80bb27c7c16e8f973207a5086ab329e2 | PR | 2017-07-09 21:57:05 | delivered | 4-6 |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T09:50:36.406008+00:00`

**Columns:** 10

## Column Profiles (JSONL)

- {"column": "order_id", "type": "string", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 99440}
- {"column": "payment_sequential", "type": "int32", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 29, "min": 1, "max": 29, "mean": 1.0927, "stddev": 0.7066}
- {"column": "payment_type", "type": "string", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 5, "top_values": [{"value": "credit_card", "count": 76795}, {"value": "boleto", "count": 19784}, {"value": "voucher", "count": 5775}, {"value": "debit_card", "count": 1529}, {"value": "not_defined", "count": 3}]}
- {"column": "installments", "type": "int32", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 24, "min": 0, "max": 24, "mean": 2.8533, "stddev": 2.687}
- {"column": "payment_value", "type": "decimal(12, 2)", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 29077, "min": "0.00", "max": "13664.08", "mean": 154.1004, "stddev": 217.493}
- {"column": "customer_unique_id", "type": "string", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 96095}
- {"column": "customer_state", "type": "string", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 27, "top_values": [{"value": "SP", "count": 43622}, {"value": "RJ", "count": 13527}, {"value": "MG", "count": 12102}, {"value": "RS", "count": 5668}, {"value": "PR", "count": 5262}, {"value": "SC", "count": 3754}, {"value": "BA", "count": 3610}, {"value": "DF", "count": 2204}, {"value": "GO", "count": 2112}, {"value": "ES", "count": 2107}]}
- {"column": "purchase_ts", "type": "timestamp(6)", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 98874, "min": "2016-09-04T21:15:19 00:00:00", "max": "2018-10-17T17:30:18 00:00:00"}
- {"column": "order_status", "type": "string", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 8, "top_values": [{"value": "delivered", "count": 100756}, {"value": "shipped", "count": 1166}, {"value": "canceled", "count": 664}, {"value": "unavailable", "count": 649}, {"value": "invoiced", "count": 325}, {"value": "processing", "count": 319}, {"value": "created", "count": 5}, {"value": "approved", "count": 2}]}
- {"column": "installment_band", "type": "string", "total_count": 103886, "null_count": 0, "null_percentage": 0.0, "distinct_count": 5, "top_values": [{"value": "1 (single payment)", "count": 52548}, {"value": "2-3", "count": 22874}, {"value": "4-6", "count": 16257}, {"value": "7-12", "count": 12022}, {"value": "13+", "count": 185}]}

# 关联关系

- `fct_orders`：`order_id` → `order_id`（多对一）
- `dim_customers`：`customer_unique_id` → `customer_unique_id`（多对一）
