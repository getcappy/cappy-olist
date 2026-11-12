---
type: DuckDB Table
title: Fct Reviews
database: olist
schema: main
tags: []
---

# 描述

评价粒度事实表：一行一个订单的最新评价（共 98,673 行），由原始评价表按 `order_id` 去重得到。

- 原始评价表存在同一订单多条评价的情况；本表保留 `review_answer_timestamp` 最新的一条，避免评价分数重复统计。
- `review_score` 为 1-5 分；768 个订单没有评价。
- `response_hours` 是评价创建到商家回复的小时数（可能为空）。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 98,673 |
| **Column Count** | 12 |

| Column | Type | Description |
|--------|------|-------------|
| `review_id` | string |  |
| `order_id` | string |  |
| `review_score` | int32 |  |
| `review_comment_title` | string |  |
| `review_comment_message` | string |  |
| `review_creation_ts` | timestamp(6) |  |
| `review_answer_ts` | timestamp(6) |  |
| `response_hours` | int64 |  |
| `customer_unique_id` | string |  |
| `customer_state` | string |  |
| `purchase_ts` | timestamp(6) |  |
| `order_status` | string |  |

# 数据采样

| review_id | order_id | review_score | review_comment_title | review_comment_message | review_creation_ts | review_answer_ts | response_hours | customer_unique_id | customer_state | purchase_ts | order_status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| a54f0611adc9ed256b57ede6b6eb5114 | e481f51cbdc54678b7cc49136f2d6af7 | 4 |  | Não testei o produto ainda, mas ele veio correto e em boas condições. Apenas a caixa que veio bem amassada e danificada, o que ficará chato, pois se trata de um presente. | 2017-10-11 00:00:00 | 2017-10-12 03:43:48 | 27 | 7c396fd4830fd04220f754e42b4e5bff | SP | 2017-10-02 10:56:33 | delivered |
| 8d5266042046a06655c8db133d120ba5 | 53cdb2fc8bc7dce0b6741e2150273451 | 4 | Muito boa a loja | Muito bom o produto. | 2018-08-08 00:00:00 | 2018-08-08 18:37:50 | 18 | af07308b275d755c9edb36a90c618231 | BA | 2018-07-24 20:41:37 | delivered |
| e73b67b67587f7644d5bd1a52deb1b01 | 47770eb9100c2d0c44946d9cf07ec65d | 5 |  |  | 2018-08-18 00:00:00 | 2018-08-22 19:07:58 | 115 | 3a653a41f6f9fc3d2a113cf8398680e8 | GO | 2018-08-08 08:38:49 | delivered |
| e50934924e227544ba8246aeb3770dd4 | ad21c59c0840e6cb83a9ceb5573f8159 | 5 |  |  | 2018-02-17 00:00:00 | 2018-02-18 13:02:51 | 37 | 72632f0f9dd73dfee390c9b22eb56dd6 | SP | 2018-02-13 21:18:39 | delivered |
| 89b738e70a1ce346db29a20fb2910161 | a4591c265e18cb1dcee52889e2d8acc3 | 4 |  |  | 2017-07-27 00:00:00 | 2017-07-27 22:48:30 | 22 | 80bb27c7c16e8f973207a5086ab329e2 | PR | 2017-07-09 21:57:05 | delivered |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T09:50:37.314429+00:00`

**Columns:** 12

## Column Profiles (JSONL)

- {"column": "review_id", "type": "string", "total_count": 98673, "null_count": 0, "null_percentage": 0.0, "distinct_count": 98095}
- {"column": "order_id", "type": "string", "total_count": 98673, "null_count": 0, "null_percentage": 0.0, "distinct_count": 98673}
- {"column": "review_score", "type": "int32", "total_count": 98673, "null_count": 0, "null_percentage": 0.0, "distinct_count": 5, "min": 1, "max": 5, "mean": 4.0864, "stddev": 1.3476}
- {"column": "review_comment_title", "type": "string", "total_count": 98673, "null_count": 87123, "null_percentage": 88.29, "distinct_count": 4525}
- {"column": "review_comment_message", "type": "string", "total_count": 98673, "null_count": 57898, "null_percentage": 58.68, "distinct_count": 36060}
- {"column": "review_creation_ts", "type": "timestamp(6)", "total_count": 98673, "null_count": 0, "null_percentage": 0.0, "distinct_count": 636, "min": "2016-10-02T00:00:00 00:00:00", "max": "2018-08-31T00:00:00 00:00:00"}
- {"column": "review_answer_ts", "type": "timestamp(6)", "total_count": 98673, "null_count": 0, "null_percentage": 0.0, "distinct_count": 97933, "min": "2016-10-07T18:32:28 00:00:00", "max": "2018-10-29T12:27:35 00:00:00"}
- {"column": "response_hours", "type": "int64", "total_count": 98673, "null_count": 0, "null_percentage": 0.0, "distinct_count": 1192, "min": 2, "max": 12448, "mean": 75.1601, "stddev": 237.8755}
- {"column": "customer_unique_id", "type": "string", "total_count": 98673, "null_count": 0, "null_percentage": 0.0, "distinct_count": 95380}
- {"column": "customer_state", "type": "string", "total_count": 98673, "null_count": 0, "null_percentage": 0.0, "distinct_count": 27, "top_values": [{"value": "SP", "count": 41472}, {"value": "RJ", "count": 12687}, {"value": "MG", "count": 11554}, {"value": "RS", "count": 5443}, {"value": "PR", "count": 5019}, {"value": "SC", "count": 3609}, {"value": "BA", "count": 3340}, {"value": "DF", "count": 2128}, {"value": "GO", "count": 2007}, {"value": "ES", "count": 2006}]}
- {"column": "purchase_ts", "type": "timestamp(6)", "total_count": 98673, "null_count": 0, "null_percentage": 0.0, "distinct_count": 98115, "min": "2016-09-04T21:15:19 00:00:00", "max": "2018-10-17T17:30:18 00:00:00"}
- {"column": "order_status", "type": "string", "total_count": 98673, "null_count": 0, "null_percentage": 0.0, "distinct_count": 8, "top_values": [{"value": "delivered", "count": 95832}, {"value": "shipped", "count": 1032}, {"value": "canceled", "count": 605}, {"value": "unavailable", "count": 595}, {"value": "invoiced", "count": 309}, {"value": "processing", "count": 295}, {"value": "created", "count": 3}, {"value": "approved", "count": 2}]}

# 关联关系

- `fct_orders`：`order_id` → `order_id`（一对一）
- `dim_customers`：`customer_unique_id` → `customer_unique_id`（多对一）
