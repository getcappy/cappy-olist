---
type: DuckDB Table
title: Dim Sellers
database: olist
schema: main
tags: []
---

# 描述

卖家维度表：一行一个 `seller_id`（共 3,095 行）。

- 卖家主要集中在 SP（1,849 家）、PR、MG、SC、RJ。
- `first_seen_ts` 是该卖家第一次产生销售的时间，从未售出的卖家为空。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 3,095 |
| **Column Count** | 5 |

| Column | Type | Description |
|--------|------|-------------|
| `seller_id` | string |  |
| `seller_state` | string |  |
| `seller_city` | string |  |
| `zip_code_prefix` | string |  |
| `first_seen_ts` | timestamp(6) |  |

# 数据采样

| seller_id | seller_state | seller_city | zip_code_prefix | first_seen_ts |
| --- | --- | --- | --- | --- |
| 3442f8959a84dea7ee197c632cb2df15 | SP | campinas | 13023 | 2017-05-05 16:12:29 |
| d1b65fc7debc3361ea86b5f14c68d2e2 | SP | mogi guacu | 13844 | 2017-03-28 09:00:00 |
| ce3ad9de960102d0677a81f5d0bb7b2d | RJ | rio de janeiro | 20031 | 2018-07-30 12:20:10 |
| c0f3eea2e14555b6faeea3dd58c1b1c3 | SP | sao paulo | 04195 | 2018-08-03 00:26:04 |
| 51a04a8a6bdcb23deccc82b0b80742cf | SP | braganca paulista | 12914 | 2017-11-14 12:04:09 |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T09:38:50.630199+00:00`

**Columns:** 5

## Column Profiles (JSONL)

- {"column": "seller_id", "type": "string", "total_count": 3095, "null_count": 0, "null_percentage": 0.0, "distinct_count": 3095}
- {"column": "seller_state", "type": "string", "total_count": 3095, "null_count": 0, "null_percentage": 0.0, "distinct_count": 23, "top_values": [{"value": "SP", "count": 1849}, {"value": "PR", "count": 349}, {"value": "MG", "count": 244}, {"value": "SC", "count": 190}, {"value": "RJ", "count": 171}, {"value": "RS", "count": 129}, {"value": "GO", "count": 40}, {"value": "DF", "count": 30}, {"value": "ES", "count": 23}, {"value": "BA", "count": 19}]}
- {"column": "seller_city", "type": "string", "total_count": 3095, "null_count": 0, "null_percentage": 0.0, "distinct_count": 611}
- {"column": "zip_code_prefix", "type": "string", "total_count": 3095, "null_count": 0, "null_percentage": 0.0, "distinct_count": 2246}
- {"column": "first_seen_ts", "type": "timestamp(6)", "total_count": 3095, "null_count": 0, "null_percentage": 0.0, "distinct_count": 3094, "min": "2016-09-04T21:15:19 00:00:00", "max": "2018-08-28T09:26:43 00:00:00"}

# 关联关系

- `fct_order_items`：`seller_id` → `seller_id`（一对多）
- `dim_geolocation`：`zip_code_prefix` → `zip_code_prefix`（多对一）
