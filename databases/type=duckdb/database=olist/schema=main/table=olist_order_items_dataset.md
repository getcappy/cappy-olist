---
type: DuckDB Table
title: Olist Order Items Dataset
database: olist
schema: main
tags: []
---

# 描述

原始订单商品表，一行一个订单商品（`order_id + order_item_id`，共 112,650 行）。表名、列名与 Kaggle CSV 完全一致，**未做任何处理**。

- `price` 是商品单价，`freight_value` 是运费；订单金额 = 同一 `order_id` 下所有 `price + freight_value` 之和。
- 一个订单可能有多行商品；直接 join `olist_orders_dataset` 后再 `SUM(price)` 会把订单金额按行数放大，必须先聚合到 `order_id`。
- `product_id` 关联 `olist_products_dataset`，`seller_id` 关联 `olist_sellers_dataset`；1,603 行商品无法匹配到类目。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 112,650 |
| **Column Count** | 7 |

| Column | Type | Description |
|--------|------|-------------|
| `order_id` | string |  |
| `order_item_id` | int32 |  |
| `product_id` | string |  |
| `seller_id` | string |  |
| `shipping_limit_date` | timestamp(6) |  |
| `price` | decimal(12, 2) |  |
| `freight_value` | decimal(12, 2) |  |

# 数据采样

| order_id | order_item_id | product_id | seller_id | shipping_limit_date | price | freight_value |
| --- | --- | --- | --- | --- | --- | --- |
| 00010242fe8c5a6d1ba2dd792cb16214 | 1 | 4244733e06e7ecb4970a6e2683c13e61 | 48436dade18ac8b2bce089ec2a041202 | 2017-09-19 09:45:35 | 58.90 | 13.29 |
| 00018f77f2f0320c557190d7a144bdd3 | 1 | e5f2d52b802189ee658865ca93d83a8f | dd7ddc04e1b6c2c614352b383efe2d36 | 2017-05-03 11:05:13 | 239.90 | 19.93 |
| 000229ec398224ef6ca0657da4fc703e | 1 | c777355d18b72b67abbeef9df44fd0fd | 5b51032eddd242adc84c38acab88f23d | 2018-01-18 14:48:30 | 199.00 | 17.87 |
| 00024acbcdf0a6daa1e931b038114c75 | 1 | 7634da152a4610f1595efa32f14722fc | 9d7a1d34a5052409006425275ba1c2b4 | 2018-08-15 10:10:18 | 12.99 | 12.79 |
| 00042b26cf59d7ce69dfabb4e55b4fd9 | 1 | ac6c3623068f30de03045865e4e10089 | df560393f3a51e74553ab94004ba5c87 | 2017-02-13 13:57:51 | 199.90 | 18.14 |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T12:21:05.246250+00:00`

**Columns:** 7

## Column Profiles (JSONL)

- {"column": "order_id", "type": "string", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 98666}
- {"column": "order_item_id", "type": "int32", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 21, "top_values": [{"value": 1, "count": 98666}, {"value": 2, "count": 9803}, {"value": 3, "count": 2287}, {"value": 4, "count": 965}, {"value": 5, "count": 460}, {"value": 6, "count": 256}, {"value": 7, "count": 58}, {"value": 8, "count": 36}, {"value": 9, "count": 28}, {"value": 10, "count": 25}]}
- {"column": "product_id", "type": "string", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 32951}
- {"column": "seller_id", "type": "string", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 3095}
- {"column": "shipping_limit_date", "type": "timestamp(6)", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 93318, "min": "2016-09-19T00:15:34 00:00:00", "max": "2020-04-09T22:35:08 00:00:00"}
- {"column": "price", "type": "decimal(12, 2)", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 5968, "min": "0.85", "max": "6735.00", "mean": 120.6537, "stddev": 183.6331}
- {"column": "freight_value", "type": "decimal(12, 2)", "total_count": 112650, "null_count": 0, "null_percentage": 0.0, "distinct_count": 6999, "min": "0.00", "max": "409.68", "mean": 19.9903, "stddev": 15.8063}

# 关联关系

- `olist_orders_dataset`：`order_id` → `order_id`（多对一）
- `olist_products_dataset`：`product_id` → `product_id`（多对一）
- `olist_sellers_dataset`：`seller_id` → `seller_id`（多对一）
