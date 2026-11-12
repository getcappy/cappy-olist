---
type: DuckDB Table
title: Olist Products Dataset
database: olist
schema: main
tags: []
---

# 描述

原始商品表，一行一个商品（共 32,951 行）。表名、列名与 Kaggle CSV 完全一致，**未做任何处理**；列名保留源文件拼写（如 `product_name_lenght`、`product_description_lenght`）。

- `product_category_name` 是葡语类目名，有 610 个商品为空；英文类目需要 join `product_category_name_translation`。
- `product_weight_g`、`product_length_cm`、`product_height_cm`、`product_width_cm` 可能为空。
- 与订单商品关联用 `product_id`。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 32,951 |
| **Column Count** | 9 |

| Column | Type | Description |
|--------|------|-------------|
| `product_id` | string |  |
| `product_category_name` | string |  |
| `product_name_lenght` | int32 |  |
| `product_description_lenght` | int32 |  |
| `product_photos_qty` | int32 |  |
| `product_weight_g` | int32 |  |
| `product_length_cm` | int32 |  |
| `product_height_cm` | int32 |  |
| `product_width_cm` | int32 |  |

# 数据采样

| product_id | product_category_name | product_name_lenght | product_description_lenght | product_photos_qty | product_weight_g | product_length_cm | product_height_cm | product_width_cm |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1e9e8ef04dbcff4541ed26657ea517e5 | perfumaria | 40 | 287 | 1 | 225 | 16 | 10 | 14 |
| 3aa071139cb16b67ca9e5dea641aaa2f | artes | 44 | 276 | 1 | 1000 | 30 | 18 | 20 |
| 96bd76ec8810374ed1b65e291975717f | esporte_lazer | 46 | 250 | 1 | 154 | 18 | 9 | 15 |
| cef67bcfe19066a932b7673e239eb23d | bebes | 27 | 261 | 1 | 371 | 26 | 4 | 26 |
| 9dc1a7de274444849c219cff195d0b71 | utilidades_domesticas | 37 | 402 | 4 | 625 | 20 | 17 | 13 |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T12:21:05.381392+00:00`

**Columns:** 9

## Column Profiles (JSONL)

- {"column": "product_id", "type": "string", "total_count": 32951, "null_count": 0, "null_percentage": 0.0, "distinct_count": 32951}
- {"column": "product_category_name", "type": "string", "total_count": 32951, "null_count": 610, "null_percentage": 1.85, "distinct_count": 73}
- {"column": "product_name_lenght", "type": "int32", "total_count": 32951, "null_count": 610, "null_percentage": 1.85, "distinct_count": 66, "min": 5, "max": 76, "mean": 48.4769, "stddev": 10.2456}
- {"column": "product_description_lenght", "type": "int32", "total_count": 32951, "null_count": 610, "null_percentage": 1.85, "distinct_count": 2960, "min": 4, "max": 3992, "mean": 771.4953, "stddev": 635.1054}
- {"column": "product_photos_qty", "type": "int32", "total_count": 32951, "null_count": 610, "null_percentage": 1.85, "distinct_count": 19, "min": 1, "max": 20, "mean": 2.189, "stddev": 1.7367}
- {"column": "product_weight_g", "type": "int32", "total_count": 32951, "null_count": 2, "null_percentage": 0.01, "distinct_count": 2204, "min": 0, "max": 40425, "mean": 2276.4725, "stddev": 4281.9738}
- {"column": "product_length_cm", "type": "int32", "total_count": 32951, "null_count": 2, "null_percentage": 0.01, "distinct_count": 99, "min": 7, "max": 105, "mean": 30.8151, "stddev": 16.9142}
- {"column": "product_height_cm", "type": "int32", "total_count": 32951, "null_count": 2, "null_percentage": 0.01, "distinct_count": 102, "min": 2, "max": 105, "mean": 16.9377, "stddev": 13.6373}
- {"column": "product_width_cm", "type": "int32", "total_count": 32951, "null_count": 2, "null_percentage": 0.01, "distinct_count": 95, "min": 6, "max": 118, "mean": 23.1967, "stddev": 12.0789}

# 关联关系

- `olist_order_items_dataset`：`product_id` → `product_id`（一对多）
- `product_category_name_translation`：`product_category_name` → `product_category_name`（多对一）
