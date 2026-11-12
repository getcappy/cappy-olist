---
type: DuckDB Table
title: Olist Geolocation Dataset
database: olist
schema: main
tags: []
---

# 描述

原始地理位置表，一行一条邮编坐标记录（共 1,000,163 行）。表名、列名与 Kaggle CSV 完全一致，**未做任何处理**。

- 同一个 `geolocation_zip_code_prefix` 有多条记录，经纬度、城市名、州名可能不一致；同一邮编可能有 5 种城市拼写，个别邮编跨 2 个州。
- 做地图分析前先按邮编聚合：`AVG(geolocation_lat)`、`AVG(geolocation_lng)`；城市/州可 `ANY_VALUE` 或取众数，仅作标签参考。
- 邮编前缀可关联 `olist_customers_dataset.customer_zip_code_prefix` 和 `olist_sellers_dataset.seller_zip_code_prefix`；州级业务分析优先用客户/卖家表里的 `customer_state` / `seller_state`，不要依赖本表。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 1,000,163 |
| **Column Count** | 5 |

| Column | Type | Description |
|--------|------|-------------|
| `geolocation_zip_code_prefix` | string |  |
| `geolocation_lat` | float64 |  |
| `geolocation_lng` | float64 |  |
| `geolocation_city` | string |  |
| `geolocation_state` | string |  |

# 数据采样

| geolocation_zip_code_prefix | geolocation_lat | geolocation_lng | geolocation_city | geolocation_state |
| --- | --- | --- | --- | --- |
| 01037 | -23.54562128115268 | -46.63929204800168 | sao paulo | SP |
| 01046 | -23.546081127035535 | -46.64482029837157 | sao paulo | SP |
| 01046 | -23.54612896641469 | -46.64295148361138 | sao paulo | SP |
| 01041 | -23.5443921648681 | -46.63949930627844 | sao paulo | SP |
| 01035 | -23.541577961711493 | -46.64160722329613 | sao paulo | SP |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T12:21:05.211876+00:00`

**Columns:** 5

## Column Profiles (JSONL)

- {"column": "geolocation_zip_code_prefix", "type": "string", "total_count": 1000163, "null_count": 0, "null_percentage": 0.0, "distinct_count": 19015}
- {"column": "geolocation_lat", "type": "float64", "total_count": 1000163, "null_count": 0, "null_percentage": 0.0, "distinct_count": 717372, "min": -36.6053744107061, "max": 45.06593318269697, "mean": -21.1762, "stddev": 5.7159}
- {"column": "geolocation_lng", "type": "float64", "total_count": 1000163, "null_count": 0, "null_percentage": 0.0, "distinct_count": 717615, "min": -101.46676644931476, "max": 121.10539381057764, "mean": -46.3905, "stddev": 4.2697}
- {"column": "geolocation_city", "type": "string", "total_count": 1000163, "null_count": 0, "null_percentage": 0.0, "distinct_count": 8011}
- {"column": "geolocation_state", "type": "string", "total_count": 1000163, "null_count": 0, "null_percentage": 0.0, "distinct_count": 27, "top_values": [{"value": "SP", "count": 404268}, {"value": "MG", "count": 126336}, {"value": "RJ", "count": 121169}, {"value": "RS", "count": 61851}, {"value": "PR", "count": 57859}, {"value": "SC", "count": 38328}, {"value": "BA", "count": 36045}, {"value": "GO", "count": 20139}, {"value": "ES", "count": 16748}, {"value": "PE", "count": 16432}]}

# 关联关系

- `olist_customers_dataset` / `olist_sellers_dataset`：`geolocation_zip_code_prefix` → 对应 `zip_code_prefix`（一对多，先按邮编聚合）
