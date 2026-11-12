---
type: DuckDB Table
title: Dim Geolocation
database: olist
schema: main
tags: []
---

# 描述

地理位置维度表：一行一个邮编前缀（共 19,015 行），由 1,000,163 行原始地理位置数据聚合为平均经纬度。

- 用于地图和区域分析；`zip_code_prefix` 可关联 `dim_customers.zip_code_prefix`、`dim_sellers.zip_code_prefix` 或 `fct_orders` 的客户邮编。
- 同一邮编可能跨城市/州，`city` / `state` 取众数，仅作参考。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 19,015 |
| **Column Count** | 5 |

| Column | Type | Description |
|--------|------|-------------|
| `zip_code_prefix` | string |  |
| `city` | string |  |
| `state` | string |  |
| `lat` | float64 |  |
| `lng` | float64 |  |

# 数据采样

| zip_code_prefix | city | state | lat | lng |
| --- | --- | --- | --- | --- |
| 11550 | cubatao | SP | -23.87824490292869 | -46.42656376030944 |
| 11573 | cubatao | SP | -23.883457499999995 | -46.428160500000004 |
| 11680 | ubatuba | SP | -23.45292929995693 | -45.0932194085285 |
| 11628 | sao sebastiao | SP | -23.78754820266299 | -45.562569680445975 |
| 11666 | caraguatatuba | SP | -23.666200132168953 | -45.436960616857974 |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T09:50:31.357018+00:00`

**Columns:** 5

## Column Profiles (JSONL)

- {"column": "zip_code_prefix", "type": "string", "total_count": 19015, "null_count": 0, "null_percentage": 0.0, "distinct_count": 19015}
- {"column": "city", "type": "string", "total_count": 19015, "null_count": 0, "null_percentage": 0.0, "distinct_count": 5955}
- {"column": "state", "type": "string", "total_count": 19015, "null_count": 0, "null_percentage": 0.0, "distinct_count": 27, "top_values": [{"value": "SP", "count": 6349}, {"value": "MG", "count": 1868}, {"value": "RJ", "count": 1390}, {"value": "RS", "count": 1131}, {"value": "PR", "count": 1046}, {"value": "BA", "count": 992}, {"value": "GO", "count": 773}, {"value": "SC", "count": 619}, {"value": "PE", "count": 596}, {"value": "CE", "count": 548}]}
- {"column": "lat", "type": "float64", "total_count": 19015, "null_count": 0, "null_percentage": 0.0, "distinct_count": 19003, "min": -33.689948281745096, "max": 42.18400274298598, "mean": -19.0553, "stddev": 7.2956}
- {"column": "lng", "type": "float64", "total_count": 19015, "null_count": 0, "null_percentage": 0.0, "distinct_count": 19004, "min": -72.91606928086937, "max": 121.10539381057764, "mean": -46.0576, "stddev": 5.3656}

# 关联关系

- `dim_customers` / `dim_sellers`：`zip_code_prefix` → `zip_code_prefix`（一对多）
