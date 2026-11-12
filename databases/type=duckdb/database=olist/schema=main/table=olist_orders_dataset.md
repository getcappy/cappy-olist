---
type: DuckDB Table
title: Olist Orders Dataset
database: olist
schema: main
tags: []
---

# 描述

原始订单表，一行一个订单（`order_id` 唯一，共 99,441 行）。表名、列名与 Kaggle CSV 完全一致，**未做任何处理**。

- `order_purchase_timestamp` 是下单时间；`order_delivered_customer_date`、`order_estimated_delivery_date` 用于交付分析。
- `order_status`：delivered / shipped / canceled / unavailable / invoiced / processing / created / approved。
- `order_approved_at` 有 160 行为空，`order_delivered_customer_date` 有 2,965 行为空，交付计算要处理空值。
- 商品金额、运费、支付、评价都在各自的原始表里；先按 `order_id` 聚合明细（`olist_order_items_dataset`、`olist_order_payments_dataset`）或去重评价（`olist_order_reviews_dataset`），再与本表 join，避免金额重复计算。
- 时间范围 2016-09-04 至 2018-10-17；2018-09 之后数据明显不完整。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 99,441 |
| **Column Count** | 8 |

| Column | Type | Description |
|--------|------|-------------|
| `order_id` | string |  |
| `customer_id` | string |  |
| `order_status` | string |  |
| `order_purchase_timestamp` | timestamp(6) |  |
| `order_approved_at` | timestamp(6) |  |
| `order_delivered_carrier_date` | timestamp(6) |  |
| `order_delivered_customer_date` | timestamp(6) |  |
| `order_estimated_delivery_date` | timestamp(6) |  |

# 数据采样

| order_id | customer_id | order_status | order_purchase_timestamp | order_approved_at | order_delivered_carrier_date | order_delivered_customer_date | order_estimated_delivery_date |
| --- | --- | --- | --- | --- | --- | --- | --- |
| e481f51cbdc54678b7cc49136f2d6af7 | 9ef432eb6251297304e76186b10a928d | delivered | 2017-10-02 10:56:33 | 2017-10-02 11:07:15 | 2017-10-04 19:55:00 | 2017-10-10 21:25:13 | 2017-10-18 00:00:00 |
| 53cdb2fc8bc7dce0b6741e2150273451 | b0830fb4747a6c6d20dea0b8c802d7ef | delivered | 2018-07-24 20:41:37 | 2018-07-26 03:24:27 | 2018-07-26 14:31:00 | 2018-08-07 15:27:45 | 2018-08-13 00:00:00 |
| 47770eb9100c2d0c44946d9cf07ec65d | 41ce2a54c0b03bf3443c3d931a367089 | delivered | 2018-08-08 08:38:49 | 2018-08-08 08:55:23 | 2018-08-08 13:50:00 | 2018-08-17 18:06:29 | 2018-09-04 00:00:00 |
| 949d5b44dbf5de918fe9c16f97b45f8a | f88197465ea7920adcdbec7375364d82 | delivered | 2017-11-18 19:28:06 | 2017-11-18 19:45:59 | 2017-11-22 13:39:59 | 2017-12-02 00:28:42 | 2017-12-15 00:00:00 |
| ad21c59c0840e6cb83a9ceb5573f8159 | 8ab97904e6daea8866dbdbc4fb7aad2c | delivered | 2018-02-13 21:18:39 | 2018-02-13 22:20:29 | 2018-02-14 19:46:34 | 2018-02-16 18:17:02 | 2018-02-26 00:00:00 |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T12:21:05.360705+00:00`

**Columns:** 8

## Column Profiles (JSONL)

- {"column": "order_id", "type": "string", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 99441}
- {"column": "customer_id", "type": "string", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 99441}
- {"column": "order_status", "type": "string", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 8, "top_values": [{"value": "delivered", "count": 96478}, {"value": "shipped", "count": 1107}, {"value": "canceled", "count": 625}, {"value": "unavailable", "count": 609}, {"value": "invoiced", "count": 314}, {"value": "processing", "count": 301}, {"value": "created", "count": 5}, {"value": "approved", "count": 2}]}
- {"column": "order_purchase_timestamp", "type": "timestamp(6)", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 98875, "min": "2016-09-04T21:15:19 00:00:00", "max": "2018-10-17T17:30:18 00:00:00"}
- {"column": "order_approved_at", "type": "timestamp(6)", "total_count": 99441, "null_count": 160, "null_percentage": 0.16, "distinct_count": 90733, "min": "2016-09-15T12:16:38 00:00:00", "max": "2018-09-03T17:40:06 00:00:00"}
- {"column": "order_delivered_carrier_date", "type": "timestamp(6)", "total_count": 99441, "null_count": 1783, "null_percentage": 1.79, "distinct_count": 81018, "min": "2016-10-08T10:34:01 00:00:00", "max": "2018-09-11T19:48:28 00:00:00"}
- {"column": "order_delivered_customer_date", "type": "timestamp(6)", "total_count": 99441, "null_count": 2965, "null_percentage": 2.98, "distinct_count": 95664, "min": "2016-10-11T13:46:32 00:00:00", "max": "2018-10-17T13:22:46 00:00:00"}
- {"column": "order_estimated_delivery_date", "type": "timestamp(6)", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 459, "min": "2016-09-30T00:00:00 00:00:00", "max": "2018-11-12T00:00:00 00:00:00"}

# 关联关系

- `olist_customers_dataset`：`customer_id` → `customer_id`（多对一，`customer_id` 是每单一个）
- `olist_order_items_dataset`：`order_id` → `order_id`（一对多，先聚合再 join）
- `olist_order_payments_dataset`：`order_id` → `order_id`（一对多，先聚合再 join）
- `olist_order_reviews_dataset`：`order_id` → `order_id`（一对多，先去重再 join）
