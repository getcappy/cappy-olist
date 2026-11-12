---
type: DuckDB Table
title: Fct Orders
database: olist
schema: main
tags: []
---

# 描述

订单粒度事实表：一行一个订单（`order_id` 唯一，共 99,441 行）。金额单位均为巴西雷亚尔（BRL）。

- 已把商品金额、运费、支付合计、评价分数、交付时长和是否延迟聚合到订单粒度，避免分析时重复 join 明细造成金额翻倍。
- `gmv = merchandise_value + freight_value`；`payment_value` 来自支付流水，可能因分期、优惠券或拆分支付与 `gmv` 略有差异。
- 约 775 个订单没有商品明细（多为 canceled / unavailable），这些订单的 `item_count = 0`、`gmv = 0`。
- `review_score` 为空表示该订单没有评价；`delivery_days` / `is_late` 只对已送达订单有值。
- 时间范围 2016-09-04 至 2018-10-17，其中 2018-09 起数据明显不完整，做趋势分析时要剔除尾部月份。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 99,441 |
| **Column Count** | 22 |

| Column | Type | Description |
|--------|------|-------------|
| `order_id` | string |  |
| `customer_unique_id` | string |  |
| `order_status` | string |  |
| `customer_state` | string |  |
| `customer_city` | string |  |
| `purchase_ts` | timestamp(6) |  |
| `approved_ts` | timestamp(6) |  |
| `delivered_customer_ts` | timestamp(6) |  |
| `estimated_delivery_ts` | timestamp(6) |  |
| `item_count` | int64 |  |
| `seller_count` | int64 |  |
| `merchandise_value` | decimal(38, 2) |  |
| `freight_value` | decimal(38, 2) |  |
| `gmv` | decimal(38, 2) |  |
| `payment_value` | decimal(38, 2) |  |
| `max_installments` | int32 |  |
| `review_score` | int32 |  |
| `delivery_days` | int64 |  |
| `is_late` | boolean |  |
| `is_delivered` | boolean |  |
| `is_canceled` | boolean |  |
| `has_items` | boolean |  |

# 数据采样

| order_id | customer_unique_id | order_status | customer_state | customer_city | purchase_ts | approved_ts | delivered_customer_ts | estimated_delivery_ts | item_count | seller_count | merchandise_value | freight_value | gmv | payment_value | max_installments | review_score | delivery_days | is_late | is_delivered | is_canceled | has_items |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| e481f51cbdc54678b7cc49136f2d6af7 | 7c396fd4830fd04220f754e42b4e5bff | delivered | SP | sao paulo | 2017-10-02 10:56:33 | 2017-10-02 11:07:15 | 2017-10-10 21:25:13 | 2017-10-18 00:00:00 | 1 | 1 | 29.99 | 8.72 | 38.71 | 38.71 | 1 | 4 | 8 | False | True | False | True |
| 53cdb2fc8bc7dce0b6741e2150273451 | af07308b275d755c9edb36a90c618231 | delivered | BA | barreiras | 2018-07-24 20:41:37 | 2018-07-26 03:24:27 | 2018-08-07 15:27:45 | 2018-08-13 00:00:00 | 1 | 1 | 118.70 | 22.76 | 141.46 | 141.46 | 1 | 4 | 14 | False | True | False | True |
| 47770eb9100c2d0c44946d9cf07ec65d | 3a653a41f6f9fc3d2a113cf8398680e8 | delivered | GO | vianopolis | 2018-08-08 08:38:49 | 2018-08-08 08:55:23 | 2018-08-17 18:06:29 | 2018-09-04 00:00:00 | 1 | 1 | 159.90 | 19.22 | 179.12 | 179.12 | 3 | 5 | 9 | False | True | False | True |
| ad21c59c0840e6cb83a9ceb5573f8159 | 72632f0f9dd73dfee390c9b22eb56dd6 | delivered | SP | santo andre | 2018-02-13 21:18:39 | 2018-02-13 22:20:29 | 2018-02-16 18:17:02 | 2018-02-26 00:00:00 | 1 | 1 | 19.90 | 8.72 | 28.62 | 28.62 | 1 | 5 | 3 | False | True | False | True |
| a4591c265e18cb1dcee52889e2d8acc3 | 80bb27c7c16e8f973207a5086ab329e2 | delivered | PR | congonhinhas | 2017-07-09 21:57:05 | 2017-07-09 22:10:13 | 2017-07-26 10:57:55 | 2017-08-01 00:00:00 | 1 | 1 | 147.90 | 27.36 | 175.26 | 175.26 | 6 | 4 | 17 | False | True | False | True |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T09:50:35.558326+00:00`

**Columns:** 22

## Column Profiles (JSONL)

- {"column": "order_id", "type": "string", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 99441}
- {"column": "customer_unique_id", "type": "string", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 96096}
- {"column": "order_status", "type": "string", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 8, "top_values": [{"value": "delivered", "count": 96478}, {"value": "shipped", "count": 1107}, {"value": "canceled", "count": 625}, {"value": "unavailable", "count": 609}, {"value": "invoiced", "count": 314}, {"value": "processing", "count": 301}, {"value": "created", "count": 5}, {"value": "approved", "count": 2}]}
- {"column": "customer_state", "type": "string", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 27, "top_values": [{"value": "SP", "count": 41746}, {"value": "RJ", "count": 12852}, {"value": "MG", "count": 11635}, {"value": "RS", "count": 5466}, {"value": "PR", "count": 5045}, {"value": "SC", "count": 3637}, {"value": "BA", "count": 3380}, {"value": "DF", "count": 2140}, {"value": "ES", "count": 2033}, {"value": "GO", "count": 2020}]}
- {"column": "customer_city", "type": "string", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 4119}
- {"column": "purchase_ts", "type": "timestamp(6)", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 98875, "min": "2016-09-04T21:15:19 00:00:00", "max": "2018-10-17T17:30:18 00:00:00"}
- {"column": "approved_ts", "type": "timestamp(6)", "total_count": 99441, "null_count": 160, "null_percentage": 0.16, "distinct_count": 90733, "min": "2016-09-15T12:16:38 00:00:00", "max": "2018-09-03T17:40:06 00:00:00"}
- {"column": "delivered_customer_ts", "type": "timestamp(6)", "total_count": 99441, "null_count": 2965, "null_percentage": 2.98, "distinct_count": 95664, "min": "2016-10-11T13:46:32 00:00:00", "max": "2018-10-17T13:22:46 00:00:00"}
- {"column": "estimated_delivery_ts", "type": "timestamp(6)", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 459, "min": "2016-09-30T00:00:00 00:00:00", "max": "2018-11-12T00:00:00 00:00:00"}
- {"column": "item_count", "type": "int64", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 18, "min": 0, "max": 21, "mean": 1.1328, "stddev": 0.5457}
- {"column": "seller_count", "type": "int64", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 6, "min": 0, "max": 5, "mean": 1.0057, "stddev": 0.1509}
- {"column": "merchandise_value", "type": "decimal(38, 2)", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 7559, "min": "0.00", "max": "13440.00", "mean": 136.6805, "stddev": 210.171}
- {"column": "freight_value", "type": "decimal(38, 2)", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 7560, "min": "0.00", "max": "1794.96", "mean": 22.6457, "stddev": 21.6595}
- {"column": "gmv", "type": "decimal(38, 2)", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 27376, "min": "0.00", "max": "13664.08", "mean": 159.3262, "stddev": 220.0577}
- {"column": "payment_value", "type": "decimal(38, 2)", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 27540, "min": "0.00", "max": "13664.08", "mean": 160.9886, "stddev": 221.9496}
- {"column": "max_installments", "type": "int32", "total_count": 99441, "null_count": 1, "null_percentage": 0.0, "distinct_count": 24, "min": 0, "max": 24, "mean": 2.9305, "stddev": 2.7157}
- {"column": "review_score", "type": "int32", "total_count": 99441, "null_count": 768, "null_percentage": 0.77, "distinct_count": 5, "min": 1, "max": 5, "mean": 4.0864, "stddev": 1.3476}
- {"column": "delivery_days", "type": "int64", "total_count": 99441, "null_count": 2971, "null_percentage": 2.99, "distinct_count": 144, "min": 0, "max": 210, "mean": 12.4968, "stddev": 9.555}
- {"column": "is_late", "type": "boolean", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 2, "top_values": [{"value": false, "count": 91615}, {"value": true, "count": 7826}]}
- {"column": "is_delivered", "type": "boolean", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 2, "top_values": [{"value": true, "count": 96478}, {"value": false, "count": 2963}]}
- {"column": "is_canceled", "type": "boolean", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 2, "top_values": [{"value": false, "count": 98816}, {"value": true, "count": 625}]}
- {"column": "has_items", "type": "boolean", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 2, "top_values": [{"value": true, "count": 98666}, {"value": false, "count": 775}]}

# 关联关系

- `dim_customers`：`customer_unique_id` → `customer_unique_id`（多对一）
- `fct_order_items`：`order_id` → `order_id`（一对多）
- `fct_payments`：`order_id` → `order_id`（一对多）
- `fct_reviews`：`order_id` → `order_id`（一对一）
- `dim_geolocation`：客户邮编 `zip_code_prefix` → `zip_code_prefix`（多对一）
