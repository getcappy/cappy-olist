---
type: DuckDB Table
title: Dim Customers
database: olist
schema: main
tags: []
---

# 描述

客户维度表：一行一个 `customer_unique_id`（共 96,096 行），适合做客户数、复购和客户价值分析。

- 原始 `customer_id` 是"每笔订单一个"的键，不能用来统计客户数；客户级分析统一使用 `customer_unique_id`。
- `order_count`、`total_gmv`、`first_order_ts`、`last_order_ts` 为该客户全部订单的聚合。
- `is_repeat_customer = order_count > 1`。全量数据中复购客户约 2,997 人（3.12%）。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 96,096 |
| **Column Count** | 10 |

| Column | Type | Description |
|--------|------|-------------|
| `customer_unique_id` | string |  |
| `customer_state` | string |  |
| `customer_city` | string |  |
| `first_order_ts` | timestamp(6) |  |
| `last_order_ts` | timestamp(6) |  |
| `order_count` | int64 |  |
| `delivered_order_count` | decimal(38, 0) |  |
| `total_gmv` | decimal(38, 2) |  |
| `avg_review_score` | float64 |  |
| `is_repeat_customer` | boolean |  |

# 数据采样

| customer_unique_id | customer_state | customer_city | first_order_ts | last_order_ts | order_count | delivered_order_count | total_gmv | avg_review_score | is_repeat_customer |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 76b029c87118a29f2e3de420f5ec2fa2 | MG | uberlandia | 2017-12-28 10:45:14 | 2017-12-28 10:45:14 | 1 | 1 | 372.52 | 5.0 | False |
| a9a77b4e25980b7ca58cb71f878abb27 | MG | itajuba | 2018-03-26 23:43:27 | 2018-03-26 23:43:27 | 1 | 1 | 59.78 | 5.0 | False |
| 4bc7250d4b42b3374eb6f41b12429592 | SP | sao paulo | 2017-02-06 16:49:19 | 2017-02-06 16:49:19 | 1 | 1 | 251.28 | 5.0 | False |
| f34cd7fd85a1f8baff886edf09567be3 | SC | timbo | 2017-08-22 12:49:28 | 2017-09-23 19:56:00 | 4 | 4 | 1236.76 | 5.0 | True |
| 184ff574579b06c07152f2ba4ae74106 | RS | caxias do sul | 2018-03-06 10:19:54 | 2018-03-06 10:19:54 | 1 | 1 | 57.13 | 1.0 | False |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T09:38:49.067126+00:00`

**Columns:** 10

## Column Profiles (JSONL)

- {"column": "customer_unique_id", "type": "string", "total_count": 96096, "null_count": 0, "null_percentage": 0.0, "distinct_count": 96096}
- {"column": "customer_state", "type": "string", "total_count": 96096, "null_count": 0, "null_percentage": 0.0, "distinct_count": 27, "top_values": [{"value": "SP", "count": 40295}, {"value": "RJ", "count": 12377}, {"value": "MG", "count": 11255}, {"value": "RS", "count": 5277}, {"value": "PR", "count": 4882}, {"value": "SC", "count": 3529}, {"value": "BA", "count": 3276}, {"value": "DF", "count": 2073}, {"value": "ES", "count": 1963}, {"value": "GO", "count": 1951}]}
- {"column": "customer_city", "type": "string", "total_count": 96096, "null_count": 0, "null_percentage": 0.0, "distinct_count": 4118}
- {"column": "first_order_ts", "type": "timestamp(6)", "total_count": 96096, "null_count": 0, "null_percentage": 0.0, "distinct_count": 95837, "min": "2016-09-04T21:15:19 00:00:00", "max": "2018-10-17T17:30:18 00:00:00"}
- {"column": "last_order_ts", "type": "timestamp(6)", "total_count": 96096, "null_count": 0, "null_percentage": 0.0, "distinct_count": 95834, "min": "2016-09-04T21:15:19 00:00:00", "max": "2018-10-17T17:30:18 00:00:00"}
- {"column": "order_count", "type": "int64", "total_count": 96096, "null_count": 0, "null_percentage": 0.0, "distinct_count": 9, "min": 1, "max": 17, "mean": 1.0348, "stddev": 0.2144}
- {"column": "delivered_order_count", "type": "decimal(38, 0)", "total_count": 96096, "null_count": 0, "null_percentage": 0.0, "distinct_count": 10, "min": 0, "max": 15, "mean": 1.004, "stddev": 0.2684}
- {"column": "total_gmv", "type": "decimal(38, 2)", "total_count": 96096, "null_count": 0, "null_percentage": 0.0, "distinct_count": 27960, "min": "0.00", "max": "13664.08", "mean": 164.8721, "stddev": 227.9375}
- {"column": "avg_review_score", "type": "float64", "total_count": 96096, "null_count": 716, "null_percentage": 0.75, "distinct_count": 26, "min": 1.0, "max": 5.0, "mean": 4.0847, "stddev": 1.3423}
- {"column": "is_repeat_customer", "type": "boolean", "total_count": 96096, "null_count": 0, "null_percentage": 0.0, "distinct_count": 2, "top_values": [{"value": false, "count": 93099}, {"value": true, "count": 2997}]}

# 关联关系

- `fct_orders`：`customer_unique_id` → `customer_unique_id`（一对多）
- `dim_geolocation`：`zip_code_prefix` → `zip_code_prefix`（多对一，本表未保留邮编列）
