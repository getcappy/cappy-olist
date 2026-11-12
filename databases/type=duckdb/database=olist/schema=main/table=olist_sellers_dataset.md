---
type: DuckDB Table
title: Olist Sellers Dataset
database: olist
schema: main
tags: []
---

# 描述

原始卖家表，一行一个卖家（共 3,095 行）。表名、列名与 Kaggle CSV 完全一致，**未做任何处理**。

- `seller_state` / `seller_city` 是卖家所在地。
- 与订单商品关联用 `olist_order_items_dataset.seller_id = olist_sellers_dataset.seller_id`。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 3,095 |
| **Column Count** | 4 |

| Column | Type | Description |
|--------|------|-------------|
| `seller_id` | string |  |
| `seller_zip_code_prefix` | string |  |
| `seller_city` | string |  |
| `seller_state` | string |  |

# 数据采样

| seller_id | seller_zip_code_prefix | seller_city | seller_state |
| --- | --- | --- | --- |
| 3442f8959a84dea7ee197c632cb2df15 | 13023 | campinas | SP |
| d1b65fc7debc3361ea86b5f14c68d2e2 | 13844 | mogi guacu | SP |
| ce3ad9de960102d0677a81f5d0bb7b2d | 20031 | rio de janeiro | RJ |
| c0f3eea2e14555b6faeea3dd58c1b1c3 | 04195 | sao paulo | SP |
| 51a04a8a6bdcb23deccc82b0b80742cf | 12914 | braganca paulista | SP |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T12:21:05.392193+00:00`

**Columns:** 4

## Column Profiles (JSONL)

- {"column": "seller_id", "type": "string", "total_count": 3095, "null_count": 0, "null_percentage": 0.0, "distinct_count": 3095}
- {"column": "seller_zip_code_prefix", "type": "string", "total_count": 3095, "null_count": 0, "null_percentage": 0.0, "distinct_count": 2246}
- {"column": "seller_city", "type": "string", "total_count": 3095, "null_count": 0, "null_percentage": 0.0, "distinct_count": 611}
- {"column": "seller_state", "type": "string", "total_count": 3095, "null_count": 0, "null_percentage": 0.0, "distinct_count": 23, "top_values": [{"value": "SP", "count": 1849}, {"value": "PR", "count": 349}, {"value": "MG", "count": 244}, {"value": "SC", "count": 190}, {"value": "RJ", "count": 171}, {"value": "RS", "count": 129}, {"value": "GO", "count": 40}, {"value": "DF", "count": 30}, {"value": "ES", "count": 23}, {"value": "BA", "count": 19}]}

# 关联关系

- `olist_order_items_dataset`：`seller_id` → `seller_id`（一对多）
- `olist_geolocation_dataset`：`seller_zip_code_prefix` → `geolocation_zip_code_prefix`（多对多，先聚合）
