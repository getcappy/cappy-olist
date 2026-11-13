---
type: DuckDB Table
title: Olist Order Reviews Dataset
description: the reviews made by the customers.
---

# 描述

客户从 Olist 商店购买产品后，卖家会收到履约该订单的通知。当客户收到商品，或预计送达日期到期时，客户会通过电子邮件收到一份满意度调查问卷，可以在其中为此次购物体验打分并写下一些评论。

- 同一个 `order_id` 可能有多条评价；计算平均评分/评价数前必须按订单去重，通常保留 `review_answer_timestamp` 最新的一条。
- `review_score` 为 1-5 分；5分最高；评论标题和正文可能为空。
- 有的订单没有评价；空评分不要计入平均。

# 表结构

| Column | Type | Description |
|--------|------|-------------|
| `review_id` | string | unique review identifier  |
| `order_id` | string | unique order identifier |
| `review_score` | int32 | Note ranging from 1 to 5 given by the customer on a satisfaction survey. |
| `review_comment_title` | string | Comment title from the review left by the customer, in Portuguese. |
| `review_comment_message` | string | Comment message from the review left by the customer, in Portuguese. |
| `review_creation_date` | timestamp(6) | Shows the date in which the satisfaction survey was sent to the customer. |
| `review_answer_timestamp` | timestamp(6) | Shows satisfaction survey answer timestamp. |

# 数据采样

| review_id | order_id | review_score | review_comment_title | review_comment_message | review_creation_date | review_answer_timestamp |
| --- | --- | --- | --- | --- | --- | --- |
| 7bc2406110b926393aa56f80a40eba40 | 73fc7af87114b39712e6da79b0a377eb | 4 |  |  | 2018-01-18 00:00:00 | 2018-01-18 21:46:59 |
| 80e641a11e56f04c1ad469d5645fdfde | a548910a1c6147796b98fdf73dbeba33 | 5 |  |  | 2018-03-10 00:00:00 | 2018-03-11 03:05:13 |
| 228ce5500dc1d8e020d8d1322874b6f0 | f9e4b658b201a9f2ecdecbb34bed034b | 5 |  |  | 2018-02-17 00:00:00 | 2018-02-18 14:36:24 |
| e64fb393e7b32834bb789ff8bb30750e | 658677c97b385a9be170737859d3511b | 5 |  | Recebi bem antes do prazo estipulado. | 2017-04-21 00:00:00 | 2017-04-21 22:02:06 |
| f7c4243c7fe1938f181bec41a392bdeb | 8e6bfb81e283fa7e4f11123a3fb894f1 | 5 |  | Parabéns lojas lannister adorei comprar pela Internet seguro e prático Parabéns a todos feliz Páscoa | 2018-03-01 00:00:00 | 2018-03-02 10:26:53 |

# 关联关系

本表一行一条评价（原始数据，同一订单可能多条）。以下关系均从本表出发：

- [olist_orders_dataset](table=olist_orders_dataset.md)：本表 `order_id` → 对方 `order_id`。**多对一**：本表多行（同一订单的多条评价）对应对方一行（一个订单）；先按订单去重再聚合。
