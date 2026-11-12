---
type: DuckDB Table
title: Olist Order Reviews Dataset
database: olist
schema: main
tags: []
---

# 描述

原始评价表，一行一条评价（共 99,224 行）。表名、列名与 Kaggle CSV 完全一致，**未做任何处理**。

- 同一个 `order_id` 可能有多条评价；计算平均评分/评价数前必须按订单去重，通常保留 `review_answer_timestamp` 最新的一条。
- `review_score` 为 1-5 分；评论标题和正文可能为空。
- 768 个订单没有评价；空评分不要计入平均。

# 表结构

| Property | Value |
|----------|-------|
| **Row Count** | 99,224 |
| **Column Count** | 7 |

| Column | Type | Description |
|--------|------|-------------|
| `review_id` | string |  |
| `order_id` | string |  |
| `review_score` | int32 |  |
| `review_comment_title` | string |  |
| `review_comment_message` | string |  |
| `review_creation_date` | timestamp(6) |  |
| `review_answer_timestamp` | timestamp(6) |  |

# 数据采样

| review_id | order_id | review_score | review_comment_title | review_comment_message | review_creation_date | review_answer_timestamp |
| --- | --- | --- | --- | --- | --- | --- |
| 7bc2406110b926393aa56f80a40eba40 | 73fc7af87114b39712e6da79b0a377eb | 4 |  |  | 2018-01-18 00:00:00 | 2018-01-18 21:46:59 |
| 80e641a11e56f04c1ad469d5645fdfde | a548910a1c6147796b98fdf73dbeba33 | 5 |  |  | 2018-03-10 00:00:00 | 2018-03-11 03:05:13 |
| 228ce5500dc1d8e020d8d1322874b6f0 | f9e4b658b201a9f2ecdecbb34bed034b | 5 |  |  | 2018-02-17 00:00:00 | 2018-02-18 14:36:24 |
| e64fb393e7b32834bb789ff8bb30750e | 658677c97b385a9be170737859d3511b | 5 |  | Recebi bem antes do prazo estipulado. | 2017-04-21 00:00:00 | 2017-04-21 22:02:06 |
| f7c4243c7fe1938f181bec41a392bdeb | 8e6bfb81e283fa7e4f11123a3fb894f1 | 5 |  | Parabéns lojas lannister adorei comprar pela Internet seguro e prático Parabéns a todos feliz Páscoa | 2018-03-01 00:00:00 | 2018-03-02 10:26:53 |

# 数据剖析

**Dataset:** `main`

**Computed at:** `2026-11-12T12:21:05.314859+00:00`

**Columns:** 7

## Column Profiles (JSONL)

- {"column": "review_id", "type": "string", "total_count": 99224, "null_count": 0, "null_percentage": 0.0, "distinct_count": 98410}
- {"column": "order_id", "type": "string", "total_count": 99224, "null_count": 0, "null_percentage": 0.0, "distinct_count": 98673}
- {"column": "review_score", "type": "int32", "total_count": 99224, "null_count": 0, "null_percentage": 0.0, "distinct_count": 5, "min": 1, "max": 5, "mean": 4.0864, "stddev": 1.3476}
- {"column": "review_comment_title", "type": "string", "total_count": 99224, "null_count": 87656, "null_percentage": 88.34, "distinct_count": 4527}
- {"column": "review_comment_message", "type": "string", "total_count": 99224, "null_count": 58247, "null_percentage": 58.7, "distinct_count": 36159}
- {"column": "review_creation_date", "type": "timestamp(6)", "total_count": 99224, "null_count": 0, "null_percentage": 0.0, "distinct_count": 636, "min": "2016-10-02T00:00:00 00:00:00", "max": "2018-08-31T00:00:00 00:00:00"}
- {"column": "review_answer_timestamp", "type": "timestamp(6)", "total_count": 99224, "null_count": 0, "null_percentage": 0.0, "distinct_count": 98248, "min": "2016-10-07T18:32:28 00:00:00", "max": "2018-10-29T12:27:35 00:00:00"}

# 关联关系

- `olist_orders_dataset`：`order_id` → `order_id`（多对一，需按订单去重）
