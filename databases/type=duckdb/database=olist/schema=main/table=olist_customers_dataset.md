---
type: DuckDB Table
title: Olist Customers Dataset
database: olist
schema: main
tags: []
---

# 描述

原始客户表，一行一个订单对应的客户记录（共 99,441 行）。表名、列名与 Kaggle CSV 完全一致，**未做任何处理**。

- `customer_id` 是"每笔订单一个"的键，**不是客户唯一键**；统计客户必须用 `customer_unique_id`（96,096 个）。
- `customer_state` / `customer_city` 是订单收货地址的州/城市，可直接用于地域分析。
- 要与订单关联时用 `customer_id`；客户级聚合要先按 `customer_unique_id` 去重/汇总。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 99,441 |
| **Column Count** | 5 |

| Column | Type | Description |
|--------|------|-------------|
| `customer_id` | string |  |
| `customer_unique_id` | string |  |
| `customer_zip_code_prefix` | string |  |
| `customer_city` | string |  |
| `customer_state` | string |  |

# 数据采样

| customer_id | customer_unique_id | customer_zip_code_prefix | customer_city | customer_state |
| --- | --- | --- | --- | --- |
| 06b8999e2fba1a1fbc88172c00ba8bc7 | 861eff4711a542e4b93843c6dd7febb0 | 14409 | franca | SP |
| 18955e83d337fd6b2def6b18a428ac77 | 290c77bc529b7ac935b93aa66c333dc3 | 09790 | sao bernardo do campo | SP |
| 4e7b3e00288586ebd08712fdd0374a03 | 060e732b5b29e8181a18229c7b0b2b5e | 01151 | sao paulo | SP |
| b2b6027bc5c5109e529d4dc6358b12c3 | 259dac757896d24d7702b9acbbff3f3c | 08775 | mogi das cruzes | SP |
| 4f2d8ab171c80ec8364f7c12e35b23ad | 345ecd01c38d18a9036ed96c73b8d066 | 13056 | campinas | SP |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T12:21:05.158536+00:00`

**Columns:** 5

## Column Profiles (JSONL)

- {"column": "customer_id", "type": "string", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 99441}
- {"column": "customer_unique_id", "type": "string", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 96096}
- {"column": "customer_zip_code_prefix", "type": "string", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 14994}
- {"column": "customer_city", "type": "string", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 4119}
- {"column": "customer_state", "type": "string", "total_count": 99441, "null_count": 0, "null_percentage": 0.0, "distinct_count": 27, "top_values": [{"value": "SP", "count": 41746}, {"value": "RJ", "count": 12852}, {"value": "MG", "count": 11635}, {"value": "RS", "count": 5466}, {"value": "PR", "count": 5045}, {"value": "SC", "count": 3637}, {"value": "BA", "count": 3380}, {"value": "DF", "count": 2140}, {"value": "ES", "count": 2033}, {"value": "GO", "count": 2020}]}

# 关联关系

- `olist_orders_dataset`：`customer_id` → `customer_id`（一对多）
- `olist_geolocation_dataset`：`customer_zip_code_prefix` → `geolocation_zip_code_prefix`（多对多，先按邮编聚合）
