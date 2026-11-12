---
type: DuckDB Table
title: Dim Products
database: olist
schema: main
tags: []
---

# 描述

商品维度表：一行一个 `product_id`（共 32,951 行）。

- `category_pt` 为葡语类目，`category_en` 为英文类目；610 个商品没有类目，统一记为 `unknown`。
- `first_seen_ts` 是该商品第一次出现在订单中的时间，从未售出的商品为空。
- `weight_band` 按商品重量分档，可用于运费/重量分析。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 32,951 |
| **Column Count** | 10 |

| Column | Type | Description |
|--------|------|-------------|
| `product_id` | string |  |
| `category_pt` | string |  |
| `category_en` | string |  |
| `name_length` | int32 |  |
| `description_length` | int32 |  |
| `photos_qty` | int32 |  |
| `weight_g` | int32 |  |
| `volume_cm3` | int32 |  |
| `first_seen_ts` | timestamp(6) |  |
| `weight_band` | string |  |

# 数据采样

| product_id | category_pt | category_en | name_length | description_length | photos_qty | weight_g | volume_cm3 | first_seen_ts | weight_band |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1e9e8ef04dbcff4541ed26657ea517e5 | perfumaria | perfumery | 40 | 287 | 1 | 225 | 2240 | 2018-04-24 16:16:53 | < 500 g |
| 3aa071139cb16b67ca9e5dea641aaa2f | artes | art | 44 | 276 | 1 | 1000 | 10800 | 2018-01-31 18:55:36 | 500 g - 2 kg |
| 96bd76ec8810374ed1b65e291975717f | esporte_lazer | sports_leisure | 46 | 250 | 1 | 154 | 2430 | 2018-07-09 21:18:01 | < 500 g |
| cef67bcfe19066a932b7673e239eb23d | bebes | baby | 27 | 261 | 1 | 371 | 2704 | 2018-08-03 08:55:50 | < 500 g |
| 9dc1a7de274444849c219cff195d0b71 | utilidades_domesticas | housewares | 37 | 402 | 4 | 625 | 4420 | 2018-04-11 01:06:37 | 500 g - 2 kg |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T09:38:50.064163+00:00`

**Columns:** 10

## Column Profiles (JSONL)

- {"column": "product_id", "type": "string", "total_count": 32951, "null_count": 0, "null_percentage": 0.0, "distinct_count": 32951}
- {"column": "category_pt", "type": "string", "total_count": 32951, "null_count": 0, "null_percentage": 0.0, "distinct_count": 74}
- {"column": "category_en", "type": "string", "total_count": 32951, "null_count": 0, "null_percentage": 0.0, "distinct_count": 74}
- {"column": "name_length", "type": "int32", "total_count": 32951, "null_count": 610, "null_percentage": 1.85, "distinct_count": 66, "min": 5, "max": 76, "mean": 48.4769, "stddev": 10.2456}
- {"column": "description_length", "type": "int32", "total_count": 32951, "null_count": 610, "null_percentage": 1.85, "distinct_count": 2960, "min": 4, "max": 3992, "mean": 771.4953, "stddev": 635.1054}
- {"column": "photos_qty", "type": "int32", "total_count": 32951, "null_count": 610, "null_percentage": 1.85, "distinct_count": 19, "min": 1, "max": 20, "mean": 2.189, "stddev": 1.7367}
- {"column": "weight_g", "type": "int32", "total_count": 32951, "null_count": 0, "null_percentage": 0.0, "distinct_count": 2204, "min": 0, "max": 40425, "mean": 2276.3343, "stddev": 4281.8805}
- {"column": "volume_cm3", "type": "int32", "total_count": 32951, "null_count": 0, "null_percentage": 0.0, "distinct_count": 4526, "min": 0, "max": 296208, "mean": 16563.0913, "stddev": 27056.1177}
- {"column": "first_seen_ts", "type": "timestamp(6)", "total_count": 32951, "null_count": 0, "null_percentage": 0.0, "distinct_count": 31863, "min": "2016-09-04T21:15:19 00:00:00", "max": "2018-08-29T14:52:00 00:00:00"}
- {"column": "weight_band", "type": "string", "total_count": 32951, "null_count": 0, "null_percentage": 0.0, "distinct_count": 4, "top_values": [{"value": "500 g - 2 kg", "count": 12505}, {"value": "< 500 g", "count": 12466}, {"value": "2 - 10 kg", "count": 6074}, {"value": "10 kg +", "count": 1906}]}

# 关联关系

- `fct_order_items`：`product_id` → `product_id`（一对多）
